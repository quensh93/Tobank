import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tobank_sdui/core/api/auth/auth_manager.dart';
import 'package:tobank_sdui/core/helpers/log_category.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';

/// Attaches Bearer token from AuthManager to every outgoing request.
/// Each DioFactory.authenticated() instance gets its own AuthInterceptor with its own AuthManager.
class AuthInterceptor extends Interceptor {
  final AuthManager _authManager = AuthManager(
    storage: const FlutterSecureStorage(),
  );

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      await _authManager.initialize();
      final token = await _authManager.getAccessToken();
      if (token != null) {
        final authHeader = token.toLowerCase().startsWith('bearer ')
            ? token
            : 'Bearer $token';
        options.headers['authorization'] = authHeader;
      }
    } catch (e) {
      // Token fetch failed — proceed without auth header; request will get 401 from server
      AppLogger.wc(LogCategory.network, 'AuthInterceptor: failed to fetch token', e);
    }
    handler.next(options);
  }
}
