import 'dart:async';
import 'dart:convert';

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
<<<<<<< HEAD

      // Log cURL for debugging
      _logCurl(resolvedModel);

      response = await StacNetworkService.request(
        context,
        resolvedModel,
      ).timeout(const Duration(seconds: 15));
    } on TimeoutException {
      AppLogger.wc(LogCategory.network, 'Network request timed out');
      response = null; // Will trigger fallback to status code -1
=======
      response = await StacNetworkService.request(context, resolvedModel);
>>>>>>> origin/real_api_confrim_screen
    } on DioException catch (e) {
      response = e.response;
      Log.e(e.response);
    }

    // Store response data in registry so {{data.data.*}} variables can be resolved
    if (response?.data != null) {
      final responseData = response!.data;
      StacRegistry.instance.setValue('data', responseData);

      dynamic payload;
      if (responseData is Map) {
        payload = responseData['data'];
        if (payload == null && responseData['result'] is Map) {
          payload = (responseData['result'] as Map)['data'];
        }
      }
      if (payload != null) {
        StacRegistry.instance.setValue('data_payload', payload);
      }

      RegistryNotifier.instance.notify();
      AppLogger.dc(
        LogCategory.network,
        'Network response data stored in registry under "data" key',
      );
    }

<<<<<<< HEAD
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
            LogCategory.stacData,
            'Before result action: data_payload (${dpCheck.runtimeType}) = ${preview.length > 80 ? preview.substring(0, 80) + '...' : preview}',
          );
        } else {
          AppLogger.wc(
            LogCategory.stacData,
            '⚠️ Before result action: data_payload is NULL!',
          );
        }

        // Debug: Log the action type and structure
        final action = result.action;
        AppLogger.dc(
          LogCategory.stacData,
          'result.action type: ${action.runtimeType}',
        );

        // Pre-resolve {{data_payload}} in the action JSON to prevent STAC framework
        // from using stale cached values
        final resolvedAction = _resolveActionTemplates(action);
        AppLogger.dc(LogCategory.stacData, 'Resolved action templates');
        return Stac.onCallFromJson(resolvedAction, context);
=======
    if (response?.statusCode != null) {
      try {
        final result = model.results.firstWhere(
          (element) => element.statusCode == response?.statusCode,
        );

        if (context.mounted) {
          return Stac.onCallFromJson(result.action, context);
        }
      } catch (e) {
        // No matching status code found in results
        AppLogger.wc(
          LogCategory.network,
          'No result handler for status code ${response?.statusCode}',
        );
>>>>>>> origin/real_api_confrim_screen
      }
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
<<<<<<< HEAD

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
        AppLogger.dc(LogCategory.stacVariable, 'Processing template: "$value"');
      }

      // Check if the entire string is a single {{expr}}
      final match = RegExp(r'^{{([^}]+)}}$').firstMatch(value);
      if (match != null) {
        final expr = match.group(1)?.trim();
        if (expr != null && expr.isNotEmpty) {
          final resolved = StacRegistry.instance.getValue(expr);
          AppLogger.dc(
            LogCategory.stacVariable,
            'Resolved {{$expr}}: ${resolved != null ? resolved.runtimeType : 'NULL'}',
          );
          if (resolved != null) {
            AppLogger.dc(
              LogCategory.stacVariable,
              'Resolved {{$expr}} to ${resolved.runtimeType}',
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

  void _logCurl(StacNetworkRequest request) {
    try {
      String curl = 'curl --request ${request.method.name.toUpperCase()}';
      curl += ' --url "${request.url}"';

      request.headers?.forEach((key, value) {
        // Hide authorization value for security
        final safeValue = key.toLowerCase().contains('authorization')
            ? '***'
            : value;
        curl += ' -H "$key: $safeValue"';
      });

      if (request.body != null) {
        if (request.body is String) {
          curl += ' -d \'${request.body}\'';
        } else {
          curl += ' -d \'${jsonEncode(request.body)}\'';
        }
      }

      AppLogger.dc(LogCategory.network, 'CURL: $curl');
    } catch (e) {
      AppLogger.ec(LogCategory.network, 'Failed to generate cURL log', e);
    }
  }
=======
>>>>>>> origin/real_api_confrim_screen
}
