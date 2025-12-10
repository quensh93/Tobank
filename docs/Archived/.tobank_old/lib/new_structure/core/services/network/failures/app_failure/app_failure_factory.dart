import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_failure.dart';

@lazySingleton
class AppFailureFactory {
  AppFailure createFromDioException(DioException dioException) {
    final failure = _mapDioExceptionToFailure(dioException);
    _logToSentry(
      message: 'Network error: ${dioException.message}',
      error: dioException,
      stackTrace: dioException.stackTrace,
      level: SentryLevel.error,
      extra: {
        'type': dioException.type.toString(),
        'statusCode': dioException.response?.statusCode,
        'responseData': dioException.response?.data,
      },
    );
    return failure;
  }

  AppFailure createFromStatusCode({
    required int? statusCode,
    required Map<String, dynamic>? errorData,
  }) {
    final failure = _mapStatusCodeToFailure(statusCode, errorData);
    _logToSentry(
      message: 'API error with status $statusCode',
      level: SentryLevel.warning,
      extra: {
        'statusCode': statusCode,
        'errorData': errorData,
      },
    );
    return failure;
  }

  AppFailure createModelMapFailure({
    required String message,
    required String path,
    StackTrace? stackTrace,
    String? entityType,
  }) {
    final failure = AppFailure.modelMapFailure(
      message: message,
      displayMessage: 'Failed to decode response${entityType != null ? ' ($entityType)' : ''}',
    );
    _logToSentry(
      message: 'Mapping failure: $message',
      level: SentryLevel.error,
      stackTrace: stackTrace,
      extra: {
        'path': path,
        'entityType': entityType,
      },
    );
    return failure;
  }

  // Private mapping methods
  AppFailure _mapDioExceptionToFailure(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const AppFailure.connectionTimeoutFailure();
      case DioExceptionType.connectionError:
        return const AppFailure.noConnectionFailure();
      case DioExceptionType.badCertificate:
        return AppFailure.sslPinningFailure(
          message: dioException.message ?? 'SSL certificate validation failed',
        );
      case DioExceptionType.badResponse:
        return AppFailure.unhandledStatusCodeFailure(
          statusCode: dioException.response?.statusCode,
          message: dioException.response?.data['message'] ?? 'Bad response',
          errorData: dioException.response?.data,
        );
      case DioExceptionType.unknown:
        return const AppFailure.responseDecodingFailure();
      default:
        return AppFailure.unexpectedFailure(error: dioException);
    }
  }

  AppFailure _mapStatusCodeToFailure(int? statusCode, Map<String, dynamic>? errorData) {
    switch (statusCode) {
      case 400:
        return AppFailure.apiDetailedFailure(
          message: errorData?['message'] ?? 'Bad request',
          statusCode: statusCode,
          errorData: errorData,
        );
      case 403:
        return const AppFailure.vpnConnectedFailure();
      default:
        return AppFailure.unhandledStatusCodeFailure(
          statusCode: statusCode,
          message: errorData?['message'] ?? 'Unhandled status code',
          errorData: errorData,
        );
    }
  }

  // Centralized Sentry logging
  void _logToSentry({
    required String message,
    required SentryLevel level, Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
  }) {
    if (error != null) {
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
        hint: Hint.withMap({
          'environment': kDebugMode ? 'debug' : 'production',
          ...?extra,
        }),
      );
    } else {
      Sentry.captureMessage(
        message,
        level: level,
        hint: Hint.withMap({
          'environment': kDebugMode ? 'debug' : 'production',
          ...?extra,
        }),
      );
    }
  }
}