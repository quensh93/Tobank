import 'dart:convert';

import 'package:tobank_sdui/core/helpers/logger.dart';

/// Shared cURL logging utility.
///
/// Callers are responsible for extracting headers into a plain
/// `Map<String, dynamic>` before calling these methods.
class CurlLogger {
  const CurlLogger._();

  /// Build and return a cURL string from the given parameters.
  ///
  /// Uses a component-join style (no chunking). Suitable for callers that
  /// need the raw string (e.g. mock interceptors that return it).
  static String generate({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
    bool maskAuth = true,
  }) {
    final components = <String>['curl -i'];

    if (method.toUpperCase() != 'GET') {
      components.add('-X $method');
    }

    headers?.forEach((k, v) {
      final safeValue =
          maskAuth && _isAuthHeader(k) ? '[token]' : v.toString();
      components.add('-H "$k: $safeValue"');
    });

    if (body != null) {
      try {
        if (_isFormData(body)) {
          components.add('-d "[FormData]"');
        } else if (body is String) {
          components.add("-d '$body'");
        } else if (body is Map || body is List) {
          components.add("-d '${json.encode(body)}'");
        } else {
          components.add("-d '$body'");
        }
      } catch (_) {
        components.add("-d '$body'");
      }
    }

    components.add('"$url"');
    return components.join(' ');
  }

  /// Build and log a cURL command.
  ///
  /// [rawPrint] — also emit raw print chunks (900 chars) with START/END markers
  /// to bypass Android 4 KB logcat limit. Default false (AppLogger only).
  /// Pass true for large requests on Android (e.g. custom_network_request_action_parser).
  /// Controlled globally by [LogConfig.networkRawPrint] — if that is false,
  /// raw print is suppressed regardless of this parameter.
  static void log({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
    bool maskAuth = true,
    bool rawPrint = false,
  }) {
    try {
      final buffer = StringBuffer();
      buffer.write('curl --request ${method.toUpperCase()}');
      buffer.write(' --url "$url"');

      headers?.forEach((key, value) {
        final safeValue =
            maskAuth && _isAuthHeader(key) ? '[token]' : value.toString();
        buffer.write(" --header '$key: $safeValue'");
      });

      if (body != null) {
        final String jsonBody;
        if (body is String) {
          jsonBody = body;
        } else {
          jsonBody = jsonEncode(body);
        }
        final escaped = jsonBody.replaceAll("'", "'\\''");
        buffer.write(" --data '$escaped'");
      }

      final curl = buffer.toString();

      // 1. Raw print chunking — only when requested AND enabled in LogConfig.
      if (rawPrint && LogConfig.networkRawPrint) {
        try {
          // ignore: avoid_print
          print('🌐 RAW CURL START -----------------------------------------');
          const int rawChunkSize = 900;
          for (int i = 0; i < curl.length; i += rawChunkSize) {
            final end = (i + rawChunkSize < curl.length)
                ? i + rawChunkSize
                : curl.length;
            // ignore: avoid_print
            print(curl.substring(i, end));
          }
          // ignore: avoid_print
          print('🌐 RAW CURL END -------------------------------------------');
        } catch (_) {}
      }

      // 2. AppLogger chunking (800 chars) — structured log fallback.
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
          final end =
              (i + chunkSize < curl.length) ? i + chunkSize : curl.length;
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

  static bool _isAuthHeader(String key) {
    final lower = key.toLowerCase();
    return lower == 'authorization' || lower == 'serviceauthorization';
  }

  /// Duck-type check for Dio's FormData without importing dio.
  static bool _isFormData(dynamic data) {
    return data.runtimeType.toString() == 'FormData';
  }
}
