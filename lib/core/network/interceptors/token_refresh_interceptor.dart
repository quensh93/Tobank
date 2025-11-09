import 'package:dio/dio.dart';
import '../../helpers/logger.dart';

/// Interceptor for handling token refresh on 401 errors
class TokenRefreshInterceptor extends Interceptor {
  final Dio dio;
  final Future<String?> Function() refreshToken;
  final Future<void> Function() onTokenExpired;

  TokenRefreshInterceptor({
    required this.dio,
    required this.refreshToken,
    required this.onTokenExpired,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    AppLogger.d(
      'TokenInterceptor: ${err.response?.statusCode} - ${err.requestOptions.path}',
    );

    // Check if the error is a 401 (Unauthorized)
    if (err.response?.statusCode == 401) {
      // Prevent infinite retry loops
      if (!err.requestOptions.extra.containsKey('tokenRetried')) {
        err.requestOptions.extra['tokenRetried'] = true;

        try {
          AppLogger.i('Refreshing access token...');
          
          final newToken = await refreshToken();

          if (newToken != null && newToken.isNotEmpty) {
            // Update the header with the new token
            dio.options.headers['Authorization'] = 'Bearer $newToken';

            // Retry the original request
            final options = Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            );

            options.headers?['Authorization'] = 'Bearer $newToken';

            try {
              final response = await dio.fetch(
                err.requestOptions.copyWith(
                  headers: options.headers,
                ),
              );
              
              AppLogger.i('Token refreshed successfully, retrying request');
              return handler.resolve(response);
            } on DioException catch (e) {
              AppLogger.e('Failed to retry request after token refresh', e);
              return handler.reject(e);
            }
          } else {
            // Token refresh failed, navigate to login
            AppLogger.e('Token refresh failed, navigating to login');
            await onTokenExpired();
            
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: 'Token refresh failed',
              ),
            );
          }
        } catch (e) {
          AppLogger.e('Exception during token refresh', e);
          await onTokenExpired();
          
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: 'Token refresh exception: $e',
            ),
          );
        }
      } else {
        // Already retried, navigate to login
        AppLogger.e('Token retry failed, navigating to login');
        await onTokenExpired();
      }
    }

    // For other errors, pass through
    return handler.next(err);
  }
}
