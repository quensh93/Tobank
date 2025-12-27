import 'dart:io';
import 'package:dio/dio.dart';
import '../../helpers/logger.dart';

/// Interceptor for adding common headers and request modification
class RequestInterceptor extends Interceptor {
  final Map<String, String> additionalHeaders;

  RequestInterceptor({this.additionalHeaders = const {}});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add platform-specific headers
    options.headers['API-REQUEST-FROM'] = Platform.isIOS ? 'iOS' : 'Android';

    // Add any additional headers
    if (additionalHeaders.isNotEmpty) {
      options.headers.addAll(additionalHeaders);
    }

    // Log request details
    AppLogger.dc(LogCategory.network, '${options.method} ${options.path}');

    if (options.queryParameters.isNotEmpty) {
      AppLogger.dc(
        LogCategory.network,
        'Query params: ${options.queryParameters}',
      );
    }

    super.onRequest(options, handler);
  }
}
