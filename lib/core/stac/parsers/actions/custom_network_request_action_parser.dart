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
  StacNetworkRequest getModel(Map<String, dynamic> json) {
    // Support 'data' as an alias for 'body'
    // STAC commonly uses 'data' for the payload in JSON, but 'body' in the model.
    if (json['body'] == null && json['data'] != null) {
      json['body'] = json['data'];
    }
    return StacNetworkRequest.fromJson(json);
  }

  @override
  FutureOr onCall(BuildContext context, StacNetworkRequest model) async {
    Response<dynamic>? response;

    try {
      final resolvedModel = _resolveNetworkRequestTemplates(model);

      // Log cURL for debugging
      _logCurl(resolvedModel);

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
        }

        // Pre-resolve {{data_payload}} in the action JSON to prevent STAC framework
        // from using stale cached values.
        final action = result.action;
        final resolvedAction = _resolveActionTemplates(action);
        AppLogger.dc(LogCategory.stacData, 'Resolved action templates');
        return Stac.onCallFromJson(resolvedAction, context);
      }
    } catch (e) {
      // No matching status code found in results or other error
      AppLogger.wc(
        LogCategory.network,
        'No result handler for status code ${response?.statusCode} or error executing action: $e',
      );
    }

    return null;
  }

  StacNetworkRequest _resolveNetworkRequestTemplates(StacNetworkRequest model) {
    // Resolve URL templates
    final resolvedUrl = _resolveTemplates(model.url);

    // Resolve Headers templates
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
      final hasAuth = authValue.trim().isNotEmpty && authValue != 'Bearer null';
      AppLogger.dc(
        LogCategory.network,
        'STAC request headers resolved (hasAuthorization=$hasAuth)',
      );
    }

    // Resolve Body templates (Recursively)
    dynamic resolvedBody;
    if (model.body != null) {
      resolvedBody = _resolveValueTemplates(model.body);
    }

    return StacNetworkRequest(
      url: resolvedUrl,
      method: model.method,
      headers: resolvedHeaders,
      body: resolvedBody,
    );
  }

  String _resolveTemplates(String input) {
    String decodedInput = _tryDecodeUriComponent(input);

    // Support replace function: {{replace(key, 'old', 'new')}}
    // Regex matches: {{replace( key , 'old' , 'new' )}}
    // Groups: 1=key, 2=old, 3=new
    // Handles single quotes and optional whitespace
    final replaceInfoRegex = RegExp(
      r"\{\{replace\(([^,]+?)\s*,\s*[']([^']*)[']\s*,\s*[']([^']*)[']\s*\)\}\}",
    );

    if (replaceInfoRegex.hasMatch(decodedInput)) {
      decodedInput = decodedInput.replaceAllMapped(replaceInfoRegex, (match) {
        final key = match.group(1)?.trim();
        final from = match.group(2);
        final to = match.group(3);

        if (key == null) return match.group(0) ?? '';

        // Resolve the key's value from registry
        // The key might be simple (login.birthDate) or template-like.
        // If it's just 'login.birthDate' (no curly braces), getValue should handle it if your registry supports dot notation
        // Or we might need to wrap it in {{}} if getValue expects expression.
        // Assuming StacRegistry.instance.getValue takes the key name.

        final val = StacRegistry.instance.getValue(key)?.toString() ?? '';

        if (from != null && to != null) {
          return val.replaceAll(from, to);
        }
        return val;
      });
    }

    if (!decodedInput.contains('{{') || !decodedInput.contains('}}')) {
      return decodedInput;
    }

    return decodedInput.replaceAllMapped(RegExp(r'\{\{([^}]+)\}\}'), (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return match.group(0) ?? '';

      final value = _getNestedValue(expr);
      if (value == null) return '';

      // If resolved value is a complex object, return it as JSON string if inside other text,
      // but _resolveValueTemplates should handle it correctly if it's the entire value.
      if (value is Map || value is List) {
        try {
          return jsonEncode(value);
        } catch (_) {
          return value.toString();
        }
      }
      return value.toString();
    });
  }

  /// Gets a value from registry, supporting nested paths like "data.result.data.accessToken"
  dynamic _getNestedValue(String path) {
    // First try the exact key as-is (supports dotted keys stored flat)
    final directValue = StacRegistry.instance.getValue(path);
    if (directValue != null) return directValue;

    final parts = path.split('.');
    if (parts.isEmpty) return null;

    // Get the root value from registry
    dynamic value = StacRegistry.instance.getValue(parts[0]);
    if (value == null) return null;

    // Navigate through nested structure
    for (int i = 1; i < parts.length; i++) {
      if (value is Map) {
        value = value[parts[i]];
      } else if (value is List && int.tryParse(parts[i]) != null) {
        final index = int.parse(parts[i]);
        if (index >= 0 && index < value.length) {
          value = value[index];
        } else {
          return null;
        }
      } else {
        return null;
      }
      if (value == null) return null;
    }

    return value;
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
      // Check for replace function FIRST
      if (value.contains('{{replace(')) {
        return _resolveTemplates(value);
      }

      // Check if the entire string is a single {{expr}}
      // This preserves types (e.g. if {{key}} is a Map, return Map, not "Map")
      final match = RegExp(r'^{{([^}]+)}}$').firstMatch(value);
      if (match != null) {
        final expr = match.group(1)?.trim();
        // If it looks like a function call (contains '('), delegate to _resolveTemplates which returns String
        if (expr != null && expr.contains('(')) {
          return _resolveTemplates(value);
        }

        if (expr != null && expr.isNotEmpty) {
          final resolved = StacRegistry.instance.getValue(expr);
          // If resolved is not null, return it directly (preserving type)
          if (resolved != null) {
            return resolved;
          }
        }
      }
      // For partial matches or if not found, use string interpolation
      return _resolveTemplates(value);
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
}
