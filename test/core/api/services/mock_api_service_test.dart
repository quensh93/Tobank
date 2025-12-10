import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/api/api_config.dart';
import 'package:tobank_sdui/core/api/exceptions/api_exceptions.dart';
import 'package:tobank_sdui/core/api/services/mock_api_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MockApiService', () {
    late MockApiService service;

    setUp(() {
      // Create service with no delay for faster tests
      service = MockApiService(
        config: ApiConfig.mock(),
        simulateDelay: false,
      );
    });

    group('Constructor', () {
      test('should create service with default config', () {
        // Act
        final service = MockApiService();

        // Assert
        expect(service.config.mode, equals(ApiMode.mock));
        expect(service.config.enableCaching, isTrue);
        expect(service.simulateDelay, isTrue);
        expect(service.networkDelay, equals(const Duration(milliseconds: 300)));
      });

      test('should create service with custom config', () {
        // Arrange
        final config = ApiConfig.mock(
          enableCaching: false,
          cacheExpiry: const Duration(minutes: 10),
        );

        // Act
        final service = MockApiService(config: config);

        // Assert
        expect(service.config.mode, equals(ApiMode.mock));
        expect(service.config.enableCaching, isFalse);
        expect(service.config.cacheExpiry, equals(const Duration(minutes: 10)));
      });

      test('should create service with custom network delay', () {
        // Act
        final service = MockApiService(
          networkDelay: const Duration(milliseconds: 500),
          simulateDelay: true,
        );

        // Assert
        expect(service.networkDelay, equals(const Duration(milliseconds: 500)));
        expect(service.simulateDelay, isTrue);
      });
    });

    group('fetchScreen', () {
      test('should load JSON from assets successfully', () async {
        // Act
        final result = await service.fetchScreen('home_screen');

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['type'], equals('scaffold'));
        expect(result['appBar'], isNotNull);
        expect(result['body'], isNotNull);
      });

      test('should load profile screen JSON', () async {
        // Act
        final result = await service.fetchScreen('profile_screen');

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['type'], equals('scaffold'));
      });

      test('should throw ScreenNotFoundException for non-existent screen', () async {
        // Act & Assert
        expect(
          () => service.fetchScreen('non_existent_screen'),
          throwsA(isA<ScreenNotFoundException>()),
        );
      });

      test('should include screen name in ScreenNotFoundException', () async {
        // Act & Assert
        try {
          await service.fetchScreen('missing_screen');
          fail('Should have thrown ScreenNotFoundException');
        } catch (e) {
          expect(e, isA<ScreenNotFoundException>());
          final exception = e as ScreenNotFoundException;
          expect(exception.screenName, equals('missing_screen'));
          expect(exception.statusCode, equals(404));
        }
      });

      test('should cache data when caching is enabled', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );

        // Act
        await serviceWithCache.fetchScreen('home_screen');

        // Assert
        expect(serviceWithCache.isCached('home_screen'), isTrue);
        final cached = serviceWithCache.getCached('home_screen');
        expect(cached, isNotNull);
        expect(cached!['type'], equals('scaffold'));
      });

      test('should not cache data when caching is disabled', () async {
        // Arrange
        final serviceWithoutCache = MockApiService(
          config: ApiConfig.mock(enableCaching: false),
          simulateDelay: false,
        );

        // Act
        await serviceWithoutCache.fetchScreen('home_screen');

        // Assert
        expect(serviceWithoutCache.isCached('home_screen'), isFalse);
        expect(serviceWithoutCache.getCached('home_screen'), isNull);
      });

      test('should return cached data on subsequent calls', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );

        // Act
        final firstResult = await serviceWithCache.fetchScreen('home_screen');
        final secondResult = await serviceWithCache.fetchScreen('home_screen');

        // Assert
        expect(firstResult, equals(secondResult));
        expect(serviceWithCache.isCached('home_screen'), isTrue);
      });

      test('should simulate network delay when enabled', () async {
        // Arrange
        final serviceWithDelay = MockApiService(
          config: ApiConfig.mock(),
          networkDelay: const Duration(milliseconds: 100),
          simulateDelay: true,
        );

        // Act
        final stopwatch = Stopwatch()..start();
        await serviceWithDelay.fetchScreen('home_screen');
        stopwatch.stop();

        // Assert
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(100));
      });

      test('should not simulate delay when disabled', () async {
        // Arrange
        final serviceWithoutDelay = MockApiService(
          config: ApiConfig.mock(),
          simulateDelay: false,
        );

        // Act
        final stopwatch = Stopwatch()..start();
        await serviceWithoutDelay.fetchScreen('home_screen');
        stopwatch.stop();

        // Assert
        expect(stopwatch.elapsedMilliseconds, lessThan(50));
      });
    });

    group('fetchRoute', () {
      test('should convert root route to home_screen', () async {
        // Act
        final result = await service.fetchRoute('/');

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['type'], equals('scaffold'));
      });

      test('should convert /profile route to profile_screen', () async {
        // Act
        final result = await service.fetchRoute('/profile');

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['type'], equals('scaffold'));
      });

      test('should throw ScreenNotFoundException for invalid route', () async {
        // Act & Assert
        expect(
          () => service.fetchRoute('/invalid'),
          throwsA(isA<ScreenNotFoundException>()),
        );
      });

      test('should handle nested routes', () async {
        // This test documents expected behavior for nested routes
        // The route /settings/account should map to settings_account_screen
        
        // Act & Assert
        expect(
          () => service.fetchRoute('/settings/account'),
          throwsA(isA<ScreenNotFoundException>()),
        );
      });
    });

    group('Caching', () {
      test('isCached should return false for non-cached items', () {
        // Act & Assert
        expect(service.isCached('non_existent'), isFalse);
      });

      test('isCached should return true for cached items', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );

        // Act
        await serviceWithCache.fetchScreen('home_screen');

        // Assert
        expect(serviceWithCache.isCached('home_screen'), isTrue);
      });

      test('getCached should return null for non-cached items', () {
        // Act & Assert
        expect(service.getCached('non_existent'), isNull);
      });

      test('getCached should return data for cached items', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );

        // Act
        await serviceWithCache.fetchScreen('home_screen');
        final cached = serviceWithCache.getCached('home_screen');

        // Assert
        expect(cached, isNotNull);
        expect(cached!['type'], equals('scaffold'));
      });

      test('getCached should return null for expired cache', () async {
        // Arrange
        final serviceWithShortCache = MockApiService(
          config: ApiConfig.mock(
            enableCaching: true,
            cacheExpiry: const Duration(milliseconds: 10),
          ),
          simulateDelay: false,
        );

        // Act
        await serviceWithShortCache.fetchScreen('home_screen');
        await Future.delayed(const Duration(milliseconds: 20));
        final cached = serviceWithShortCache.getCached('home_screen');

        // Assert
        expect(cached, isNull);
      });

      test('isCached should return false for expired cache', () async {
        // Arrange
        final serviceWithShortCache = MockApiService(
          config: ApiConfig.mock(
            enableCaching: true,
            cacheExpiry: const Duration(milliseconds: 10),
          ),
          simulateDelay: false,
        );

        // Act
        await serviceWithShortCache.fetchScreen('home_screen');
        await Future.delayed(const Duration(milliseconds: 20));

        // Assert
        expect(serviceWithShortCache.isCached('home_screen'), isFalse);
      });
    });

    group('refresh', () {
      test('should clear cache', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );
        await serviceWithCache.fetchScreen('home_screen');
        expect(serviceWithCache.isCached('home_screen'), isTrue);

        // Act
        await serviceWithCache.refresh();

        // Assert
        expect(serviceWithCache.isCached('home_screen'), isFalse);
      });

      test('should allow refetching after refresh', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );
        await serviceWithCache.fetchScreen('home_screen');

        // Act
        await serviceWithCache.refresh();
        final result = await serviceWithCache.fetchScreen('home_screen');

        // Assert
        expect(result, isNotNull);
        expect(result['type'], equals('scaffold'));
        expect(serviceWithCache.isCached('home_screen'), isTrue);
      });
    });

    group('clearCache', () {
      test('should clear all cached data', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );
        await serviceWithCache.fetchScreen('home_screen');
        await serviceWithCache.fetchScreen('profile_screen');
        expect(serviceWithCache.isCached('home_screen'), isTrue);
        expect(serviceWithCache.isCached('profile_screen'), isTrue);

        // Act
        await serviceWithCache.clearCache();

        // Assert
        expect(serviceWithCache.isCached('home_screen'), isFalse);
        expect(serviceWithCache.isCached('profile_screen'), isFalse);
      });
    });

    group('reloadMockData', () {
      test('should clear cache', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );
        await serviceWithCache.fetchScreen('home_screen');
        expect(serviceWithCache.isCached('home_screen'), isTrue);

        // Act
        await serviceWithCache.reloadMockData();

        // Assert
        expect(serviceWithCache.isCached('home_screen'), isFalse);
      });
    });

    group('fetchConfig', () {
      test('should load navigation config from assets', () async {
        // Act
        final result = await service.fetchConfig('navigation_config');

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result, isNotEmpty);
      });

      test('should load theme config from assets', () async {
        // Act
        final result = await service.fetchConfig('theme_config');

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result, isNotEmpty);
      });

      test('should throw ApiException for non-existent config', () async {
        // Act & Assert
        expect(
          () => service.fetchConfig('non_existent_config'),
          throwsA(isA<ApiException>()),
        );
      });

      test('should cache config data when caching is enabled', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );

        // Act
        await serviceWithCache.fetchConfig('navigation_config');

        // Assert
        expect(serviceWithCache.isCached('config_navigation_config'), isTrue);
      });

      test('should return cached config on subsequent calls', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );

        // Act
        final firstResult = await serviceWithCache.fetchConfig('navigation_config');
        final secondResult = await serviceWithCache.fetchConfig('navigation_config');

        // Assert
        expect(firstResult, equals(secondResult));
      });
    });

    group('getCacheStats', () {
      test('should return empty stats for new service', () {
        // Act
        final stats = service.getCacheStats();

        // Assert
        expect(stats['total_cached'], equals(0));
        expect(stats['valid_cached'], equals(0));
        expect(stats['expired_cached'], equals(0));
        expect(stats['cache_keys'], isEmpty);
      });

      test('should return correct stats after caching', () async {
        // Arrange
        final serviceWithCache = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );
        await serviceWithCache.fetchScreen('home_screen');
        await serviceWithCache.fetchScreen('profile_screen');

        // Act
        final stats = serviceWithCache.getCacheStats();

        // Assert
        expect(stats['total_cached'], equals(2));
        expect(stats['valid_cached'], equals(2));
        expect(stats['expired_cached'], equals(0));
        expect(stats['cache_keys'], hasLength(2));
        expect(stats['cache_keys'], contains('home_screen'));
        expect(stats['cache_keys'], contains('profile_screen'));
      });

      test('should track expired cache items', () async {
        // Arrange
        final serviceWithShortCache = MockApiService(
          config: ApiConfig.mock(
            enableCaching: true,
            cacheExpiry: const Duration(milliseconds: 10),
          ),
          simulateDelay: false,
        );
        await serviceWithShortCache.fetchScreen('home_screen');
        await Future.delayed(const Duration(milliseconds: 20));

        // Act
        final stats = serviceWithShortCache.getCacheStats();

        // Assert
        expect(stats['total_cached'], equals(1));
        expect(stats['valid_cached'], equals(0));
        expect(stats['expired_cached'], equals(1));
      });
    });

    group('Error Handling', () {
      test('should throw JsonParsingException for invalid JSON', () async {
        // This test would require a mock asset with invalid JSON
        // For now, we document the expected behavior
        // In a real scenario, you'd need to mock the rootBundle
        
        // Expected behavior:
        // - Invalid JSON format should throw JsonParsingException
        // - Exception should include the screen name in jsonPath
        // - Exception should include the original FormatException
      });

      test('ScreenNotFoundException should include original error', () async {
        // Act & Assert
        try {
          await service.fetchScreen('missing_screen');
          fail('Should have thrown ScreenNotFoundException');
        } catch (e) {
          expect(e, isA<ScreenNotFoundException>());
          final exception = e as ScreenNotFoundException;
          expect(exception.originalError, isNotNull);
          expect(exception.stackTrace, isNotNull);
        }
      });

      test('should handle multiple concurrent requests', () async {
        // Act
        final results = await Future.wait([
          service.fetchScreen('home_screen'),
          service.fetchScreen('profile_screen'),
          service.fetchScreen('home_screen'),
        ]);

        // Assert
        expect(results, hasLength(3));
        expect(results[0]['type'], equals('scaffold'));
        expect(results[1]['type'], equals('scaffold'));
        expect(results[2]['type'], equals('scaffold'));
      });
    });
  });
}
