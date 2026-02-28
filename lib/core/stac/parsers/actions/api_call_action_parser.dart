import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../helpers/logger.dart';
import '../../utils/registry_notifier.dart';

class ApiCallActionModel {
  final String path;
  final String method;
  final Map<String, dynamic>? headers;
  final bool ignoreDefaultHeaders;
  final dynamic data;
  final List<dynamic> results;
  final String? dataBind;
  final String? fullUrl;

  const ApiCallActionModel({
    required this.path,
    required this.method,
    required this.results,
    this.headers,
    this.ignoreDefaultHeaders = false,
    this.data,
    this.dataBind,
    this.fullUrl,
  });

  factory ApiCallActionModel.fromJson(Map<String, dynamic> json) {
    if (json['body'] == null && json['data'] != null) {
      json['body'] = json['data'];
    }

    final rawHeaders = json['headers'];
    final rawResults = json['results'];
    final dataBindRaw = json['dataBind'] ?? json['data_bind'];

    return ApiCallActionModel(
      path: (json['path'] as String? ?? '').trim(),
      method: (json['method'] as String? ?? 'get').trim().toLowerCase(),
      headers: rawHeaders is Map<String, dynamic>
          ? rawHeaders
          : rawHeaders is Map
          ? Map<String, dynamic>.from(rawHeaders)
          : null,
      ignoreDefaultHeaders: json['ignoreDefaultHeaders'] == true,
      data: json['body'], // Store payload
      results: rawResults is List ? List<dynamic>.from(rawResults) : const [],
      dataBind: (dataBindRaw?.toString().trim()),
      fullUrl: (json['fullUrl'] as String?)?.trim(),
    );
  }
}

class ApiCallActionParser extends StacActionParser<ApiCallActionModel> {
  const ApiCallActionParser();

  static const String _baseUrlKey = 'promissory.api.baseUrl';
  static const String _commonHeadersKey = 'promissory.api.headers.common';
  static const String _defaultBaseUrl = 'http://192.168.107.22:8280';
  static const Map<String, dynamic> _defaultHeaders = {
    'accept': 'application/json',
    'content-type': 'application/json',
    'app-platform': 'android',
    'app-store': 'application/json',
    'app-version': '456',
    'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
    'serviceauthorization':
        'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
    'authorization': '{{auth.accessToken}}',
  };

  @override
  String get actionType => 'apiCall';

  @override
  ApiCallActionModel getModel(Map<String, dynamic> json) =>
      ApiCallActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, ApiCallActionModel model) async {
    Response<dynamic>? response;

    try {
      final stacRequest = _resolveApiCallTemplates(model);

      if (stacRequest.url.contains('draft') && stacRequest.body is Map) {
        final body = stacRequest.body as Map;
        AppLogger.dc(
          LogCategory.network,
          '🔍 DRAFT-CHECK: body.sourceAccount=${body['sourceAccount']}, '
          'body.issuerAccountNumber=${body['issuerAccountNumber']}, '
          'registry.selectedDeposit.depositNumber=${StacRegistry.instance.getValue('selectedDeposit.depositNumber')}, '
          'registry.selectedDeposit.depositIban=${StacRegistry.instance.getValue('selectedDeposit.depositIban')}',
        );
      }

      _logCurl(stacRequest);

      response = await StacNetworkService.request(
        context,
        stacRequest,
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException {
      AppLogger.wc(LogCategory.network, 'Network request timed out');
      response = null;
    } on DioException catch (e) {
      response = e.response;
      AppLogger.ec(
        LogCategory.network,
        'Network request failed with DioException',
        e,
      );
    }

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
      var result = model.results.firstWhere(
        (element) => element['statusCode'] == statusCode,
        orElse: () => model.results.firstWhere(
          (element) => element['statusCode'] == -1,
          orElse: () => null,
        ),
      );

      if (result != null && result['action'] != null && context.mounted) {
        final dpCheck = StacRegistry.instance.getValue('data_payload');
        if (dpCheck != null) {
          final preview = dpCheck.toString();
          AppLogger.dc(
            LogCategory.stacData,
            'Before result action: data_payload (${dpCheck.runtimeType}) = ${preview.length > 80 ? '${preview.substring(0, 80)}...' : preview}',
          );
        }

        final action = result['action'];
        final resolvedAction = _resolveActionTemplates(action);
        AppLogger.dc(LogCategory.stacData, 'Resolved action templates');
        return Stac.onCallFromJson(resolvedAction, context);
      }
    } catch (e) {
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
    StacRegistry.instance.setValue('$base.body', normalizedData);
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

  StacNetworkRequest _resolveApiCallTemplates(ApiCallActionModel model) {
    final baseUrl = _buildUrl(model);
    final resolvedUrl = _resolveTemplates(baseUrl);

    final builtHeaders = _buildHeaders(model);
    Map<String, String>? resolvedHeaders;

    if (builtHeaders.isNotEmpty) {
      resolvedHeaders = builtHeaders.map((key, value) {
        return MapEntry(key, _resolveTemplates(value.toString()));
      });

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

    dynamic resolvedBody;
    if (model.data != null) {
      if (resolvedUrl.contains('draft') && model.data is Map) {
        final rawBody = model.data as Map;
        AppLogger.dc(
          LogCategory.network,
          '🔍 DRAFT PRE-RESOLVE: sourceAccount=${rawBody['sourceAccount']}, '
          'issuerAccountNumber=${rawBody['issuerAccountNumber']} '
          '(hasTemplates=${rawBody['sourceAccount']?.toString().contains('{{') ?? false})',
        );
      }
      resolvedBody = _resolveValueTemplates(model.data);
    }

    return StacNetworkRequest.fromJson({
      'url': resolvedUrl,
      'method': model.method.isEmpty ? 'get' : model.method,
      if (resolvedHeaders != null && resolvedHeaders.isNotEmpty)
        'headers': resolvedHeaders,
      if (resolvedBody != null)
        'body':
            resolvedBody, // StacNetworkRequest constructor expects 'body', not 'data'
    });
  }

  String _buildUrl(ApiCallActionModel model) {
    final fullUrl = model.fullUrl;
    if (fullUrl != null && fullUrl.isNotEmpty) {
      return fullUrl;
    }

    if (model.path.isEmpty) {
      return _resolveBaseUrl();
    }

    final baseUrl = _resolveBaseUrl();
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final path = model.path.startsWith('/') ? model.path : '/${model.path}';
    return '$base$path';
  }

  String _resolveBaseUrl() {
    final raw = StacRegistry.instance.getValue(_baseUrlKey);
    final value = raw?.toString().trim();
    if (value == null || value.isEmpty) {
      return _defaultBaseUrl;
    }
    return value;
  }

  Map<String, dynamic> _buildHeaders(ApiCallActionModel model) {
    if (model.ignoreDefaultHeaders) {
      return model.headers ?? const {};
    }

    final fromRegistry = _normalizeHeaders(
      StacRegistry.instance.getValue(_commonHeadersKey),
    );
    final base = fromRegistry.isNotEmpty ? fromRegistry : _defaultHeaders;

    if (model.headers == null || model.headers!.isEmpty) {
      return Map<String, dynamic>.from(base);
    }

    return <String, dynamic>{...base, ...model.headers!};
  }

  Map<String, dynamic> _normalizeHeaders(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      return raw;
    }
    if (raw is Map) {
      final normalized = <String, dynamic>{};
      raw.forEach((key, value) {
        normalized[key.toString()] = value;
      });
      return normalized;
    }
    return const {};
  }

  String _resolveTemplates(String input) {
    String decodedInput = _tryDecodeUriComponent(input);

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

    final replaceInfoRegex = RegExp(
      r"\{\{replace\(([^,]+?)\s*,\s*[']([^']*)[']\s*,\s*[']([^']*)[']\s*\)\}\}",
    );

    if (replaceInfoRegex.hasMatch(decodedInput)) {
      decodedInput = decodedInput.replaceAllMapped(replaceInfoRegex, (match) {
        final key = match.group(1)?.trim();
        final from = match.group(2);
        final to = match.group(3);

        if (key == null) return match.group(0) ?? '';
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

  dynamic _getNestedValue(String path) {
    final directValue = StacRegistry.instance.getValue(path);
    if (directValue != null) return directValue;

    final parts = path.split('.');
    if (parts.isEmpty) return null;

    for (int i = parts.length - 1; i > 0; i--) {
      final prefix = parts.sublist(0, i).join('.');
      final prefixValue = StacRegistry.instance.getValue(prefix);
      if (prefixValue != null) {
        return _walkNestedValue(prefixValue, parts.sublist(i));
      }
    }

    dynamic value = StacRegistry.instance.getValue(parts[0]);
    if (value == null) return null;

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
      return Uri.decodeFull(input);
    } catch (_) {
      return input;
    }
  }

  Map<String, dynamic> _resolveActionTemplates(Map<String, dynamic> action) {
    return _resolveMapTemplates(action);
  }

  Map<String, dynamic> _resolveMapTemplates(Map<String, dynamic> map) {
    final result = <String, dynamic>{};
    for (final entry in map.entries) {
      // Don't pre-resolve inner apiCall or networkRequest results.
      if (entry.key == 'results' &&
          (map['actionType'] == 'networkRequest' ||
              map['actionType'] == 'apiCall')) {
        result[entry.key] = entry.value;
      } else {
        result[entry.key] = _resolveValueTemplates(entry.value);
      }
    }
    return result;
  }

  dynamic _resolveValueTemplates(dynamic value) {
    if (value is String) {
      if (value.contains('{{replace(')) {
        return _resolveTemplates(value);
      }

      final match = RegExp(r'^{{([^}]+)}}$').firstMatch(value);
      if (match != null) {
        final expr = match.group(1)?.trim();
        if (expr != null && expr.startsWith('toInt(') && expr.endsWith(')')) {
          final key = expr.substring(6, expr.length - 1).trim();
          final val = _getNestedValue(key);
          if (val != null) {
            return int.tryParse(val.toString()) ?? val;
          }
          return 0;
        }

        if (expr != null && expr.contains('(')) {
          return _resolveTemplates(value);
        }

        if (expr != null && expr.isNotEmpty) {
          final resolved = StacRegistry.instance.getValue(expr);
          if (resolved != null) {
            return resolved;
          }
        }
      }
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

      const int chunkSize = 800;

      if (curl.length <= chunkSize) {
        AppLogger.dc(LogCategory.network, 'CURL: $curl', null, null, true);
      } else {
        AppLogger.dc(
          LogCategory.network,
          'CURL (Part 1/${(curl.length / chunkSize).ceil()}): ${curl.substring(0, chunkSize)}',
          null,
          null,
          true,
        );

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
