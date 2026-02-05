import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import 'package:stac_framework/stac_framework.dart';
import 'package:stac_logger/stac_logger.dart';
import '../../../helpers/logger.dart';
import '../../utils/registry_notifier.dart';

/// Custom network request parser that stores response data in registry
/// so that {{data.data.*}} variables can be resolved in results actions.
class CustomNetworkRequestActionParser
    extends StacActionParser<StacNetworkRequest> {
  const CustomNetworkRequestActionParser();

  @override
  String get actionType => ActionType.networkRequest.name;

  @override
  StacNetworkRequest getModel(Map<String, dynamic> json) =>
      StacNetworkRequest.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, StacNetworkRequest model) async {
    Response<dynamic>? response;

    try {
      final resolvedModel = _resolveNetworkRequestTemplates(model);
      response = await StacNetworkService.request(
        context,
        resolvedModel,
      ).timeout(const Duration(seconds: 15));
    } on TimeoutException {
      AppLogger.wc(LogCategory.network, 'Network request timed out');
      response = null; // Will trigger fallback to status code -1
    } on DioException catch (e) {
      response = e.response;
      Log.e(e.response);
    } catch (e) {
      Log.e(e);
    }

    // Store response data in registry so {{data.data.*}} variables can be resolved
    if (response?.data != null) {
      final responseData = response!.data;
      StacRegistry.instance.setValue('data', responseData);

      // Always clear old data_payload first to prevent stale data
      StacRegistry.instance.removeValue('data_payload');

      dynamic payload;
      if (responseData is Map) {
        payload = responseData['data'];
        if (payload == null && responseData['result'] is Map) {
          payload = (responseData['result'] as Map)['data'];
        }
        AppLogger.dc(
          LogCategory.network,
          '📦 Response structure: data=${responseData['data']?.runtimeType}, result=${responseData['result']?.runtimeType}',
        );
      } else if (responseData is List) {
        // If response is already an array, use it directly
        payload = responseData;
        AppLogger.dc(
          LogCategory.network,
          '📦 Response is List directly, length=${responseData.length}',
        );
      }
      if (payload != null) {
        StacRegistry.instance.setValue('data_payload', payload);
        final previewStr = payload.toString();
        AppLogger.dc(
          LogCategory.network,
          '📦 Set data_payload (${payload.runtimeType}): ${previewStr.length > 100 ? previewStr.substring(0, 100) + '...' : previewStr}',
        );
      } else {
        AppLogger.wc(
          LogCategory.network,
          '⚠️ data_payload not set - payload is null. ResponseData type: ${responseData.runtimeType}',
        );
      }

      RegistryNotifier.instance.notify();
      AppLogger.dc(
        LogCategory.network,
        'Network response data stored in registry under "data" key',
      );
    }

    final statusCode = response?.statusCode ?? -1;

    try {
      // First try to find exact match
      var result = model.results.firstWhere(
        (element) => element.statusCode == statusCode,
        orElse: () {
          // If not found, try to find fallback handler (-1)
          return model.results.firstWhere(
            (element) => element.statusCode == -1,
          );
        },
      );

      if (context.mounted) {
        // Debug: verify data_payload is still correct before calling result action
        final dpCheck = StacRegistry.instance.getValue('data_payload');
        if (dpCheck != null) {
          final preview = dpCheck.toString();
          AppLogger.dc(
            LogCategory.network,
            '🔍 Before result action: data_payload (${dpCheck.runtimeType}) = ${preview.length > 80 ? preview.substring(0, 80) + '...' : preview}',
          );
        } else {
          AppLogger.wc(LogCategory.network, '⚠️ Before result action: data_payload is NULL!');
        }
        
        // Debug: Log the action type and structure
        final action = result.action;
        AppLogger.dc(
          LogCategory.network,
          '🔍 result.action type: ${action.runtimeType}',
        );
        
        // Pre-resolve {{data_payload}} in the action JSON to prevent STAC framework 
        // from using stale cached values
        final resolvedAction = _resolveActionTemplates(action);
        AppLogger.dc(LogCategory.network, '✓ Resolved action templates');
        return Stac.onCallFromJson(resolvedAction, context);
      }
    } catch (e) {
      // No handler found (neither exact nor fallback)
      AppLogger.wc(
        LogCategory.network,
        'No result handler for status code $statusCode',
      );
    }

    return null;
  }

  StacNetworkRequest _resolveNetworkRequestTemplates(StacNetworkRequest model) {
    final resolvedUrl = _resolveTemplates(model.url);

    Map<String, String>? resolvedHeaders;
    final headers = model.headers;
    if (headers != null) {
      resolvedHeaders = headers.map((key, value) {
        return MapEntry(key, _resolveTemplates(value));
      });
    }

    if (resolvedHeaders != null) {
      final authValue = resolvedHeaders.entries
          .firstWhere(
            (e) => e.key.toLowerCase() == 'authorization',
            orElse: () => const MapEntry('', ''),
          )
          .value;
      final hasAuth = authValue.trim().isNotEmpty;
      AppLogger.dc(
        LogCategory.network,
        'STAC request headers resolved (hasAuthorization=$hasAuth): '
        '${resolvedHeaders.map((k, v) => MapEntry(k, k.toLowerCase() == 'authorization' ? '***' : v))}',
      );
    }

    return StacNetworkRequest(
      url: resolvedUrl,
      method: model.method,
      headers: resolvedHeaders,
      body: model.body,
    );
  }

  String _resolveTemplates(String input) {
    final decodedInput = _tryDecodeUriComponent(input);
    if (!decodedInput.contains('{{') || !decodedInput.contains('}}')) {
      return decodedInput;
    }

    return decodedInput.replaceAllMapped(RegExp(r'\{\{([^}]+)\}\}'), (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return match.group(0) ?? '';

      final value = StacRegistry.instance.getValue(expr);
      if (value == null) return '';
      return value.toString();
    });
  }

  String _tryDecodeUriComponent(String input) {
    try {
      // StacNetworkService may percent-encode the URL early; decode to allow {{...}} resolution.
      return Uri.decodeFull(input);
    } catch (_) {
      return input;
    }
  }

  /// Recursively resolve {{template}} placeholders in action JSON
  /// This ensures we use fresh registry values instead of stale cached ones
  Map<String, dynamic> _resolveActionTemplates(Map<String, dynamic> action) {
    return _resolveMapTemplates(action);
  }

  Map<String, dynamic> _resolveMapTemplates(Map<String, dynamic> map) {
    final result = <String, dynamic>{};
    for (final entry in map.entries) {
      result[entry.key] = _resolveValueTemplates(entry.value);
    }
    return result;
  }

  dynamic _resolveValueTemplates(dynamic value) {
    if (value is String) {
      // Log ALL string values that contain {{ to debug
      if (value.contains('{{')) {
        AppLogger.dc(
          LogCategory.network,
          '🔎 Processing template string: "$value"',
        );
      }
      
      // Check if the entire string is a single {{expr}}
      final match = RegExp(r'^{{([^}]+)}}$').firstMatch(value);
      if (match != null) {
        final expr = match.group(1)?.trim();
        if (expr != null && expr.isNotEmpty) {
          final resolved = StacRegistry.instance.getValue(expr);
          AppLogger.dc(
            LogCategory.network,
            '🔎 Resolved {{$expr}}: ${resolved != null ? resolved.runtimeType : 'NULL'}',
          );
          if (resolved != null) {
            AppLogger.dc(
              LogCategory.network,
              '✓ Resolved {{$expr}} to ${resolved.runtimeType}',
            );
            return resolved; // Return the actual value, not string
          }
        }
      }
      // For partial templates or no match, do string interpolation
      return value.replaceAllMapped(RegExp(r'\{\{([^}]+)\}\}'), (m) {
        final expr = m.group(1)?.trim();
        if (expr == null || expr.isEmpty) return m.group(0) ?? '';
        final resolved = StacRegistry.instance.getValue(expr);
        return resolved?.toString() ?? m.group(0) ?? '';
      });
    } else if (value is Map<String, dynamic>) {
      return _resolveMapTemplates(value);
    } else if (value is Map) {
      return _resolveMapTemplates(Map<String, dynamic>.from(value));
    } else if (value is List) {
      return value.map((item) => _resolveValueTemplates(item)).toList();
    }
    return value;
  }
}
