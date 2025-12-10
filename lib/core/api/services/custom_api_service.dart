import 'dart:async';
import 'package:dio/dio.dart';
import '../stac_api_service.dart';
import '../models/cached_data.dart';
import '../exceptions/api_exceptions.dart';
import '../api_config.dart';
import '../auth/auth_manager.dart';
import '../connectivity/connectivity_checker.dart';
import '../cache/disk_cache_manager.dart';
import '../../logging/stac_log_interceptor.dart';
import '../../logging/stac_log_models.dart';
import '../../logging/stac_logger.dart';
import '../../validation/stac_json_validator.dart';

/// Custom REST API service implementation
///
/// Fetches JSON configurations from a custom REST API backend.
/// Provides retry logic, caching, and authentication support.
class CustomApiService implements StacApiService {
  /// API configuration
  final ApiConfig config;

  /// Dio HTTP client
  late final Dio _dio;

  /// Authentication manager (optional)
  final AuthManager? authManager;

  /// Connectivity checker
  final ConnectivityChecker connectivityChecker;

  /// Disk cache manager
  final DiskCacheManager diskCacheManager;

  /// In-memory cache for fetched JSON data
  final Map<String, CachedData> _cache = {};

  /// Whether to enable offline support
  final bool enableOfflineSupport;

  /// Maximum number of retry attempts
  final int maxRetries;

  /// Initial retry delay (will be multiplied exponentially)
  final Duration initialRetryDelay;

  /// Request timeout duration
  final Duration timeout;

  /// JSON validator for STAC structures
  final StacJsonValidator _validator = StacJsonValidator();

  CustomApiService({
    required this.config,
    this.authManager,
    ConnectivityChecker? connectivityChecker,
    DiskCacheManager? diskCacheManager,
    this.enableOfflineSupport = true,
    this.maxRetries = 3,
    this.initialRetryDelay = const Duration(milliseconds: 500),
    this.timeout = const Duration(seconds: 30),
  })  : connectivityChecker = connectivityChecker ?? ConnectivityChecker.instance,
        diskCacheManager = diskCacheManager ?? DiskCacheManager.instance {
    if (config.mode != ApiMode.custom) {
      throw ArgumentError('CustomApiService requires ApiMode.custom');
    }
    if (config.customApiUrl == null || config.customApiUrl!.isEmpty) {
      throw ArgumentError('customApiUrl is required for CustomApiService');
    }

    _initializeDio();
    
    // Initialize disk cache if offline support is enabled
    if (enableOfflineSupport) {
      this.diskCacheManager.initialize().catchError((_) {
        // Ignore initialization errors, will be handled when cache is used
      });
    }
  }

  /// Initialize Dio with configuration
  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: config.customApiUrl!,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...config.headers,
        },
      ),
    );

    // Add request interceptor for authentication
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token from AuthManager if available
          if (authManager != null) {
            final token = await authManager!.getAccessToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } else if (config.authToken != null) {
            // Fallback to config token if no AuthManager
            options.headers['Authorization'] = 'Bearer ${config.authToken}';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          // Handle 401 Unauthorized - try to refresh token
          if (error.response?.statusCode == 401 && authManager != null) {
            final refreshed = await authManager!.refreshToken();
            if (refreshed) {
              // Retry the request with new token
              final token = await authManager!.getAccessToken();
              if (token != null) {
                error.requestOptions.headers['Authorization'] = 'Bearer $token';
                try {
                  final response = await _dio.fetch(error.requestOptions);
                  return handler.resolve(response);
                } catch (e) {
                  // If retry fails, continue with error handling
                }
              }
            }
          }

          // Convert Dio errors to our custom exceptions
          final exception = _handleDioError(error);
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: exception,
              type: error.type,
            ),
          );
        },
      ),
    );
  }

  @override
  Future<Map<String, dynamic>> fetchScreen(String screenName) async {
    // Wrap the fetch operation with logging interceptor
    return StacLogInterceptor.interceptFetch(
      screenName: screenName,
      source: ApiSource.custom,
      operation: () async {
        // Check memory cache first if caching is enabled
        if (config.enableCaching && _isCacheValid(screenName)) {
          return _cache[screenName]!.data;
        }

        // Check connectivity if offline support is enabled
        if (enableOfflineSupport) {
          final isConnected = await connectivityChecker.hasConnection();
          
          if (!isConnected) {
            // Try to load from disk cache
            final cachedData = await diskCacheManager.load(screenName);
            if (cachedData != null) {
              // Update memory cache
              if (config.enableCaching) {
                _cache[screenName] = CachedData(
                  data: cachedData,
                  timestamp: DateTime.now(),
                  expiry: config.cacheExpiry,
                );
              }
              return cachedData;
            }
            
            // No cached data available
            throw NetworkException.connection(
              message: 'No internet connection and no cached data available',
            );
          }
        }

        // Fetch with retry logic
        final data = await _fetchWithRetry(
          () => _dio.get<Map<String, dynamic>>('/screens/$screenName'),
          screenName,
        );

        // Validate and cache the data
        return await _validateAndCache(data, screenName);
      },
      additionalMetadata: {
        'cached': config.enableCaching && _isCacheValid(screenName),
        'offline_support': enableOfflineSupport,
        'api_url': config.customApiUrl,
      },
    );
  }

  /// Validate JSON and cache if valid
  Future<Map<String, dynamic>> _validateAndCache(
    Map<String, dynamic> data,
    String key, {
    bool isConfig = false,
  }) async {
    // Validate JSON structure before caching
    // Config files may not always be STAC structures, so we validate only if they have a 'type' field
    if (!isConfig || data.containsKey('type')) {
      final validationResult = _validator.validate(data);
      if (!validationResult.isValid) {
        // Log validation errors
        StacLogger.logError(
          operation: isConfig ? 'Config Validation' : 'JSON Validation',
          error: 'Invalid STAC JSON structure in $key',
          jsonPath: key,
          suggestion: validationResult.errors.first.suggestion,
        );

        // Log all validation errors
        for (final error in validationResult.errors) {
          StacLogger.logError(
            operation: 'Validation Error',
            error: error.message,
            jsonPath: error.path,
            suggestion: error.suggestion,
          );
        }

        throw JsonParsingException(
          'JSON validation failed for $key: ${validationResult.summary}',
          jsonPath: key,
          originalError: validationResult.errors,
        );
      }

      // Log validation warnings if any
      if (validationResult.warnings.isNotEmpty) {
        for (final warning in validationResult.warnings) {
          StacLogger.logWarning(
            operation: isConfig ? 'Config Validation' : 'JSON Validation',
            message: warning.message,
            jsonPath: warning.path,
          );
        }
      }
    }

    // Cache the data if caching is enabled
    if (config.enableCaching) {
      _cache[key] = CachedData(
        data: data,
        timestamp: DateTime.now(),
        expiry: config.cacheExpiry,
      );
      
      // Save to disk cache for offline access
      if (enableOfflineSupport) {
        await diskCacheManager.save(
          key,
          data,
          expiry: const Duration(days: 7), // Longer expiry for offline cache
        );
      }
    }

    return data;
  }

  @override
  Future<Map<String, dynamic>> fetchRoute(String route) async {
    // Check memory cache first if caching is enabled
    final cacheKey = 'route_$route';
    if (config.enableCaching && _isCacheValid(cacheKey)) {
      return _cache[cacheKey]!.data;
    }

    // Check connectivity if offline support is enabled
    if (enableOfflineSupport) {
      final isConnected = await connectivityChecker.hasConnection();
      
      if (!isConnected) {
        // Try to load from disk cache
        final cachedData = await diskCacheManager.load(cacheKey);
        if (cachedData != null) {
          // Update memory cache
          if (config.enableCaching) {
            _cache[cacheKey] = CachedData(
              data: cachedData,
              timestamp: DateTime.now(),
              expiry: config.cacheExpiry,
            );
          }
          return cachedData;
        }
        
        // No cached data available
        throw NetworkException.connection(
          message: 'No internet connection and no cached data available',
        );
      }
    }

    // Fetch with retry logic
    final data = await _fetchWithRetry(
      () => _dio.get<Map<String, dynamic>>('/routes', queryParameters: {'path': route}),
      cacheKey,
    );

    // Validate and cache the data
    return await _validateAndCache(data, cacheKey);
  }

  @override
  Future<void> refresh() async {
    // Clear cache to force reload
    _cache.clear();
  }

  @override
  Future<void> clearCache() async {
    _cache.clear();
    
    // Also clear disk cache if offline support is enabled
    if (enableOfflineSupport) {
      await diskCacheManager.clear();
    }
  }

  @override
  bool isCached(String key) {
    return _cache.containsKey(key) && _cache[key]!.isValid;
  }

  @override
  Map<String, dynamic>? getCached(String key) {
    if (_isCacheValid(key)) {
      return _cache[key]!.data;
    }
    return null;
  }

  /// Fetch configuration JSON (navigation, theme, etc.)
  ///
  /// Fetches configuration files from the API endpoint
  Future<Map<String, dynamic>> fetchConfig(String configName) async {
    // Check memory cache first if caching is enabled
    final cacheKey = 'config_$configName';
    if (config.enableCaching && _isCacheValid(cacheKey)) {
      return _cache[cacheKey]!.data;
    }

    // Check connectivity if offline support is enabled
    if (enableOfflineSupport) {
      final isConnected = await connectivityChecker.hasConnection();
      
      if (!isConnected) {
        // Try to load from disk cache
        final cachedData = await diskCacheManager.load(cacheKey);
        if (cachedData != null) {
          // Update memory cache
          if (config.enableCaching) {
            _cache[cacheKey] = CachedData(
              data: cachedData,
              timestamp: DateTime.now(),
              expiry: config.cacheExpiry,
            );
          }
          return cachedData;
        }
        
        // No cached data available
        throw NetworkException.connection(
          message: 'No internet connection and no cached data available',
        );
      }
    }

    // Fetch with retry logic
    final data = await _fetchWithRetry(
      () => _dio.get<Map<String, dynamic>>('/config/$configName'),
      cacheKey,
    );

    // Validate and cache the data
    return await _validateAndCache(data, cacheKey, isConfig: true);
  }

  /// Fetch with exponential backoff retry logic
  Future<Map<String, dynamic>> _fetchWithRetry(
    Future<Response<Map<String, dynamic>>> Function() request,
    String resourceName,
  ) async {
    int attempt = 0;
    Duration delay = initialRetryDelay;

    while (attempt < maxRetries) {
      try {
        final response = await request();

        // Check if response is successful
        if (response.statusCode == null || response.statusCode! < 200 || response.statusCode! >= 300) {
          throw NetworkException.serverError(
            message: 'Server returned status ${response.statusCode}',
            statusCode: response.statusCode,
          );
        }

        // Extract data from response
        final data = response.data;
        if (data == null) {
          throw JsonParsingException(
            'Response data is null',
            jsonPath: resourceName,
          );
        }

        return data;
      } on DioException catch (e) {
        attempt++;

        // Check if we should retry
        if (attempt >= maxRetries || !_shouldRetry(e)) {
          throw _handleDioError(e);
        }

        // Wait before retrying with exponential backoff
        await Future.delayed(delay);
        delay *= 2; // Exponential backoff
      } catch (e, stackTrace) {
        // Non-Dio errors should not be retried
        if (e is ApiException) {
          rethrow;
        }
        throw ApiException(
          'Unexpected error fetching $resourceName',
          originalError: e,
          stackTrace: stackTrace,
        );
      }
    }

    // This should never be reached, but just in case
    throw NetworkException(
      'Failed to fetch $resourceName after $maxRetries attempts',
      errorType: NetworkErrorType.unknown,
    );
  }

  /// Check if the error should trigger a retry
  bool _shouldRetry(DioException error) {
    // Retry on timeout, connection errors, and 5xx server errors
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        // Retry on 5xx server errors
        final statusCode = error.response?.statusCode;
        return statusCode != null && statusCode >= 500 && statusCode < 600;
      default:
        return false;
    }
  }

  /// Convert Dio errors to custom API exceptions
  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException.timeout(
          message: 'Request timed out',
          originalError: error,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.connectionError:
        return NetworkException.connection(
          message: 'Connection failed: ${error.message}',
          originalError: error,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?.toString() ?? error.message;

        if (statusCode == 404) {
          // Extract resource name from URL if possible
          final path = error.requestOptions.path;
          final resourceName = path.split('/').last;
          return ScreenNotFoundException(
            resourceName,
            originalError: error,
            stackTrace: error.stackTrace,
          );
        } else if (statusCode == 401) {
          return NetworkException.unauthorized(
            message: message,
            originalError: error,
            stackTrace: error.stackTrace,
          );
        } else if (statusCode != null && statusCode >= 500) {
          return NetworkException.serverError(
            message: message,
            statusCode: statusCode,
            originalError: error,
            stackTrace: error.stackTrace,
          );
        }

        return NetworkException(
          message ?? 'Bad response from server',
          errorType: NetworkErrorType.badRequest,
          statusCode: statusCode,
          originalError: error,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.cancel:
        return ApiException(
          'Request was cancelled',
          originalError: error,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          'SSL certificate verification failed',
          errorType: NetworkErrorType.connection,
          originalError: error,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.unknown:
        return ApiException(
          error.message ?? 'Unknown error occurred',
          originalError: error,
          stackTrace: error.stackTrace,
        );
    }
  }

  /// Check if cached data is valid
  bool _isCacheValid(String key) {
    if (!_cache.containsKey(key)) return false;
    return _cache[key]!.isValid;
  }

  /// Get cache statistics
  ///
  /// Returns information about cached items for debugging purposes.
  Future<Map<String, dynamic>> getCacheStats() async {
    final validCacheCount = _cache.values.where((c) => c.isValid).length;
    final expiredCacheCount = _cache.values.where((c) => c.isExpired).length;

    final stats = <String, dynamic>{
      'memory_cache': {
        'total_cached': _cache.length,
        'valid_cached': validCacheCount,
        'expired_cached': expiredCacheCount,
        'cache_keys': _cache.keys.toList(),
      },
    };

    // Add disk cache stats if offline support is enabled
    if (enableOfflineSupport) {
      final diskStats = await diskCacheManager.getCacheStats();
      stats['disk_cache'] = diskStats;
    }

    return stats;
  }

  /// Check if device is currently online
  Future<bool> isOnline() async {
    return await connectivityChecker.hasConnection();
  }

  /// Get offline cache availability
  ///
  /// Returns a map of screen names and whether they're available offline
  Future<Map<String, bool>> getOfflineAvailability(List<String> screenNames) async {
    final availability = <String, bool>{};

    for (final screenName in screenNames) {
      availability[screenName] = await diskCacheManager.exists(screenName);
    }

    return availability;
  }

  /// Prefetch screens for offline use
  ///
  /// Downloads and caches screens for offline access
  Future<void> prefetchForOffline(List<String> screenNames) async {
    if (!enableOfflineSupport) {
      throw UnsupportedError('Offline support is not enabled');
    }

    final isConnected = await connectivityChecker.hasConnection();
    if (!isConnected) {
      throw NetworkException.connection(
        message: 'Cannot prefetch screens while offline',
      );
    }

    for (final screenName in screenNames) {
      try {
        // Fetch the screen (this will automatically cache it)
        await fetchScreen(screenName);
      } catch (e) {
        // Continue with other screens even if one fails
        continue;
      }
    }
  }

  /// Close the Dio client and clean up resources
  void dispose() {
    _dio.close();
    _cache.clear();
  }
}
