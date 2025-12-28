import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../stac_api_service.dart';
import '../models/cached_data.dart';
import '../exceptions/api_exceptions.dart';
import '../api_config.dart';
import '../../logging/stac_log_interceptor.dart';
import '../../logging/stac_log_models.dart';
import '../../logging/stac_logger.dart';
import '../../validation/stac_json_validator.dart';

/// Mock API service implementation
///
/// Loads JSON configurations from local assets for development and testing.
/// Provides simulated network delays and caching capabilities.
class MockApiService implements StacApiService {
  /// API configuration
  final ApiConfig config;

  /// In-memory cache for loaded JSON data
  final Map<String, CachedData> _cache = {};

  /// Simulated network delay duration
  final Duration networkDelay;

  /// Whether to simulate network delays
  final bool simulateDelay;

  /// JSON validator for STAC structures
  final StacJsonValidator _validator = StacJsonValidator();

  MockApiService({
    ApiConfig? config,
    this.networkDelay = const Duration(milliseconds: 300),
    this.simulateDelay = true,
  }) : config = config ?? ApiConfig.mock();

  @override
  Future<Map<String, dynamic>> fetchScreen(String screenName) async {
    // Wrap the fetch operation with logging interceptor
    return StacLogInterceptor.interceptFetch(
      screenName: screenName,
      source: ApiSource.mock,
      operation: () async {
        // Check cache first if caching is enabled
        if (config.enableCaching && _isCacheValid(screenName)) {
          return _cache[screenName]!.data;
        }

        // Simulate network delay
        if (simulateDelay) {
          await Future.delayed(networkDelay);
        }

        try {
          // Load JSON from STAC build output directory
          // Convert screen name format (e.g., "home_screen" -> "tobank_home.json")
          String assetPath;
          String jsonString;

          // Remove _screen suffix and add tobank_ prefix
          String fileName = screenName.replaceAll('_screen', '');
          if (!fileName.startsWith('tobank_')) {
            fileName = 'tobank_$fileName';
          }
          assetPath = 'lib/stac/.build/$fileName.json';

          try {
            jsonString = await rootBundle.loadString(assetPath);
          } catch (_) {
            // Fallback: try with screen name as-is
            assetPath = 'lib/stac/.build/$screenName.json';
            jsonString = await rootBundle.loadString(assetPath);
          }

          final data = jsonDecode(jsonString) as Map<String, dynamic>;

          // Validate JSON structure before caching
          final validationResult = _validator.validate(data);
          if (!validationResult.isValid) {
            // Log validation errors
            StacLogger.logError(
              operation: 'JSON Validation',
              error: 'Invalid STAC JSON structure in $screenName',
              jsonPath: screenName,
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
              'JSON validation failed for $screenName: ${validationResult.summary}',
              jsonPath: screenName,
              originalError: validationResult.errors,
            );
          }

          // Log validation warnings if any
          if (validationResult.warnings.isNotEmpty) {
            for (final warning in validationResult.warnings) {
              StacLogger.logWarning(
                operation: 'JSON Validation',
                message: warning.message,
                jsonPath: warning.path,
              );
            }
          }

          // Cache the data if caching is enabled
          if (config.enableCaching) {
            _cache[screenName] = CachedData(
              data: data,
              timestamp: DateTime.now(),
              expiry: config.cacheExpiry,
            );
          }

          return data;
        } on FormatException catch (e, stackTrace) {
          // Invalid JSON format
          throw JsonParsingException(
            'Invalid JSON format in $screenName',
            jsonPath: screenName,
            originalError: e,
            stackTrace: stackTrace,
          );
        } catch (e, stackTrace) {
          // Asset not found or other errors
          if (e.toString().contains('Unable to load asset')) {
            throw ScreenNotFoundException(
              screenName,
              originalError: e,
              stackTrace: stackTrace,
            );
          }
          throw ApiException(
            'Failed to load screen: $screenName',
            originalError: e,
            stackTrace: stackTrace,
          );
        }
      },
      additionalMetadata: {
        'cached': config.enableCaching && _isCacheValid(screenName),
        'simulated_delay': simulateDelay,
      },
    );
  }

  @override
  Future<Map<String, dynamic>> fetchRoute(String route) async {
    // For mock API, we'll try to map routes to screen names
    // Remove leading slash and convert to screen name format
    final screenName = _routeToScreenName(route);
    return fetchScreen(screenName);
  }

  @override
  Future<void> refresh() async {
    // Clear cache to force reload
    _cache.clear();
  }

  @override
  Future<void> clearCache() async {
    _cache.clear();
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

  /// Reload mock data (useful for hot reload during development)
  ///
  /// Clears the cache and forces a reload of all data.
  /// This method is specific to MockApiService and not part of the interface.
  Future<void> reloadMockData() async {
    await clearCache();
    // Note: UI refresh should be triggered by the caller
  }

  /// Fetch configuration JSON (navigation, theme, etc.)
  ///
  /// Note: Config files are no longer used. This method is kept for compatibility.
  /// Returns empty map as config files have been removed.
  @override
  Future<Map<String, dynamic>> fetchConfig(String configName) async {
    // Check cache first if caching is enabled
    final cacheKey = 'config_$configName';
    if (config.enableCaching && _isCacheValid(cacheKey)) {
      return _cache[cacheKey]!.data;
    }

    // Simulate network delay
    if (simulateDelay) {
      await Future.delayed(networkDelay);
    }

    try {
      // Config files have been removed - return empty map
      // This method is kept for compatibility but no longer loads files
      final rawData = <String, dynamic>{};

      // Extract data from GET wrapper structure if present
      // Note: Config files are no longer available
      Map<String, dynamic> data;
      if (rawData.containsKey('GET') && rawData['GET'] is Map) {
        final getData = rawData['GET'] as Map<String, dynamic>;
        if (getData.containsKey('data')) {
          data = getData['data'] as Map<String, dynamic>;
        } else {
          data = rawData;
        }
      } else {
        data = rawData;
      }

      // Validate JSON structure before caching (if it's a STAC structure)
      // Config files may not always be STAC structures, so we validate only if they have a 'type' field
      if (data.containsKey('type')) {
        final validationResult = _validator.validate(data);
        if (!validationResult.isValid) {
          // Log validation errors
          StacLogger.logError(
            operation: 'Config Validation',
            error: 'Invalid STAC JSON structure in config: $configName',
            jsonPath: configName,
            suggestion: validationResult.errors.first.suggestion,
          );

          for (final error in validationResult.errors) {
            StacLogger.logError(
              operation: 'Validation Error',
              error: error.message,
              jsonPath: error.path,
              suggestion: error.suggestion,
            );
          }

          throw JsonParsingException(
            'Config validation failed for $configName: ${validationResult.summary}',
            jsonPath: configName,
            originalError: validationResult.errors,
          );
        }

        // Log validation warnings if any
        if (validationResult.warnings.isNotEmpty) {
          for (final warning in validationResult.warnings) {
            StacLogger.logWarning(
              operation: 'Config Validation',
              message: warning.message,
              jsonPath: warning.path,
            );
          }
        }
      }

      // Cache the data if caching is enabled
      if (config.enableCaching) {
        _cache[cacheKey] = CachedData(
          data: data,
          timestamp: DateTime.now(),
          expiry: config.cacheExpiry,
        );
      }

      return data;
    } on FormatException catch (e, stackTrace) {
      // Invalid JSON format
      throw JsonParsingException(
        'Invalid JSON format in config: $configName',
        jsonPath: configName,
        originalError: e,
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      // Asset not found or other errors
      if (e.toString().contains('Unable to load asset')) {
        throw ApiException(
          'Config not found: $configName',
          statusCode: 404,
          originalError: e,
          stackTrace: stackTrace,
        );
      }
      throw ApiException(
        'Failed to load config: $configName',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Get cache statistics
  ///
  /// Returns information about cached items for debugging purposes.
  Map<String, dynamic> getCacheStats() {
    final validCacheCount = _cache.values.where((c) => c.isValid).length;
    final expiredCacheCount = _cache.values.where((c) => c.isExpired).length;

    return {
      'total_cached': _cache.length,
      'valid_cached': validCacheCount,
      'expired_cached': expiredCacheCount,
      'cache_keys': _cache.keys.toList(),
    };
  }

  /// Check if cached data is valid
  bool _isCacheValid(String key) {
    if (!_cache.containsKey(key)) return false;
    return _cache[key]!.isValid;
  }

  /// Convert route to screen name
  ///
  /// Examples:
  /// - "/" -> "home_screen"
  /// - "/profile" -> "profile_screen"
  /// - "/settings/account" -> "settings_account_screen"
  String _routeToScreenName(String route) {
    if (route == '/') {
      return 'home_screen';
    }

    // Remove leading slash and replace remaining slashes with underscores
    final screenName = route
        .replaceFirst(RegExp(r'^/'), '')
        .replaceAll('/', '_');

    // Add _screen suffix if not present
    if (!screenName.endsWith('_screen')) {
      return '${screenName}_screen';
    }

    return screenName;
  }
}
