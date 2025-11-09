import 'package:dio/dio.dart';
import '../../helpers/logger.dart';

/// Interceptor for adding authentication tokens to requests
class AuthInterceptor extends Interceptor {
  final String? Function() getToken;

  AuthInterceptor({required this.getToken});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = getToken();
    
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      AppLogger.d('Auth token added to request');
    }
    
    super.onRequest(options, handler);
  }
}
