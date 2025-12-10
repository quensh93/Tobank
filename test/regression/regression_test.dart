import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/api/services/mock_api_service.dart';
import 'package:tobank_sdui/core/api/api_config.dart';
import 'package:tobank_sdui/core/api/exceptions/api_exceptions.dart';

/// Regression test suite
///
/// Ensures that existing functionality continues to work after changes.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Regression Tests', () {
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService(
        config: ApiConfig.mock(),
        simulateDelay: false,
      );
    });

    group('API Layer Regression', () {
      test('should maintain fetchScreen functionality', () async {
        // Act
        final screen = await mockApiService.fetchScreen('home_screen');

        // Assert - Core functionality unchanged
        expect(screen, isNotNull);
        expect(screen, isA<Map<String, dynamic>>());
        expect(screen.containsKey('type'), true);
      });

      test('should maintain caching functionality', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');

        // Act & Assert - Caching still works
        expect(mockApiService.isCached('home_screen'), true);
        final cached = mockApiService.getCached('home_screen');
        expect(cached, isNotNull);
      });

      test('should maintain error handling', () async {
        // Act & Assert - Error handling unchanged
        expect(
          () => mockApiService.fetchScreen('invalid_screen'),
          throwsA(isA<ScreenNotFoundException>()),
        );
      });

      test('should maintain cache clearing', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');

        // Act
        await mockApiService.clearCache();

        // Assert - Cache clearing still works
        expect(mockApiService.isCached('home_screen'), false);
      });

      test('should maintain refresh functionality', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');

        // Act
        await mockApiService.refresh();

        // Assert - Refresh still works
        expect(mockApiService.isCached('home_screen'), false);
      });
    });

    group('Configuration Regression', () {
      test('should maintain API config creation', () {
        // Act
        final mockConfig = ApiConfig.mock();
        final supabaseConfig = ApiConfig.supabase(
          'https://example.supabase.co',
          'public-anon-key',
        );
        final customConfig = ApiConfig.custom('https://api.test.com');

        // Assert - Config creation unchanged
        expect(mockConfig.mode, ApiMode.mock);
        expect(supabaseConfig.mode, ApiMode.supabase);
        expect(customConfig.mode, ApiMode.custom);
      });

      test('should maintain config properties', () {
        // Act
        final config = ApiConfig.mock(
          enableCaching: false,
          cacheExpiry: const Duration(minutes: 10),
        );

        // Assert - Properties still accessible
        expect(config.enableCaching, false);
        expect(config.cacheExpiry, const Duration(minutes: 10));
      });

      test('should maintain config copyWith', () {
        // Arrange
        final original = ApiConfig.mock();

        // Act
        final modified = original.copyWith(enableCaching: false);

        // Assert - copyWith still works
        expect(modified.enableCaching, false);
        expect(modified.mode, original.mode);
      });
    });

    group('Data Model Regression', () {
      test('should maintain JSON structure', () async {
        // Act
        final screen = await mockApiService.fetchScreen('home_screen');

        // Assert - JSON structure unchanged
        expect(screen, isA<Map<String, dynamic>>());
        expect(screen['type'], isA<String>());
      });

      test('should maintain cache data structure', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');

        // Act
        final cached = mockApiService.getCached('home_screen');

        // Assert - Cache data structure unchanged
        expect(cached, isA<Map<String, dynamic>>());
      });
    });

    group('Performance Regression', () {
      test('should maintain fetch performance', () async {
        // Arrange
        final stopwatch = Stopwatch()..start();

        // Act
        await mockApiService.fetchScreen('home_screen');
        stopwatch.stop();

        // Assert - Performance not degraded (< 100ms)
        expect(stopwatch.elapsedMilliseconds, lessThan(100));
      });

      test('should maintain cache performance', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');
        final stopwatch = Stopwatch()..start();

        // Act
        mockApiService.getCached('home_screen');
        stopwatch.stop();

        // Assert - Cache access still fast (< 10ms)
        expect(stopwatch.elapsedMilliseconds, lessThan(10));
      });
    });

    group('Backward Compatibility', () {
      test('should support legacy API calls', () async {
        // Act - Old API style should still work
        final screen = await mockApiService.fetchScreen('home_screen');

        // Assert
        expect(screen, isNotNull);
      });

      test('should support existing config formats', () {
        // Act - Old config creation should work
        final config = ApiConfig.mock();

        // Assert
        expect(config, isNotNull);
        expect(config.mode, ApiMode.mock);
      });

      test('should maintain exception types', () async {
        // Act & Assert - Exception types unchanged
        try {
          await mockApiService.fetchScreen('invalid');
          fail('Should throw');
        } on ScreenNotFoundException catch (e) {
          expect(e, isA<ScreenNotFoundException>());
          expect(e, isA<ApiException>());
        }
      });
    });

    group('Integration Points Regression', () {
      test('should maintain API service interface', () {
        // Assert - Interface unchanged
        expect(mockApiService.fetchScreen, isA<Function>());
        expect(mockApiService.clearCache, isA<Function>());
        expect(mockApiService.refresh, isA<Function>());
        expect(mockApiService.isCached, isA<Function>());
        expect(mockApiService.getCached, isA<Function>());
      });

      test('should maintain config interface', () {
        // Arrange
        final config = ApiConfig.mock();

        // Assert - Config interface unchanged
        expect(config.mode, isA<ApiMode>());
        expect(config.enableCaching, isA<bool>());
        expect(config.cacheExpiry, isA<Duration>());
      });
    });

    group('Feature Compatibility', () {
      test('should work with new features', () async {
        // Act - New and old features should coexist
        await mockApiService.fetchScreen('home_screen');
        final stats = mockApiService.getCacheStats();

        // Assert - Both work together
        expect(mockApiService.isCached('home_screen'), true);
        expect(stats, isNotNull);
      });

      test('should maintain data integrity with new features', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');
        final originalData = mockApiService.getCached('home_screen');

        // Act - Use new feature (stats)
        mockApiService.getCacheStats();

        // Assert - Original data unchanged
        final dataAfter = mockApiService.getCached('home_screen');
        expect(dataAfter, equals(originalData));
      });
    });

    group('Error Handling Regression', () {
      test('should maintain error message format', () async {
        // Act & Assert
        try {
          await mockApiService.fetchScreen('invalid_screen');
          fail('Should throw');
        } on ScreenNotFoundException catch (e) {
          expect(e.message, contains('invalid_screen'));
          expect(e.statusCode, 404);
        }
      });

      test('should maintain error recovery', () async {
        // Arrange - Cause error
        try {
          await mockApiService.fetchScreen('invalid');
        } catch (_) {}

        // Act - Should recover
        final validScreen = await mockApiService.fetchScreen('home_screen');

        // Assert - System recovered
        expect(validScreen, isNotNull);
      });
    });
  });
}
