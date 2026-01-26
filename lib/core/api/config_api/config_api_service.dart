import 'package:dio/dio.dart';
import 'package:ispect/ispect.dart';
import 'package:ispectify_dio/ispectify_dio.dart';
import '../../helpers/logger.dart';
import 'config_api_models.dart';

/// Service for fetching SDUI configurations from the real API
///
/// This service handles requests to the configuration API endpoint
/// which returns Server-Driven UI content for dynamic screens.
///
/// ## Usage:
/// ```dart
/// final service = ConfigApiService();
/// final sduiJson = await service.fetchSduiConfig(
///   pathKey: 'flutter_key_1.flutter_promissory_key_1',
///   build: 1,
/// );
/// ```
class ConfigApiService {
  /// Base URL for the configuration API
  static const String defaultBaseUrl = 'http://192.168.179.21:8101';

  /// Dio HTTP client
  late final Dio _dio;

  /// Base URL
  final String baseUrl;

  /// Request timeout duration
  final Duration timeout;

  /// Create a new ConfigApiService
  ///
  /// [baseUrl] - The base URL for the API (default: http://192.168.179.21:8101)
  /// [timeout] - Request timeout (default: 30 seconds)
  ConfigApiService({
    String? baseUrl,
    this.timeout = const Duration(seconds: 30),
    Dio? dio,
  }) : baseUrl = baseUrl ?? defaultBaseUrl {
    _dio = dio ?? _createDio();
  }

  /// Create and configure Dio instance
  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
      ),
    );

    // Add ISpect logging interceptor for Debug Panel
    dio.interceptors.add(
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

    return dio;
  }

  /// Fetch SDUI configuration from the API
  ///
  /// Returns the SDUI JSON content that can be rendered by STAC.
  ///
  /// [pathKey] - The path key for the configuration (e.g., 'flutter_key_1.flutter_promissory_key_1')
  /// [build] - The build version number
  /// [dimension] - Optional dimension filter (default: {'app': 'mobile'})
  /// [operator] - Optional operator (default: 'is')
  ///
  /// Throws [ConfigApiException] on failure
  Future<Map<String, dynamic>> fetchSduiConfig({
    required String pathKey,
    required int build,
    Map<String, String>? dimension,
    String operator = 'is',
  }) async {
    final request = ConfigApiRequest(
      pathKey: pathKey,
      build: build,
      operator: operator,
      dimension: dimension ?? const {'app': 'mobile'},
    );

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        request.endpoint,
        data: request.toRequestBody(),
        queryParameters: request.toQueryParams(),
      );

      if (response.data == null) {
        throw ConfigApiException('Response data is null');
      }

      final apiResponse = ConfigApiResponse.fromJson(response.data!);

      if (!apiResponse.isSuccess) {
        throw ConfigApiException(
          'API returned error: ${apiResponse.status.description}',
          statusCode: apiResponse.status.code,
          messages: apiResponse.status.message,
        );
      }

      final sduiContent = apiResponse.sduiContent;
      if (sduiContent == null) {
        throw ConfigApiException('No SDUI content found in response');
      }

      return sduiContent;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is ConfigApiException) rethrow;
      throw ConfigApiException('Unexpected error: $e');
    }
  }

  /// Fetch the full API response (for debugging or advanced use cases)
  ///
  /// Returns the complete [ConfigApiResponse] object
  Future<ConfigApiResponse> fetchFullResponse({
    required String pathKey,
    required int build,
    Map<String, String>? dimension,
    String operator = 'is',
  }) async {
    final request = ConfigApiRequest(
      pathKey: pathKey,
      build: build,
      operator: operator,
      dimension: dimension ?? const {'app': 'mobile'},
    );

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        request.endpoint,
        data: request.toRequestBody(),
        queryParameters: request.toQueryParams(),
      );

      if (response.data == null) {
        throw ConfigApiException('Response data is null');
      }

      return ConfigApiResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is ConfigApiException) rethrow;
      throw ConfigApiException('Unexpected error: $e');
    }
  }

  /// Convert Dio errors to ConfigApiException
  ConfigApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ConfigApiException('Request timeout', isTimeout: true);

      case DioExceptionType.connectionError:
        return ConfigApiException(
          'Connection failed: ${error.message}',
          isConnectionError: true,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        return ConfigApiException(
          'Server error: ${error.response?.statusMessage ?? error.message}',
          httpStatusCode: statusCode,
        );

      default:
        return ConfigApiException(error.message ?? 'Unknown error occurred');
    }
  }

  /// Close the Dio client
  void dispose() {
    _dio.close();
  }
}

/// Exception thrown by ConfigApiService
class ConfigApiException implements Exception {
  final String message;
  final String? statusCode;
  final List<String>? messages;
  final int? httpStatusCode;
  final bool isTimeout;
  final bool isConnectionError;

  ConfigApiException(
    this.message, {
    this.statusCode,
    this.messages,
    this.httpStatusCode,
    this.isTimeout = false,
    this.isConnectionError = false,
  });

  @override
  String toString() => 'ConfigApiException: $message';
}
