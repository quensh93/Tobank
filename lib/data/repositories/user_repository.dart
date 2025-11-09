import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import '../../core/helpers/logger.dart';
import '../datasources/api_service.dart';

/// Error types for API operations
sealed class ApiError {
  final String message;
  ApiError(this.message);
}

class NetworkError extends ApiError {
  NetworkError(super.message);
}

class NotFoundError extends ApiError {
  NotFoundError(super.message);
}

class ValidationError extends ApiError {
  ValidationError(super.message);
}

class ServerError extends ApiError {
  ServerError(super.message);
}

/// Helper function to convert API calls to TaskEither
TaskEither<ApiError, T> safeApiCall<T>(
  Future<T> Function() call,
) {
  return TaskEither.tryCatch(
    call,
    (error, stackTrace) {
      AppLogger.e('API Error', error, stackTrace);
      
      if (error is DioException) {
        switch (error.response?.statusCode) {
          case 404:
            return NotFoundError('Resource not found');
          case 400:
          case 422:
            return ValidationError('Invalid data: ${error.message}');
          case 500:
          case 502:
          case 503:
            return ServerError('Server error');
          default:
            return NetworkError('Network error: ${error.message}');
        }
      }
      return NetworkError('Unknown error: $error');
    },
  );
}

/// User repository for API operations
class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  /// Get data with query parameters
  TaskEither<ApiError, Map<String, dynamic>> getData(Map<String, dynamic> queries) {
    return safeApiCall(
      () async {
        final response = await _apiService.getData(queries);
        return response as Map<String, dynamic>;
      },
    );
  }

  /// Post data
  TaskEither<ApiError, Map<String, dynamic>> postData(Map<String, dynamic> data) {
    return safeApiCall(
      () async {
        final response = await _apiService.postData(data);
        return response as Map<String, dynamic>;
      },
    );
  }

  /// Put data
  TaskEither<ApiError, Map<String, dynamic>> putData(Map<String, dynamic> data) {
    return safeApiCall(
      () async {
        final response = await _apiService.putData(data);
        return response as Map<String, dynamic>;
      },
    );
  }

  /// Delete data
  TaskEither<ApiError, Map<String, dynamic>> deleteData() {
    return safeApiCall(
      () async {
        final response = await _apiService.deleteData();
        return response as Map<String, dynamic>;
      },
    );
  }

  /// Get headers
  TaskEither<ApiError, Map<String, dynamic>> getHeaders() {
    return safeApiCall(
      () async {
        final response = await _apiService.getHeaders();
        return response as Map<String, dynamic>;
      },
    );
  }

  /// Get user agent
  TaskEither<ApiError, Map<String, dynamic>> getUserAgent() {
    return safeApiCall(
      () async {
        final response = await _apiService.getUserAgent();
        return response as Map<String, dynamic>;
      },
    );
  }
}
