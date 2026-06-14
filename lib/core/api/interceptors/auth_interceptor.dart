import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tobank_sdui/core/api/auth/auth_manager.dart';

/// Automatically attaches Bearer token from AuthManager to every request
class AuthInterceptor extends Interceptor {
  final AuthManager _authManager = AuthManager(
    storage: const FlutterSecureStorage(),
  );

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _authManager.initialize();
    final token = await _authManager.getAccessToken();
    if (token != null) {
      final authHeader = token.toLowerCase().startsWith('bearer ')
          ? token
          : 'Bearer $token';
      options.headers['authorization'] = authHeader;
    }
    handler.next(options);
  }
}
