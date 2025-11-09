import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
// ISpect imports - will be tree-shaken if not used
import 'package:ispect/ispect.dart';
import 'package:ispectify_dio/ispectify_dio.dart';
import '../../core/config/ispect_config.dart';
import '../services/api_service.dart';

part 'api_providers.g.dart';

// Error types
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

// Helper function to convert API calls to TaskEither
TaskEither<ApiError, T> safeApiCall<T>(
  Future<T> Function() call,
) {
  return TaskEither.tryCatch(
    call,
    (error, stackTrace) {
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

// Dio provider
@riverpod
Dio dio(Ref ref) {
  final dio = Dio();
  
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);
  
  // Add ISpect Dio interceptor if enabled (for network monitoring)
  // IMPORTANT: Add ISpect interceptor FIRST before other interceptors
  if (ISpectConfig.shouldInitialize) {
    try {
      // ISpect.logger is available globally after ISpect.run() is called
      // Insert at the beginning to capture all requests
      dio.interceptors.insert(
        0,
        ISpectDioInterceptor(
          logger: ISpect.logger,
          settings: const ISpectDioInterceptorSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
            printRequestData: true,
            printResponseData: true,
          ),
        ),
      );
    } catch (e) {
      // If ISpect is not initialized yet, continue without interceptor
      // This can happen during provider initialization
      // The interceptor will be added when provider is recreated after ISpect init
    }
  }
  
  // Add logging interceptor (standard Dio logging)
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
    ),
  );
  
  return dio;
}

// ApiService provider
@riverpod
ApiService apiService(Ref ref) {
  return ApiService(ref.read(dioProvider));
}

// HTTP Methods providers with fpdart
@riverpod
Future<Either<ApiError, Map<String, dynamic>>> getData(Ref ref, Map<String, dynamic>? queries) async {
  final result = await safeApiCall(
    () async => await ref.read(apiServiceProvider).getData(queries ?? {}) as Map<String, dynamic>,
  ).run();
  return result;
}

@riverpod
Future<Either<ApiError, Map<String, dynamic>>> postData(Ref ref, Map<String, dynamic> data) async {
  final result = await safeApiCall(
    () async => await ref.read(apiServiceProvider).postData(data) as Map<String, dynamic>,
  ).run();
  return result;
}

@riverpod
Future<Either<ApiError, Map<String, dynamic>>> putData(Ref ref, Map<String, dynamic> data) async {
  final result = await safeApiCall(
    () async => await ref.read(apiServiceProvider).putData(data) as Map<String, dynamic>,
  ).run();
  return result;
}

@riverpod
Future<Either<ApiError, Map<String, dynamic>>> deleteData(Ref ref) async {
  final result = await safeApiCall(
    () async => await ref.read(apiServiceProvider).deleteData() as Map<String, dynamic>,
  ).run();
  return result;
}

@riverpod
Future<Either<ApiError, Map<String, dynamic>>> getHeaders(Ref ref) async {
  final result = await safeApiCall(
    () async => await ref.read(apiServiceProvider).getHeaders() as Map<String, dynamic>,
  ).run();
  return result;
}

@riverpod
Future<Either<ApiError, Map<String, dynamic>>> getUserAgent(Ref ref) async {
  final result = await safeApiCall(
    () async => await ref.read(apiServiceProvider).getUserAgent() as Map<String, dynamic>,
  ).run();
  return result;
}
