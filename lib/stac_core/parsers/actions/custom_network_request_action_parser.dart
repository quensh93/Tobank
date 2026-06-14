import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../../core/helpers/logger.dart';
import '../../registry/registry_notifier.dart';

class CustomNetworkRequestActionModel {
  final StacNetworkRequest request;
  final String? dataBind;

  const CustomNetworkRequestActionModel({required this.request, this.dataBind});
}

/// Custom network request parser that stores response data in registry
/// so that {{data.data.*}} variables can be resolved in results actions.
class CustomNetworkRequestActionParser
    extends StacActionParser<CustomNetworkRequestActionModel> {
  const CustomNetworkRequestActionParser();

  @override
  String get actionType => ActionType.networkRequest.name;

  @override
  CustomNetworkRequestActionModel getModel(Map<String, dynamic> json) {
    // Support 'data' as an alias for 'body'
    // STAC commonly uses 'data' for the payload in JSON, but 'body' in the model.
    if (json['body'] == null && json['data'] != null) {
      json['body'] = json['data'];
    }

    final dataBindRaw = json['dataBind'] ?? json['data_bind'];
    final dataBind = dataBindRaw?.toString().trim();

    return CustomNetworkRequestActionModel(
      request: StacNetworkRequest.fromJson(json),
      dataBind: (dataBind == null || dataBind.isEmpty) ? null : dataBind,
    );
  }

  @override
  FutureOr onCall(
    BuildContext context,
    CustomNetworkRequestActionModel model,
  ) async {
    Response<dynamic>? response;

    try {
      final request = model.request;
      final resolvedModel = _resolveNetworkRequestTemplates(request);

      // Log deposit selection debug info for draft API calls
      if (resolvedModel.url.contains('draft') && resolvedModel.body is Map) {
        final body = resolvedModel.body as Map;
        AppLogger.dc(
          LogCategory.network,
          '🔍 DRAFT-CHECK: body.sourceAccount=${body['sourceAccount']}, '
          'body.issuerAccountNumber=${body['issuerAccountNumber']}, '
          'registry.selectedDeposit.depositNumber=${StacRegistry.instance.getValue('selectedDeposit.depositNumber')}, '
          'registry.selectedDeposit.depositIban=${StacRegistry.instance.getValue('selectedDeposit.depositIban')}',
        );
      }

      // Log cURL for debugging
      _logCurl(resolvedModel);

      response = await StacNetworkService.request(
        context,
        resolvedModel,
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException {
      AppLogger.wc(LogCategory.network, 'Network request timed out');
      response = null; // Will trigger fallback to status code -1
    } on DioException catch (e) {
      response = e.response;
      AppLogger.ec(
        LogCategory.network,
        'Network request failed with DioException',
        e,
      );
    }

    // Store response data in registry so {{data.data.*}} variables can be resolved,
    // and optionally under a dedicated dataBind namespace.
    if (response?.data != null) {
      storeResponseInRegistry(
        responseData: response!.data,
        statusCode: response.statusCode ?? -1,
        headers: _extractHeaders(response),
        dataBind: model.dataBind,
      );
      RegistryNotifier.instance.notify();
      AppLogger.dc(
        LogCategory.network,
        model.dataBind == null
            ? 'Network response data stored in registry under legacy keys'
            : 'Network response data stored in registry under legacy keys and responses.${model.dataBind}',
      );
    }

    final statusCode = response?.statusCode ?? -1;

    try {
      // First try to find exact match
      var result = model.request.results.firstWhere(
        (element) => element.statusCode == statusCode,
        orElse: () {
          // If not found, try to find fallback handler (-1)
          return model.request.results.firstWhere(
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
            'Before result action: data_payload (${dpCheck.runtimeType}) = ${preview.length > 80 ? '${preview.substring(0, 80)}...' : preview}',
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

  @visibleForTesting
  void storeResponseInRegistry({
    required dynamic responseData,
    required int statusCode,
    Map<String, dynamic>? headers,
    String? dataBind,
  }) {
    StacRegistry.instance.setValue('data', responseData);

    final payload = _extractPayload(responseData);
    if (payload != null) {
      StacRegistry.instance.setValue('data_payload', payload);
    }

    final bind = dataBind?.trim();
    if (bind == null || bind.isEmpty) {
      return;
    }

    final base = 'responses.$bind';
    final normalizedData = payload ?? responseData;
    StacRegistry.instance.setValue('$base.raw', responseData);
    StacRegistry.instance.setValue('$base.payload', normalizedData);
    StacRegistry.instance.setValue('$base.data', normalizedData);
    StacRegistry.instance.setValue('$base.statusCode', statusCode);
    StacRegistry.instance.setValue(
      '$base.headers',
      headers ?? <String, dynamic>{},
    );
    StacRegistry.instance.setValue(
      '$base.ok',
      statusCode >= 200 && statusCode < 300,
    );
    StacRegistry.instance.setValue(
      '$base.timestamp',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  dynamic _extractPayload(dynamic responseData) {
    dynamic payload;
    if (responseData is Map) {
      payload = responseData['data'];
      if (payload == null && responseData['result'] is Map) {
        payload = (responseData['result'] as Map)['data'];
      }
    }
    return payload;
  }

  Map<String, dynamic> _extractHeaders(Response<dynamic> response) {
    final rawHeaders = response.headers.map;
    return rawHeaders.map((key, value) => MapEntry(key, value));
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
      // Log pre-resolution body for draft calls to check if templates survive
      if (model.url.contains('draft') && model.body is Map) {
        final rawBody = model.body as Map;
        AppLogger.dc(
          LogCategory.network,
          '🔍 DRAFT PRE-RESOLVE: sourceAccount=${rawBody['sourceAccount']}, '
          'issuerAccountNumber=${rawBody['issuerAccountNumber']} '
          '(hasTemplates=${rawBody['sourceAccount']?.toString().contains('{{') ?? false})',
        );
      }
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

    // Support removeLeadingZero function: {{removeLeadingZero(key)}}
    final removeLeadingZeroRegex = RegExp(
      r"\{\{removeLeadingZero\(([^)]+?)\)\}\}",
    );

    if (removeLeadingZeroRegex.hasMatch(decodedInput)) {
      try {
        decodedInput = decodedInput.replaceAllMapped(removeLeadingZeroRegex, (
          match,
        ) {
          final key = match.group(1)?.trim();
          if (key == null) return match.group(0) ?? '';

          // Resolve the key's value from registry
          // Use _getNestedValue to support dotted keys like "userData.mobile"
          final val = _getNestedValue(key)?.toString() ?? '';

          if (val.startsWith('0')) {
            return val.substring(1);
          }
          return val;
        });
      } catch (e) {
        AppLogger.ec(LogCategory.network, 'Error in removeLeadingZero: $e', e);
      }
    }

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
        // Use _getNestedValue to support dotted keys like "userData.birthDate"
        final val = _getNestedValue(key)?.toString() ?? '';

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

    // Try longest dotted-key prefix first.
    // Example:
    //   path = responses.fetchCustomerInfo.payload.nationalCode
    //   registry key = responses.fetchCustomerInfo.payload (Map)
    for (int i = parts.length - 1; i > 0; i--) {
      final prefix = parts.sublist(0, i).join('.');
      final prefixValue = StacRegistry.instance.getValue(prefix);
      if (prefixValue != null) {
        return _walkNestedValue(prefixValue, parts.sublist(i));
      }
    }

    // Get the root value from registry
    dynamic value = StacRegistry.instance.getValue(parts[0]);
    if (value == null) return null;

    // Navigate through nested structure
    return _walkNestedValue(value, parts.sublist(1));
  }

  dynamic _walkNestedValue(dynamic value, List<String> remainingParts) {
    dynamic current = value;
    for (final part in remainingParts) {
      if (current is Map) {
        current = current[part];
      } else if (current is List && int.tryParse(part) != null) {
        final index = int.parse(part);
        if (index >= 0 && index < current.length) {
          current = current[index];
        } else {
          return null;
        }
      } else {
        return null;
      }

      if (current == null) return null;
    }
    return current;
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
      // Don't resolve 'results' inside nested networkRequest actions.
      // Each networkRequest's result handlers must be resolved only when
      // THAT request completes, so their {{data_payload.*}} references
      // pick up the fresh response data instead of stale outer-request data.
      if (entry.key == 'results' && map['actionType'] == 'networkRequest') {
        result[entry.key] = entry.value; // Keep raw templates
      } else {
        result[entry.key] = _resolveValueTemplates(entry.value);
      }
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
        // Support toInt function: {{toInt(key)}}
        if (expr != null && expr.startsWith('toInt(') && expr.endsWith(')')) {
          final key = expr.substring(6, expr.length - 1).trim();
          final val = _getNestedValue(key);
          if (val != null) {
            return int.tryParse(val.toString()) ?? val;
          }
          return 0;
        }

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
      final buffer = StringBuffer();
      buffer.write('curl --request ${request.method.name.toUpperCase()}');
      buffer.write(' --url "${request.url}"');

      request.headers?.forEach((key, value) {
        final lowerKey = key.toLowerCase();
        if (lowerKey == 'authorization' || lowerKey == 'serviceauthorization') {
          buffer.write(" --header '$key: [token]'");
        } else {
          buffer.write(" --header '$key: $value'");
        }
      });

      if (request.body != null) {
        String jsonBody;
        if (request.body is String) {
          jsonBody = request.body as String;
        } else {
          jsonBody = jsonEncode(request.body);
        }
        final escapedBody = jsonBody.replaceAll("'", "'\\''");
        buffer.write(" --data '$escapedBody'");
      }

      final curl = buffer.toString();

      // 1. Raw Logging (Chunked)
      // We manually split this into chunks to guarantee it bypasses Android's 4KB limit
      // nicely while still looking like a "raw" block in the console.
      try {
        // ignore: avoid_print
        print('🌐 RAW CURL START -----------------------------------------');

        const int rawChunkSize = 900;
        for (int i = 0; i < curl.length; i += rawChunkSize) {
          int end = (i + rawChunkSize < curl.length)
              ? i + rawChunkSize
              : curl.length;
          // ignore: avoid_print
          print(curl.substring(i, end));
        }

        // ignore: avoid_print
        print('🌐 RAW CURL END -------------------------------------------');
      } catch (_) {}

      // 2. Chunked logging for safety (fallback)
      const int chunkSize = 800;

      if (curl.length <= chunkSize) {
        AppLogger.dc(LogCategory.network, 'CURL: $curl', null, null, true);
      } else {
        // Initial chunk
        AppLogger.dc(
          LogCategory.network,
          'CURL (Part 1/${(curl.length / chunkSize).ceil()}): ${curl.substring(0, chunkSize)}',
          null,
          null,
          true,
        );

        // Subsequent chunks
        for (int i = chunkSize; i < curl.length; i += chunkSize) {
          int end = (i + chunkSize < curl.length) ? i + chunkSize : curl.length;
          final partNum = (i / chunkSize).floor() + 1;
          final totalParts = (curl.length / chunkSize).ceil();
          AppLogger.dc(
            LogCategory.network,
            'CURL (Part $partNum/$totalParts): ${curl.substring(i, end)}',
            null,
            null,
            true,
          );
        }
      }
    } catch (e) {
      AppLogger.ec(LogCategory.network, 'Failed to generate cURL log', e);
    }
  }
}
