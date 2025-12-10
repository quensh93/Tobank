import 'dart:convert';
import 'package:dio/dio.dart';
import '../../logger_service/logger_service.dart';

class CurlLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Generate the cURL command
    final curlCommand = _generateCurl(
      method: options.method,
      url: options.uri.toString(),
      headers: options.headers,
      queryParameters: options.queryParameters,
      data: options.data?.toString(),
      requireBase64EncodedBody: options.extra['requireBase64EncodedBody'] ?? false,
    );

    // Log the cURL command using Logger
    Logger.curlLog(curlCommand);

    // Continue with the request
    handler.next(options);
  }

  String _generateCurl({
    required String method,
    required String url,
    required Map<String, dynamic> headers,
    required Map<String, dynamic>? queryParameters,
    required String? data,
    required bool requireBase64EncodedBody,
  }) {
    final List<String> components = ['curl -i'];

    // Add method if not GET
    if (method.toUpperCase() != 'GET') {
      components.add('-X $method');
    }

    // Add headers
    headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    // Handle data
    if (data != null) {
      if (requireBase64EncodedBody) {
        try {
          final jsonData = jsonDecode(data);
          if (jsonData['data'] != null) {
            final decodedData = utf8.decode(base64.decode(jsonData['data']));
            components.add('-d \'${jsonEncode(jsonDecode(decodedData))}\'');
          }
        } catch (e) {
          components.add('-d "$data"');
        }
      } else {
        components.add('-d \'$data\'');
      }
    }

    // Add query parameters to URL if present
    String finalUrl = url;
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final Uri uri = Uri.parse(url);
      final newUri = uri.replace(queryParameters: {
        ...uri.queryParameters,
        ...queryParameters.map((key, value) => MapEntry(key, value.toString())),
      });
      finalUrl = newUri.toString();
    }

    components.add('"$finalUrl"');

    // Join components with a single space for a one-line output
    return components.join(' ');
  }
}