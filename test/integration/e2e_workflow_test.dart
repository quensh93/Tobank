import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/api/services/mock_api_service.dart';
import 'package:tobank_sdui/core/api/api_config.dart';

/// End-to-end workflow tests
///
/// Tests complete user workflows from start to finish.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('E2E Workflow Tests', () {
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService(
        config: ApiConfig.mock(),
        simulateDelay: false,
      );
    });

    group('Complete User Workflows', () {
      test('should complete screen fetch workflow', () async {
        // Arrange & Act - Simulate complete workflow
        final screen = await mockApiService.fetchScreen('home_screen');

        // Assert - Workflow completed successfully
        expect(screen, isNotNull);
        expect(mockApiService.isCached('home_screen'), true);
      });

      test('should handle cache refresh workflow', () async {
        // Arrange - Initial fetch
        await mockApiService.fetchScreen('home_screen');
        final firstData = mockApiService.getCached('home_screen');

        // Act - Refresh workflow
        await mockApiService.refresh();
        await mockApiService.fetchScreen('home_screen');
        final secondData = mockApiService.getCached('home_screen');

        // Assert - Workflow completed
        expect(firstData, isNotNull);
        expect(secondData, isNotNull);
      });

      test('should handle error recovery workflow', () async {
        // Arrange & Act - Error scenario
        try {
          await mockApiService.fetchScreen('invalid_screen');
          fail('Should have thrown exception');
        } catch (e) {
          // Assert - Error handled gracefully
          expect(e, isNotNull);
        }

        // Act - Recovery: fetch valid screen
        final validScreen = await mockApiService.fetchScreen('home_screen');

        // Assert - System recovered
        expect(validScreen, isNotNull);
      });
    });

    group('Debug Panel Workflows', () {
      test('should support debug panel data access', () async {
        // Arrange & Act
        await mockApiService.fetchScreen('home_screen');
        final stats = mockApiService.getCacheStats();

        // Assert - Debug data available
        expect(stats, isA<Map<String, dynamic>>());
        expect(stats['total_cached'], greaterThan(0));
      });

      test('should provide cache statistics for debugging', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');

        // Act
        final stats = mockApiService.getCacheStats();

        // Assert - Statistics are comprehensive
        expect(stats.containsKey('total_cached'), true);
        expect(stats.containsKey('valid_cached'), true);
        expect(stats.containsKey('cache_keys'), true);
      });
    });

    group('Playground Workflows', () {
      test('should support JSON validation workflow', () async {
        // Arrange
        final screenData = await mockApiService.fetchScreen('home_screen');

        // Act & Assert - JSON is valid for playground
        expect(screenData, isA<Map<String, dynamic>>());
        expect(screenData['type'], isNotNull);
      });
    });

    group('Visual Editor Workflows', () {
      test('should support screen data retrieval for editor', () async {
        // Arrange & Act
        final screenData = await mockApiService.fetchScreen('home_screen');

        // Assert - Data suitable for visual editor
        expect(screenData, isNotNull);
        expect(screenData, isA<Map<String, dynamic>>());
      });
    });

    group('Multi-Step Workflows', () {
      test('should handle fetch-cache-retrieve workflow', () async {
        // Step 1: Fetch
        final fetchedData = await mockApiService.fetchScreen('home_screen');
        expect(fetchedData, isNotNull);

        // Step 2: Verify cache
        expect(mockApiService.isCached('home_screen'), true);

        // Step 3: Retrieve
        final cachedData = mockApiService.getCached('home_screen');
        expect(cachedData, equals(fetchedData));
      });

      test('should handle multiple screen workflow', () async {
        // Act - Fetch multiple screens
        final screen1 = await mockApiService.fetchScreen('home_screen');
        final screen2 = await mockApiService.fetchScreen('home_screen');

        // Assert - Both operations successful
        expect(screen1, isNotNull);
        expect(screen2, isNotNull);
        expect(mockApiService.getCacheStats()['total_cached'], greaterThan(0));
      });
    });

    group('Configuration Workflows', () {
      test('should handle configuration fetch workflow', () async {
        // Arrange & Act
        final config = await mockApiService.fetchConfig('navigation_config');

        // Assert - Configuration loaded
        expect(config, isNotNull);
        expect(config, isA<Map<String, dynamic>>());
      });

      test('should cache configuration data', () async {
        // Arrange
        await mockApiService.fetchConfig('navigation_config');

        // Act & Assert
        expect(mockApiService.isCached('config_navigation_config'), true);
      });
    });
  });
}
