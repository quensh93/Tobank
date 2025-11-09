import 'dart:io';
import 'package:dio/dio.dart';
import '../../helpers/logger.dart';

/// Interceptor for handling various error scenarios
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    
    // Log the error
    AppLogger.e(
      'API Error: ${err.type} - Status: $statusCode',
      err,
      err.stackTrace,
    );

    // Handle specific error types
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        // Handle timeout errors
        _handleTimeout(err, handler);
        break;

      case DioExceptionType.badResponse:
        // Handle HTTP error responses
        _handleBadResponse(err, handler);
        break;

      case DioExceptionType.connectionError:
        // Handle connection errors (no internet)
        _handleConnectionError(err, handler);
        break;

      case DioExceptionType.cancel:
        // Handle cancelled requests
        _handleCancel(err, handler);
        break;

      case DioExceptionType.unknown:
        // Handle unknown errors
        _handleUnknown(err, handler);
        break;

      case DioExceptionType.badCertificate:
        // Handle SSL certificate errors
        _handleBadCertificate(err, handler);
        break;
    }
  }

  void _handleTimeout(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.w('Request timeout');
    handler.next(err);
  }

  void _handleBadResponse(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    
    switch (statusCode) {
      case 400:
        AppLogger.w('Bad Request: 400');
        break;
      case 403:
        AppLogger.w('Forbidden: 403');
        break;
      case 404:
        AppLogger.w('Not Found: 404');
        break;
      case 500:
      case 502:
      case 503:
        AppLogger.e('Server Error: $statusCode');
        break;
      default:
        AppLogger.w('HTTP Error: $statusCode');
    }
    
    handler.next(err);
  }

  void _handleConnectionError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    AppLogger.e('Connection error: No internet connection');
    handler.next(err);
  }

  void _handleCancel(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.d('Request cancelled');
    handler.next(err);
  }

  void _handleUnknown(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is SocketException) {
      AppLogger.e('Network error: ${err.error}');
    } else {
      AppLogger.e('Unknown error: ${err.error}');
    }
    
    handler.next(err);
  }

  void _handleBadCertificate(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    AppLogger.e('SSL Certificate error');
    handler.next(err);
  }
}
