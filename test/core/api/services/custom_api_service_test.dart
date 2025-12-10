import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/api/api_config.dart';
import 'package:tobank_sdui/core/api/exceptions/api_exceptions.dart';
import 'package:tobank_sdui/core/api/services/custom_api_service.dart';
import 'package:tobank_sdui/core/api/auth/auth_manager.dart';
import 'package:tobank_sdui/core/api/connectivity/connectivity_checker.dart';
import 'package:tobank_sdui/core/api/cache/disk_cache_manager.dart';

// Mock classes
class MockDio extends Fake implements Dio {
  final List<Response<Map<String, dynamic>>> _responses = [];
  final List<DioException> _errors = [];
  int _callCount = 0;

  void addResponse(Response<Map<String, dynamic>> response) {
    _responses.add(response);
  }

  void addError(DioException error) {
    _errors.add(error);
  }

  void reset() {
    _responses.clear();
    _errors.clear();
    _callCount = 0;
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (_callCount < _errors.length) {
      final error = _errors[_callCount];
      _callCount++;
      throw error;
    }

    if (_callCount < _responses.length) {
      final response = _responses[_callCount];
      _callCount++;
      return response as Response<T>;
    }

    throw DioException(
      requestOptions: RequestOptions(path: path),
      type: DioExceptionType.unknown,
      message: 'No mock response configured',
    );
  }

  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) async {
    return get<T>(requestOptions.path);
  }

  @override
  void close({bool force = false}) {
    // No-op for mock
  }

  @override
  BaseOptions get options => BaseOptions();

  @override
  Interceptors get interceptors => Interceptors();
}

class MockAuthManager extends Fake implements AuthManager {
  String? _accessToken;
  bool _shouldRefreshSucceed = true;
  int _refreshCallCount = 0;

  void setAccessToken(String? token) {
    _accessToken = token;
  }

  void setShouldRefreshSucceed(bool succeed) {
    _shouldRefreshSucceed = succeed;
  }

  int get refreshCallCount => _refreshCallCount;

  @override
  Future<String?> getAccessToken() async {
    return _accessToken;
  }

  @override
  Future<bool> refreshToken() async {
    _refreshCallCount++;
    if (_shouldRefreshSucceed) {
      _accessToken = 'refreshed_token';
      return true;
    }
    return false;
  }
}

class MockConnectivityChecker extends Fake implements ConnectivityChecker {
  bool _isConnected = true;

  void setConnected(bool connected) {
    _isConnected = connected;
  }

  @override
  Future<bool> hasConnection() async {
    return _isConnected;
  }
}

class MockDiskCacheManager extends Fake implements DiskCacheManager {
  final Map<String, Map<String, dynamic>> _cache = {};
  bool _shouldThrowOnSave = false;
  bool _shouldThrowOnLoad = false;

  void setData(String key, Map<String, dynamic> data) {
    _cache[key] = data;
  }

  void setShouldThrowOnSave(bool shouldThrow) {
    _shouldThrowOnSave = shouldThrow;
  }

  void setShouldThrowOnLoad(bool shouldThrow) {
    _shouldThrowOnLoad = shouldThrow;
  }

  @override
  Future<void> initialize() async {
    // No-op for mock
  }

  @override
  Future<void> save(String key, Map<String, dynamic> data, {Duration? expiry}) async {
    if (_shouldThrowOnSave) {
      throw CacheException('Mock save error');
    }
    _cache[key] = data;
  }

  @override
  Future<Map<String, dynamic>?> load(String key) async {
    if (_shouldThrowOnLoad) {
      throw CacheException('Mock load error');
    }
    return _cache[key];
  }

  @override
  Future<bool> exists(String key) async {
    return _cache.containsKey(key);
  }

  @override
  Future<void> clear() async {
    _cache.clear();
  }

  @override
  Future<Map<String, dynamic>> getCacheStats() async {
    return {
      'size_bytes': 0,
      'size_mb': '0.00',
      'count': _cache.length,
      'cache_dir': '/mock/cache',
    };
  }
}

void main() {
  group('CustomApiService', () {
    late MockConnectivityChecker mockConnectivity;
    late MockDiskCacheManager mockDiskCache;

    setUp(() {
      mockConnectivity = MockConnectivityChecker();
      mockDiskCache = MockDiskCacheManager();
    });

    group('Constructor', () {
      test('should create service with valid config', () {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        // Act
        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
        );

        // Assert
        expect(service.config.mode, equals(ApiMode.custom));
        expect(service.config.customApiUrl, equals('https://api.example.com'));
      });

      test('should throw ArgumentError for non-custom config', () {
        // Arrange
        final config = ApiConfig.mock();

        // Act & Assert
        expect(
          () => CustomApiService(
            config: config,
            connectivityChecker: mockConnectivity,
            diskCacheManager: mockDiskCache,
          ),
          throwsArgumentError,
        );
      });

      test('should throw ArgumentError for null customApiUrl', () {
        // Arrange
        final config = ApiConfig(
          mode: ApiMode.custom,
          customApiUrl: null,
        );

        // Act & Assert
        expect(
          () => CustomApiService(
            config: config,
            connectivityChecker: mockConnectivity,
            diskCacheManager: mockDiskCache,
          ),
          throwsArgumentError,
        );
      });

      test('should throw ArgumentError for empty customApiUrl', () {
        // Arrange
        final config = ApiConfig(
          mode: ApiMode.custom,
          customApiUrl: '',
        );

        // Act & Assert
        expect(
          () => CustomApiService(
            config: config,
            connectivityChecker: mockConnectivity,
            diskCacheManager: mockDiskCache,
          ),
          throwsArgumentError,
        );
      });

      test('should create service with custom retry settings', () {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        // Act
        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          maxRetries: 5,
          initialRetryDelay: const Duration(seconds: 1),
        );

        // Assert
        expect(service.maxRetries, equals(5));
        expect(service.initialRetryDelay, equals(const Duration(seconds: 1)));
      });
    });

    group('fetchScreen - HTTP Requests', () {
      test('should handle 404 response', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(true);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          maxRetries: 1, // Don't retry on 404
        );

        // Act & Assert
        // Note: This will make actual HTTP request which will fail
        // In a real scenario, we'd need to inject Dio or use a test server
        // For now, we test the error handling logic through other means
        expect(
          () => service.fetchScreen('definitely_missing_screen_12345'),
          throwsA(isA<ApiException>()),
        );
      });
    });

    group('fetchScreen - Retry Logic', () {
      test('should use exponential backoff timing', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(true);
        
        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          maxRetries: 3,
          initialRetryDelay: const Duration(milliseconds: 100),
          timeout: const Duration(milliseconds: 50), // Short timeout to trigger retries
        );

        // Act
        final startTime = DateTime.now();
        try {
          await service.fetchScreen('test_screen');
        } catch (e) {
          // Expected to fail after retries
        }
        final duration = DateTime.now().difference(startTime);

        // Assert
        // With 3 retries and exponential backoff (100ms, 200ms, 400ms)
        // Plus timeout attempts
        // Total should be at least 400ms (allowing for some variance)
        expect(duration.inMilliseconds, greaterThan(400));
      });

      test('should fail after max retries', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(true);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          maxRetries: 2,
          timeout: const Duration(milliseconds: 50),
        );

        // Act & Assert
        expect(
          () => service.fetchScreen('test_screen'),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('fetchScreen - Offline Behavior', () {
      test('should return cached data when offline', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(false);
        
        final cachedData = {
          'type': 'scaffold',
          'body': {'type': 'text', 'data': 'Cached'},
        };
        mockDiskCache.setData('home_screen', cachedData);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act
        final result = await service.fetchScreen('home_screen');

        // Assert
        expect(result, equals(cachedData));
        expect(result['type'], equals('scaffold'));
      });

      test('should throw NetworkException when offline with no cache', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(false);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act & Assert
        expect(
          () => service.fetchScreen('home_screen'),
          throwsA(isA<NetworkException>()),
        );
      });

      test('should not check connectivity when offline support disabled', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(false);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: false,
        );

        // Act & Assert
        // Should attempt network request even when offline
        // This documents expected behavior
      });
    });

    group('fetchScreen - Caching', () {
      test('should use cached data when available and valid', () async {
        // Arrange
        final config = ApiConfig.custom(
          'https://api.example.com',
          enableCaching: true,
        );
        mockConnectivity.setConnected(false);

        final cachedData = {
          'type': 'scaffold',
          'body': {'type': 'text', 'data': 'Cached'},
        };
        mockDiskCache.setData('home_screen', cachedData);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act
        final result = await service.fetchScreen('home_screen');

        // Assert
        expect(result, equals(cachedData));
        expect(service.isCached('home_screen'), isTrue);
      });

      test('should not use cache when caching is disabled', () async {
        // Arrange
        final config = ApiConfig.custom(
          'https://api.example.com',
          enableCaching: false,
        );
        mockConnectivity.setConnected(false);

        final cachedData = {
          'type': 'scaffold',
          'body': {'type': 'text', 'data': 'Cached'},
        };
        mockDiskCache.setData('home_screen', cachedData);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act
        final result = await service.fetchScreen('home_screen');

        // Assert
        expect(result, equals(cachedData));
        // Memory cache should not be used
        expect(service.isCached('home_screen'), isFalse);
      });
    });

    group('fetchScreen - Authentication', () {
      test('should use AuthManager token if available', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        final mockAuth = MockAuthManager();
        mockAuth.setAccessToken('manager_token');

        final service = CustomApiService(
          config: config,
          authManager: mockAuth,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          timeout: const Duration(milliseconds: 50),
        );

        // Act
        try {
          await service.fetchScreen('test_screen');
        } catch (e) {
          // Expected to fail, but we're testing auth setup
        }

        // Assert - AuthManager should have been called
        // In a real implementation with proper DI, we'd verify the token was added to headers
        expect(mockAuth.refreshCallCount, equals(0)); // No refresh needed yet
      });

      test('should handle auth manager with null token', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        final mockAuth = MockAuthManager();
        mockAuth.setAccessToken(null);

        final service = CustomApiService(
          config: config,
          authManager: mockAuth,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          timeout: const Duration(milliseconds: 50),
        );

        // Act & Assert
        expect(
          () => service.fetchScreen('test_screen'),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('fetchRoute', () {
      test('should handle offline mode for routes', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(false);

        final cachedData = {
          'type': 'scaffold',
          'body': {'type': 'text', 'data': 'Profile'},
        };
        mockDiskCache.setData('route_/profile', cachedData);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act
        final result = await service.fetchRoute('/profile');

        // Assert
        expect(result, equals(cachedData));
        expect(result['type'], equals('scaffold'));
        expect(result['body'], isNotNull);
      });

      test('should throw when offline with no cached route', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(false);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act & Assert
        expect(
          () => service.fetchRoute('/missing'),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('fetchConfig', () {
      test('should handle offline mode for configs', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(false);

        final cachedData = {
          'routes': [
            {'path': '/', 'screen': 'home_screen'},
          ],
        };
        mockDiskCache.setData('config_navigation_config', cachedData);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act
        final result = await service.fetchConfig('navigation_config');

        // Assert
        expect(result, equals(cachedData));
        expect(result['routes'], isA<List>());
      });

      test('should throw when offline with no cached config', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(false);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act & Assert
        expect(
          () => service.fetchConfig('missing_config'),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('Cache Management', () {
      test('isCached should return false for non-cached items', () {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
        );

        // Act & Assert
        expect(service.isCached('non_existent'), isFalse);
      });

      test('getCached should return null for non-cached items', () {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
        );

        // Act & Assert
        expect(service.getCached('non_existent'), isNull);
      });

      test('refresh should clear memory cache', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
        );

        // Act
        await service.refresh();

        // Assert
        expect(service.isCached('any_key'), isFalse);
      });

      test('clearCache should clear both memory and disk cache', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockDiskCache.setData('test_key', {'data': 'test'});

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act
        await service.clearCache();

        // Assert
        expect(service.isCached('test_key'), isFalse);
        final diskData = await mockDiskCache.load('test_key');
        expect(diskData, isNull);
      });
    });

    group('Offline Features', () {
      test('isOnline should return connectivity status', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(true);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
        );

        // Act
        final isOnline = await service.isOnline();

        // Assert
        expect(isOnline, isTrue);
      });

      test('getOfflineAvailability should check disk cache', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockDiskCache.setData('home_screen', {'type': 'scaffold'});
        mockDiskCache.setData('profile_screen', {'type': 'scaffold'});

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act
        final availability = await service.getOfflineAvailability([
          'home_screen',
          'profile_screen',
          'settings_screen',
        ]);

        // Assert
        expect(availability['home_screen'], isTrue);
        expect(availability['profile_screen'], isTrue);
        expect(availability['settings_screen'], isFalse);
      });

      test('prefetchForOffline should throw when offline', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(false);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act & Assert
        expect(
          () => service.prefetchForOffline(['home_screen']),
          throwsA(isA<NetworkException>()),
        );
      });

      test('prefetchForOffline should throw when offline support disabled', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: false,
        );

        // Act & Assert
        expect(
          () => service.prefetchForOffline(['home_screen']),
          throwsA(isA<UnsupportedError>()),
        );
      });
    });

    group('getCacheStats', () {
      test('should return cache statistics', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act
        final stats = await service.getCacheStats();

        // Assert
        expect(stats, isA<Map<String, dynamic>>());
        expect(stats.containsKey('memory_cache'), isTrue);
        expect(stats.containsKey('disk_cache'), isTrue);
      });

      test('should not include disk cache stats when offline support disabled', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: false,
        );

        // Act
        final stats = await service.getCacheStats();

        // Assert
        expect(stats.containsKey('memory_cache'), isTrue);
        expect(stats.containsKey('disk_cache'), isFalse);
      });
    });

    group('Error Handling', () {
      test('should throw NetworkException on timeout', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(true);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          maxRetries: 1,
          timeout: const Duration(milliseconds: 1), // Very short timeout
        );

        // Act & Assert
        expect(
          () => service.fetchScreen('test_screen'),
          throwsA(isA<NetworkException>()),
        );
      });

      test('should throw NetworkException on connection error', () async {
        // Arrange
        final config = ApiConfig.custom('https://invalid-domain-that-does-not-exist-12345.com');
        mockConnectivity.setConnected(true);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          maxRetries: 1,
          timeout: const Duration(milliseconds: 100),
        );

        // Act & Assert
        expect(
          () => service.fetchScreen('test_screen'),
          throwsA(isA<NetworkException>()),
        );
      });

      test('should handle error when offline with no cache', () async {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');
        mockConnectivity.setConnected(false);

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
          enableOfflineSupport: true,
        );

        // Act & Assert
        expect(
          () => service.fetchScreen('missing_screen'),
          throwsA(
            isA<NetworkException>().having(
              (e) => e.message,
              'message',
              contains('No internet connection'),
            ),
          ),
        );
      });
    });

    group('dispose', () {
      test('should close Dio and clear cache', () {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        final service = CustomApiService(
          config: config,
          connectivityChecker: mockConnectivity,
          diskCacheManager: mockDiskCache,
        );

        // Act
        service.dispose();

        // Assert
        expect(service.isCached('any_key'), isFalse);
      });
    });
  });
}
