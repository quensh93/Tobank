import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tobank_sdui/core/api/dio_factory.dart';
import '../../../stac_core/config/sdui_config.dart';
import '../utils/curl_logger.dart';
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
  static const String defaultBaseUrl = SduiConfig.configBaseUrl;

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
    if (dio != null) {
      // Use provided dio
      _dio = dio;
    } else {
      // Configure internal dio via factory
      _dio = DioFactory.plain(timeout: timeout);
      _dio.options.baseUrl = this.baseUrl;
    }
  }

  /// Fetch SDUI configuration from the API
  ///
  /// Returns the SDUI JSON content that can be rendered by STAC.
  ///
  /// [pathKey] - The path key for the configuration (e.g., 'flutter_key_1.flutter_promissory_key_1')
  /// [build] - The build version number
  /// [dimension] - Optional dimension filter (default: {'app': 'mobile'})
  /// [operator] - Optional operator (default: 'contains')
  ///
  /// Throws [ConfigApiException] on failure
  Future<Map<String, dynamic>> fetchSduiConfig({
    required String pathKey,
    required int build,
    Map<String, String>? dimension,
    String operator = 'contains',
  }) async {
    final request = ConfigApiRequest(
      pathKey: pathKey,
      build: build,
      operator: operator,
      dimension: dimension ?? const {'app': 'mobile'},
    );

    final url = '$baseUrl${request.endpoint}';
    final requestBody = request.toRequestBody();

    // Explicit headers matching CURL
    final headers = {'Content-Type': 'application/json', 'Accept': '*/*'};

    try {
      AppLogger.dc(LogCategory.network, 'Fetching SDUI config...');
      AppLogger.dc(LogCategory.network, 'URL: $url');

      // Manual CURL logging matching exactly what we are about to send
      final jsonBody = jsonEncode(requestBody);
      CurlLogger.log(
        method: 'POST',
        url: url,
        headers: headers,
        body: jsonBody,
        maskAuth: false,
      );

      final options = Options(
        headers: headers,
        sendTimeout: timeout,
        receiveTimeout: timeout,
      );

      // Using jsonEncode to be absolutely sure about the body format
      final response = await _dio.post(
        request.endpoint, // Dio appends this to baseUrl
        data: jsonBody,
        options: options,
      );

      AppLogger.dc(
        LogCategory.network,
        'RESPONSE ${response.statusCode}: SDUI config received',
      );

      // Log response body
      try {
        final responseStr = jsonEncode(response.data);
        AppLogger.dc(LogCategory.network, '   Body: $responseStr');
      } catch (e) {
        AppLogger.dc(
          LogCategory.network,
          '   Body: (Error encoding response: $e)',
        );
      }

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
    String operator = 'contains',
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
