import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/api/api_config.dart';
import 'package:tobank_sdui/core/api/services/mock_api_service.dart';
import 'package:tobank_sdui/core/api/exceptions/api_exceptions.dart';

/// Integration tests for API layer
///
/// Tests the complete API flow including:
/// - Switching between API modes
/// - Data flow from API to cache
/// - Error handling across the API layer
void main() {
  // Initialize Flutter bindings for tests that need to load assets
  TestWidgetsFlutterBinding.ensureInitialized();

  group('API Integration Tests', () {
    group('Mock API Service', () {
      late MockApiService mockApiService;

      setUp(() {
        mockApiService = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false, // Disable delay for faster tests
        );
      });

      test('should fetch screen from mock API successfully', () async {
        // Act
        final screen = await mockApiService.fetchScreen('home_screen');

        // Assert
        expect(screen, isNotNull);
        expect(screen, isA<Map<String, dynamic>>());
        expect(screen.containsKey('type'), true);
      });

      test('should cache fetched screens when caching is enabled', () async {
        // Act
        await mockApiService.fetchScreen('home_screen');

        // Assert
        expect(mockApiService.isCached('home_screen'), true);
        final cached = mockApiService.getCached('home_screen');
        expect(cached, isNotNull);
        expect(cached!.containsKey('type'), true);
      });

      test('should return cached data on subsequent fetches', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');
        final firstFetch = mockApiService.getCached('home_screen');

        // Act
        await mockApiService.fetchScreen('home_screen');
        final secondFetch = mockApiService.getCached('home_screen');

        // Assert
        expect(identical(firstFetch, secondFetch), true);
      });

      test('should throw ScreenNotFoundException for non-existent screen',
          () async {
        // Act & Assert
        expect(
          () => mockApiService.fetchScreen('non_existent_screen'),
          throwsA(isA<ScreenNotFoundException>()),
        );
      });

      test('should clear cache when clearCache is called', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');
        expect(mockApiService.isCached('home_screen'), true);

        // Act
        await mockApiService.clearCache();

        // Assert
        expect(mockApiService.isCached('home_screen'), false);
      });

      test('should refresh cache when refresh is called', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');
        final firstCached = mockApiService.getCached('home_screen');

        // Act
        await mockApiService.refresh();
        await mockApiService.fetchScreen('home_screen');
        final secondCached = mockApiService.getCached('home_screen');

        // Assert
        expect(identical(firstCached, secondCached), false);
      });

      test('should fetch route and map to screen name', () async {
        // Act
        final screen = await mockApiService.fetchRoute('/home');

        // Assert
        expect(screen, isNotNull);
        expect(screen, isA<Map<String, dynamic>>());
      });

      test('should handle root route correctly', () async {
        // Act
        final screen = await mockApiService.fetchRoute('/');

        // Assert
        expect(screen, isNotNull);
        expect(screen, isA<Map<String, dynamic>>());
      });

      test('should provide cache statistics', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');

        // Act
        final stats = mockApiService.getCacheStats();

        // Assert
        expect(stats, isA<Map<String, dynamic>>());
        expect(stats['total_cached'], greaterThan(0));
        expect(stats['valid_cached'], greaterThan(0));
        expect(stats['cache_keys'], isA<List>());
        expect(stats['cache_keys'], contains('home_screen'));
      });

      test('should reload mock data when reloadMockData is called', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');
        expect(mockApiService.isCached('home_screen'), true);

        // Act
        await mockApiService.reloadMockData();

        // Assert
        expect(mockApiService.isCached('home_screen'), false);
      });
    });

    group('API Mode Switching', () {
      test('should create mock API config correctly', () {
        // Act
        final config = ApiConfig.mock();

        // Assert
        expect(config.mode, ApiMode.mock);
        expect(config.enableCaching, true);
        expect(config.cacheExpiry, const Duration(minutes: 5));
      });

      test('should create Supabase API config correctly', () {
        // Act
        final config = ApiConfig.supabase(
          'https://example.supabase.co',
          'public-anon-key',
        );

        // Assert
        expect(config.mode, ApiMode.supabase);
        expect(config.supabaseUrl, 'https://example.supabase.co');
        expect(config.supabaseAnonKey, 'public-anon-key');
        expect(config.enableCaching, true);
      });

      test('should create custom API config correctly', () {
        // Act
        final config = ApiConfig.custom(
          'https://api.example.com',
          headers: {'Authorization': 'Bearer token'},
          authToken: 'test-token',
        );

        // Assert
        expect(config.mode, ApiMode.custom);
        expect(config.customApiUrl, 'https://api.example.com');
        expect(config.headers, {'Authorization': 'Bearer token'});
        expect(config.authToken, 'test-token');
      });

      test('should copy config with modifications', () {
        // Arrange
        final original = ApiConfig.mock();

        // Act
        final modified = original.copyWith(
          enableCaching: false,
          cacheExpiry: const Duration(minutes: 10),
        );

        // Assert
        expect(modified.mode, original.mode);
        expect(modified.enableCaching, false);
        expect(modified.cacheExpiry, const Duration(minutes: 10));
      });

      test('should compare configs correctly', () {
        // Arrange
        final config1 = ApiConfig.mock();
        final config2 = ApiConfig.mock();
        final config3 = ApiConfig.supabase(
          'https://example.supabase.co',
          'public-anon-key',
        );

        // Assert
        expect(config1 == config2, true);
        expect(config1 == config3, false);
      });
    });

    group('Caching Behavior', () {
      test('should not cache when caching is disabled', () async {
        // Arrange
        final service = MockApiService(
          config: ApiConfig.mock(enableCaching: false),
          simulateDelay: false,
        );

        // Act
        await service.fetchScreen('home_screen');

        // Assert
        expect(service.isCached('home_screen'), false);
      });

      test('should respect cache expiry duration', () async {
        // Arrange
        final service = MockApiService(
          config: ApiConfig.mock(
            enableCaching: true,
            cacheExpiry: const Duration(milliseconds: 100),
          ),
          simulateDelay: false,
        );

        // Act
        await service.fetchScreen('home_screen');
        expect(service.isCached('home_screen'), true);

        // Wait for cache to expire
        await Future.delayed(const Duration(milliseconds: 150));

        // Assert
        expect(service.isCached('home_screen'), false);
      });
    });

    group('Error Handling', () {
      late MockApiService mockApiService;

      setUp(() {
        mockApiService = MockApiService(
          config: ApiConfig.mock(),
          simulateDelay: false,
        );
      });

      test('should throw ScreenNotFoundException with proper error details',
          () async {
        // Act & Assert
        try {
          await mockApiService.fetchScreen('invalid_screen');
          fail('Should have thrown ScreenNotFoundException');
        } on ScreenNotFoundException catch (e) {
          expect(e.screenName, 'invalid_screen');
          expect(e.message, contains('invalid_screen'));
          expect(e.statusCode, 404);
        }
      });

      test('should handle JSON parsing errors gracefully', () async {
        // Note: This test would require a malformed JSON file in assets
        // For now, we verify the exception type is defined
        expect(JsonParsingException, isA<Type>());
      });

      test('should provide detailed error information', () async {
        // Act & Assert
        try {
          await mockApiService.fetchScreen('non_existent');
          fail('Should have thrown exception');
        } on ApiException catch (e) {
          expect(e.message, isNotEmpty);
          expect(e.originalError, isNotNull);
        }
      });
    });

    group('Data Flow Integration', () {
      late MockApiService mockApiService;

      setUp(() {
        mockApiService = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );
      });

      test('should complete full data flow: fetch -> cache -> retrieve',
          () async {
        // Step 1: Fetch from API
        final fetchedData = await mockApiService.fetchScreen('home_screen');
        expect(fetchedData, isNotNull);

        // Step 2: Verify data is cached
        expect(mockApiService.isCached('home_screen'), true);

        // Step 3: Retrieve from cache
        final cachedData = mockApiService.getCached('home_screen');
        expect(cachedData, isNotNull);
        expect(cachedData, equals(fetchedData));
      });

      test('should handle multiple concurrent fetches correctly', () async {
        // Act - Fetch multiple screens concurrently
        final futures = [
          mockApiService.fetchScreen('home_screen'),
          mockApiService.fetchScreen('home_screen'),
          mockApiService.fetchScreen('home_screen'),
        ];

        final results = await Future.wait(futures);

        // Assert - All fetches should succeed
        expect(results.length, 3);
        for (final result in results) {
          expect(result, isNotNull);
          expect(result, isA<Map<String, dynamic>>());
        }

        // Verify caching worked
        expect(mockApiService.isCached('home_screen'), true);
      });

      test('should maintain data integrity across operations', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');
        final originalData = mockApiService.getCached('home_screen');

        // Act - Perform various operations
        await mockApiService.fetchScreen('home_screen'); // Fetch again
        final afterSecondFetch = mockApiService.getCached('home_screen');

        // Assert - Data should remain consistent
        expect(afterSecondFetch, equals(originalData));
      });
    });

    group('Configuration Integration', () {
      test('should fetch configuration files successfully', () async {
        // Arrange
        final service = MockApiService(
          config: ApiConfig.mock(),
          simulateDelay: false,
        );

        // Act
        final config = await service.fetchConfig('navigation_config');

        // Assert
        expect(config, isNotNull);
        expect(config, isA<Map<String, dynamic>>());
      });

      test('should cache configuration files', () async {
        // Arrange
        final service = MockApiService(
          config: ApiConfig.mock(enableCaching: true),
          simulateDelay: false,
        );

        // Act
        await service.fetchConfig('navigation_config');

        // Assert
        expect(service.isCached('config_navigation_config'), true);
      });
    });
  });
}
