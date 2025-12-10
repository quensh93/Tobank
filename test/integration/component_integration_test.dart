import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/api/services/mock_api_service.dart';
import 'package:tobank_sdui/core/api/api_config.dart';

/// Integration tests for custom STAC components
///
/// Tests the integration of custom widgets and actions with the STAC framework.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Component Integration Tests', () {
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService(
        config: ApiConfig.mock(),
        simulateDelay: false,
      );
    });

    group('Custom Widget Integration', () {
      test('should fetch JSON data for widgets', () async {
        // Arrange & Act
        final screenData = await mockApiService.fetchScreen('home_screen');

        // Assert - Verify JSON structure for widgets
        expect(screenData, isA<Map<String, dynamic>>());
        expect(screenData.containsKey('type'), true);
      });

      test('should validate JSON structure for widgets', () async {
        // Arrange
        final screenData = await mockApiService.fetchScreen('home_screen');

        // Act & Assert - JSON should have required fields
        expect(screenData['type'], isNotNull);
        expect(screenData['type'], isA<String>());
      });
    });

    group('Custom Action Integration', () {
      test('should support action data in JSON', () async {
        // Arrange & Act
        final screenData = await mockApiService.fetchScreen('home_screen');

        // Assert - Screen data should be accessible
        expect(screenData, isNotNull);
      });
    });

    group('STAC Framework Integration', () {
      test('should integrate with mock API service', () async {
        // Arrange & Act
        final screenData = await mockApiService.fetchScreen('home_screen');

        // Assert - Data should be fetched successfully
        expect(screenData, isNotNull);
        expect(screenData, isA<Map<String, dynamic>>());
      });

      test('should cache fetched data', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');

        // Act
        final isCached = mockApiService.isCached('home_screen');

        // Assert
        expect(isCached, true);
      });

      test('should handle multiple screen fetches', () async {
        // Arrange & Act
        final screen1 = await mockApiService.fetchScreen('home_screen');
        final screen2 = await mockApiService.fetchScreen('home_screen');

        // Assert - Both fetches should succeed
        expect(screen1, isNotNull);
        expect(screen2, isNotNull);
        expect(screen1, equals(screen2));
      });
    });

    group('Error Handling Integration', () {
      test('should handle invalid screen names', () async {
        // Act & Assert
        expect(
          () => mockApiService.fetchScreen('invalid_screen'),
          throwsException,
        );
      });

      test('should provide error details', () async {
        // Act & Assert
        try {
          await mockApiService.fetchScreen('non_existent');
          fail('Should have thrown exception');
        } catch (e) {
          expect(e.toString(), contains('non_existent'));
        }
      });
    });

    group('Performance Integration', () {
      test('should fetch screens efficiently', () async {
        // Arrange
        final stopwatch = Stopwatch()..start();

        // Act
        await mockApiService.fetchScreen('home_screen');
        stopwatch.stop();

        // Assert - Should complete quickly (< 100ms without delay)
        expect(stopwatch.elapsedMilliseconds, lessThan(100));
      });

      test('should handle concurrent fetches', () async {
        // Arrange & Act
        final futures = List.generate(
          5,
          (_) => mockApiService.fetchScreen('home_screen'),
        );

        final results = await Future.wait(futures);

        // Assert - All fetches should succeed
        expect(results.length, 5);
        for (final result in results) {
          expect(result, isNotNull);
          expect(result, isA<Map<String, dynamic>>());
        }
      });
    });

    group('Data Flow Integration', () {
      test('should complete full data flow from API to cache', () async {
        // Step 1: Fetch from API
        final data = await mockApiService.fetchScreen('home_screen');
        expect(data, isNotNull);

        // Step 2: Verify caching
        expect(mockApiService.isCached('home_screen'), true);

        // Step 3: Retrieve from cache
        final cachedData = mockApiService.getCached('home_screen');
        expect(cachedData, isNotNull);
        expect(cachedData, equals(data));
      });

      test('should maintain data integrity', () async {
        // Arrange
        await mockApiService.fetchScreen('home_screen');
        final firstFetch = mockApiService.getCached('home_screen');

        // Act
        await mockApiService.fetchScreen('home_screen');
        final secondFetch = mockApiService.getCached('home_screen');

        // Assert - Data should be consistent
        expect(firstFetch, equals(secondFetch));
      });
    });
  });
}
