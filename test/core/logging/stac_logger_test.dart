import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/logging/stac_log_models.dart';
import 'package:tobank_sdui/core/logging/stac_logger.dart';

void main() {
  group('StacLogger', () {
    setUp(() {
      // Clear logs before each test
      StacLogger.instance.clearLogs();
    });

    tearDown(() {
      // Clean up after each test
      StacLogger.instance.clearLogs();
    });

    group('Singleton Instance', () {
      test('should return the same instance', () {
        // Act
        final instance1 = StacLogger.instance;
        final instance2 = StacLogger.instance;

        // Assert
        expect(instance1, same(instance2));
      });
    });

    group('logScreenFetch', () {
      test('should create log entry with correct metadata', () {
        // Arrange
        const screenName = 'home_screen';
        const source = ApiSource.mock;
        const duration = Duration(milliseconds: 150);
        const jsonSize = 2048;

        // Act
        StacLogger.logScreenFetch(
          screenName: screenName,
          source: source,
          duration: duration,
          jsonSize: jsonSize,
        );

        // Assert
        final logs = StacLogger.instance.logEntries;
        expect(logs.length, equals(1));

        final entry = logs.first;
        expect(entry.operationType, equals(StacOperationType.fetch));
        expect(entry.screenName, equals(screenName));
        expect(entry.source, equals(source));
        expect(entry.duration, equals(duration));
        expect(entry.metadata['source'], equals('mock'));
        expect(entry.metadata['duration_ms'], equals(150));
        expect(entry.metadata['size_kb'], equals('2.00'));
      });

      test('should include additional metadata when provided', () {
        // Arrange
        const screenName = 'profile_screen';
        const additionalMetadata = {
          'cache_hit': true,
          'retry_count': 0,
        };

        // Act
        StacLogger.logScreenFetch(
          screenName: screenName,
          source: ApiSource.supabase,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1024,
          additionalMetadata: additionalMetadata,
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.metadata['cache_hit'], isTrue);
        expect(entry.metadata['retry_count'], equals(0));
      });

      test('should generate unique IDs for each log entry', () {
        // Act
        StacLogger.logScreenFetch(
          screenName: 'screen1',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1024,
        );
        StacLogger.logScreenFetch(
          screenName: 'screen2',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1024,
        );

        // Assert
        final logs = StacLogger.instance.logEntries;
        expect(logs.length, equals(2));
        expect(logs[0].id, isNot(equals(logs[1].id)));
      });
    });

    group('logJsonParsing', () {
      test('should create log entry with widget types', () {
        // Arrange
        const screenName = 'home_screen';
        const widgetTypes = ['scaffold', 'appBar', 'column', 'text'];
        const duration = Duration(milliseconds: 50);

        // Act
        StacLogger.logJsonParsing(
          screenName: screenName,
          widgetTypes: widgetTypes,
          duration: duration,
        );

        // Assert
        final logs = StacLogger.instance.logEntries;
        expect(logs.length, equals(1));

        final entry = logs.first;
        expect(entry.operationType, equals(StacOperationType.parse));
        expect(entry.screenName, equals(screenName));
        expect(entry.duration, equals(duration));
        expect(entry.metadata['widgets'], equals('scaffold, appBar, column, text'));
        expect(entry.metadata['widget_count'], equals(4));
        expect(entry.metadata['duration_ms'], equals(50));
        expect(entry.metadata['warnings'], equals('none'));
      });

      test('should include warnings when provided', () {
        // Arrange
        const warnings = [
          'Unknown widget type: customWidget',
          'Missing required property: text',
        ];

        // Act
        StacLogger.logJsonParsing(
          screenName: 'test_screen',
          widgetTypes: ['text'],
          duration: const Duration(milliseconds: 30),
          warnings: warnings,
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(
          entry.metadata['warnings'],
          equals('Unknown widget type: customWidget; Missing required property: text'),
        );
      });

      test('should include additional metadata when provided', () {
        // Arrange
        const additionalMetadata = {
          'json_depth': 5,
          'total_nodes': 42,
        };

        // Act
        StacLogger.logJsonParsing(
          screenName: 'complex_screen',
          widgetTypes: ['scaffold', 'column'],
          duration: const Duration(milliseconds: 75),
          additionalMetadata: additionalMetadata,
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.metadata['json_depth'], equals(5));
        expect(entry.metadata['total_nodes'], equals(42));
      });
    });

    group('logComponentRender', () {
      test('should create log entry with component details', () {
        // Arrange
        const componentType = 'customCard';
        const properties = {
          'title': 'Test Card',
          'subtitle': 'Test Subtitle',
          'color': '#FF0000',
        };
        const duration = Duration(milliseconds: 12);
        const screenName = 'home_screen';

        // Act
        StacLogger.logComponentRender(
          componentType: componentType,
          properties: properties,
          duration: duration,
          screenName: screenName,
        );

        // Assert
        final logs = StacLogger.instance.logEntries;
        expect(logs.length, equals(1));

        final entry = logs.first;
        expect(entry.operationType, equals(StacOperationType.render));
        expect(entry.screenName, equals(screenName));
        expect(entry.duration, equals(duration));
        expect(entry.metadata['type'], equals(componentType));
        expect(entry.metadata['properties'], equals('title, subtitle, color'));
        expect(entry.metadata['property_count'], equals(3));
        expect(entry.metadata['duration_ms'], equals(12));
      });

      test('should use "unknown" as default screen name', () {
        // Act
        StacLogger.logComponentRender(
          componentType: 'button',
          properties: {'label': 'Click me'},
          duration: const Duration(milliseconds: 5),
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.screenName, equals('unknown'));
      });

      test('should include additional metadata when provided', () {
        // Arrange
        const additionalMetadata = {
          'parent_widget': 'column',
          'index': 2,
        };

        // Act
        StacLogger.logComponentRender(
          componentType: 'text',
          properties: {'data': 'Hello'},
          duration: const Duration(milliseconds: 8),
          additionalMetadata: additionalMetadata,
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.metadata['parent_widget'], equals('column'));
        expect(entry.metadata['index'], equals(2));
      });
    });

    group('logError', () {
      test('should create error log entry with details', () {
        // Arrange
        const operation = 'fetchScreen';
        const error = 'Network connection failed';
        const screenName = 'profile_screen';
        const jsonPath = 'body.children[0]';
        const suggestion = 'Check network connectivity';

        // Act
        StacLogger.logError(
          operation: operation,
          error: error,
          screenName: screenName,
          jsonPath: jsonPath,
          suggestion: suggestion,
        );

        // Assert
        final logs = StacLogger.instance.logEntries;
        expect(logs.length, equals(1));

        final entry = logs.first;
        expect(entry.operationType, equals(StacOperationType.error));
        expect(entry.screenName, equals(screenName));
        expect(entry.error, equals(error));
        expect(entry.suggestion, equals(suggestion));
        expect(entry.metadata['operation'], equals(operation));
        expect(entry.metadata['error'], equals(error));
        expect(entry.metadata['json_path'], equals(jsonPath));
        expect(entry.metadata['suggestion'], equals(suggestion));
      });

      test('should use default values for optional parameters', () {
        // Act
        StacLogger.logError(
          operation: 'parseJson',
          error: 'Invalid JSON structure',
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.screenName, equals('unknown'));
        expect(entry.metadata['json_path'], equals('unknown'));
        expect(
          entry.metadata['suggestion'],
          equals('Check JSON structure and STAC documentation'),
        );
      });

      test('should handle Exception objects', () {
        // Arrange
        final exception = Exception('Test exception');

        // Act
        StacLogger.logError(
          operation: 'testOperation',
          error: exception,
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.error, contains('Exception: Test exception'));
      });

      test('should include additional metadata when provided', () {
        // Arrange
        const additionalMetadata = {
          'error_code': 'STAC_001',
          'severity': 'high',
        };

        // Act
        StacLogger.logError(
          operation: 'renderComponent',
          error: 'Component not found',
          additionalMetadata: additionalMetadata,
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.metadata['error_code'], equals('STAC_001'));
        expect(entry.metadata['severity'], equals('high'));
      });
    });

    group('logCustomOperation', () {
      test('should create custom log entry', () {
        // Arrange
        const screenName = 'custom_screen';
        const operationType = StacOperationType.fetch;
        const duration = Duration(milliseconds: 200);
        const source = ApiSource.custom;
        const metadata = {
          'custom_field': 'custom_value',
        };

        // Act
        StacLogger.logCustomOperation(
          screenName: screenName,
          operationType: operationType,
          duration: duration,
          source: source,
          metadata: metadata,
        );

        // Assert
        final logs = StacLogger.instance.logEntries;
        expect(logs.length, equals(1));

        final entry = logs.first;
        expect(entry.screenName, equals(screenName));
        expect(entry.operationType, equals(operationType));
        expect(entry.duration, equals(duration));
        expect(entry.source, equals(source));
        expect(entry.metadata['custom_field'], equals('custom_value'));
      });

      test('should handle error operations', () {
        // Act
        StacLogger.logCustomOperation(
          screenName: 'error_screen',
          operationType: StacOperationType.error,
          duration: Duration.zero,
          error: 'Custom error',
          suggestion: 'Custom suggestion',
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.operationType, equals(StacOperationType.error));
        expect(entry.error, equals('Custom error'));
        expect(entry.suggestion, equals('Custom suggestion'));
      });
    });

    group('Log Filtering', () {
      setUp(() {
        // Create a variety of log entries
        StacLogger.logScreenFetch(
          screenName: 'screen1',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1024,
        );
        StacLogger.logScreenFetch(
          screenName: 'screen2',
          source: ApiSource.supabase,
          duration: const Duration(milliseconds: 200),
          jsonSize: 2048,
        );
        StacLogger.logJsonParsing(
          screenName: 'screen1',
          widgetTypes: ['text'],
          duration: const Duration(milliseconds: 50),
        );
        StacLogger.logComponentRender(
          componentType: 'button',
          properties: {'label': 'Click'},
          duration: const Duration(milliseconds: 15),
          screenName: 'screen1',
        );
        StacLogger.logError(
          operation: 'fetchScreen',
          error: 'Network error',
          screenName: 'screen2',
        );
      });

      test('getLogsByType should filter by operation type', () {
        // Act
        final fetchLogs = StacLogger.instance.getLogsByType(StacOperationType.fetch);
        final parseLogs = StacLogger.instance.getLogsByType(StacOperationType.parse);
        final renderLogs = StacLogger.instance.getLogsByType(StacOperationType.render);
        final errorLogs = StacLogger.instance.getLogsByType(StacOperationType.error);

        // Assert
        expect(fetchLogs.length, equals(2));
        expect(parseLogs.length, equals(1));
        expect(renderLogs.length, equals(1));
        expect(errorLogs.length, equals(1));
      });

      test('getLogsBySource should filter by API source', () {
        // Act
        final mockLogs = StacLogger.instance.getLogsBySource(ApiSource.mock);
        final supabaseLogs = StacLogger.instance.getLogsBySource(ApiSource.supabase);
        final customLogs = StacLogger.instance.getLogsBySource(ApiSource.custom);

        // Assert
        expect(mockLogs.length, equals(1));
        expect(supabaseLogs.length, equals(1));
        expect(customLogs.length, equals(0));
      });

      test('getLogsByScreen should filter by screen name', () {
        // Act
        final screen1Logs = StacLogger.instance.getLogsByScreen('screen1');
        final screen2Logs = StacLogger.instance.getLogsByScreen('screen2');

        // Assert
        expect(screen1Logs.length, equals(3));
        expect(screen2Logs.length, equals(2));
      });

      test('getErrors should return only error logs', () {
        // Act
        final errors = StacLogger.instance.getErrors();

        // Assert
        expect(errors.length, equals(1));
        expect(errors.first.operationType, equals(StacOperationType.error));
      });

      test('getSlowOperations should return operations over 100ms', () {
        // Act
        final slowOps = StacLogger.instance.getSlowOperations();

        // Assert
        expect(slowOps.length, equals(2)); // Two fetch operations at 100ms and 200ms
        expect(slowOps.every((log) => log.duration.inMilliseconds > 100), isTrue);
      });
    });

    group('Log Management', () {
      test('clearLogs should remove all log entries', () {
        // Arrange
        StacLogger.logScreenFetch(
          screenName: 'test',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1024,
        );
        expect(StacLogger.instance.logEntries.length, equals(1));

        // Act
        StacLogger.instance.clearLogs();

        // Assert
        expect(StacLogger.instance.logEntries.length, equals(0));
      });

      test('should limit log entries to maximum count', () {
        // Arrange - Create more than max entries (1000)
        for (int i = 0; i < 1100; i++) {
          StacLogger.logScreenFetch(
            screenName: 'screen_$i',
            source: ApiSource.mock,
            duration: const Duration(milliseconds: 100),
            jsonSize: 1024,
          );
        }

        // Assert
        expect(StacLogger.instance.logEntries.length, equals(1000));
        // First entry should be removed, so first entry should be screen_100
        expect(StacLogger.instance.logEntries.first.screenName, equals('screen_100'));
      });

      test('logEntries should return unmodifiable list', () {
        // Arrange
        StacLogger.logScreenFetch(
          screenName: 'test',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1024,
        );

        // Act
        final logs = StacLogger.instance.logEntries;

        // Assert - Attempting to modify should throw
        expect(() => logs.add(logs.first), throwsUnsupportedError);
      });
    });

    group('Statistics', () {
      setUp(() {
        // Create a variety of log entries with different durations
        StacLogger.logScreenFetch(
          screenName: 'screen1',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1024,
        );
        StacLogger.logScreenFetch(
          screenName: 'screen2',
          source: ApiSource.supabase,
          duration: const Duration(milliseconds: 200),
          jsonSize: 2048,
        );
        StacLogger.logJsonParsing(
          screenName: 'screen1',
          widgetTypes: ['text'],
          duration: const Duration(milliseconds: 50),
        );
        StacLogger.logJsonParsing(
          screenName: 'screen2',
          widgetTypes: ['button'],
          duration: const Duration(milliseconds: 150),
        );
        StacLogger.logComponentRender(
          componentType: 'button',
          properties: {'label': 'Click'},
          duration: const Duration(milliseconds: 10),
        );
        StacLogger.logError(
          operation: 'fetchScreen',
          error: 'Network error',
        );
      });

      test('getStatistics should return correct counts', () {
        // Act
        final stats = StacLogger.instance.getStatistics();

        // Assert
        expect(stats['total_logs'], equals(6));
        expect(stats['fetch_count'], equals(2));
        expect(stats['parse_count'], equals(2));
        expect(stats['render_count'], equals(1));
        expect(stats['error_count'], equals(1));
      });

      test('getStatistics should calculate average durations', () {
        // Act
        final stats = StacLogger.instance.getStatistics();

        // Assert
        expect(stats['avg_fetch_duration_ms'], equals(150.0)); // (100 + 200) / 2
        expect(stats['avg_parse_duration_ms'], equals(100.0)); // (50 + 150) / 2
        expect(stats['avg_render_duration_ms'], equals(10.0)); // 10 / 1
      });

      test('getStatistics should count slow operations', () {
        // Act
        final stats = StacLogger.instance.getStatistics();

        // Assert
        // Slow operations are those > 100ms, so 200ms fetch and 150ms parse = 2
        expect(stats['slow_operations'], equals(2));
      });

      test('getStatistics should handle empty logs', () {
        // Arrange
        StacLogger.instance.clearLogs();

        // Act
        final stats = StacLogger.instance.getStatistics();

        // Assert
        expect(stats['total_logs'], equals(0));
        expect(stats['fetch_count'], equals(0));
        expect(stats['avg_fetch_duration_ms'], equals(0.0));
      });
    });

    group('Metadata Formatting', () {
      test('should format JSON size in KB with 2 decimal places', () {
        // Act
        StacLogger.logScreenFetch(
          screenName: 'test',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1536, // 1.5 KB
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.metadata['size_kb'], equals('1.50'));
      });

      test('should format duration in milliseconds', () {
        // Act
        StacLogger.logScreenFetch(
          screenName: 'test',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 123),
          jsonSize: 1024,
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.metadata['duration_ms'], equals(123));
      });

      test('should join widget types with comma separator', () {
        // Act
        StacLogger.logJsonParsing(
          screenName: 'test',
          widgetTypes: ['scaffold', 'appBar', 'column', 'text', 'button'],
          duration: const Duration(milliseconds: 50),
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.metadata['widgets'], equals('scaffold, appBar, column, text, button'));
      });

      test('should join warnings with semicolon separator', () {
        // Act
        StacLogger.logJsonParsing(
          screenName: 'test',
          widgetTypes: ['text'],
          duration: const Duration(milliseconds: 50),
          warnings: ['Warning 1', 'Warning 2', 'Warning 3'],
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.metadata['warnings'], equals('Warning 1; Warning 2; Warning 3'));
      });

      test('should join property keys with comma separator', () {
        // Act
        StacLogger.logComponentRender(
          componentType: 'card',
          properties: {
            'title': 'Test',
            'subtitle': 'Subtitle',
            'color': '#FF0000',
            'elevation': 4,
          },
          duration: const Duration(milliseconds: 10),
        );

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.metadata['properties'], equals('title, subtitle, color, elevation'));
      });
    });

    group('Timestamp', () {
      test('should record timestamp for each log entry', () {
        // Arrange
        final beforeTime = DateTime.now();

        // Act
        StacLogger.logScreenFetch(
          screenName: 'test',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1024,
        );

        final afterTime = DateTime.now();

        // Assert
        final entry = StacLogger.instance.logEntries.first;
        expect(entry.timestamp.isAfter(beforeTime) || entry.timestamp.isAtSameMomentAs(beforeTime), isTrue);
        expect(entry.timestamp.isBefore(afterTime) || entry.timestamp.isAtSameMomentAs(afterTime), isTrue);
      });

      test('should maintain chronological order of log entries', () {
        // Act
        StacLogger.logScreenFetch(
          screenName: 'screen1',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1024,
        );

        // Small delay to ensure different timestamps
        Future.delayed(const Duration(milliseconds: 10));

        StacLogger.logScreenFetch(
          screenName: 'screen2',
          source: ApiSource.mock,
          duration: const Duration(milliseconds: 100),
          jsonSize: 1024,
        );

        // Assert
        final logs = StacLogger.instance.logEntries;
        expect(logs.length, equals(2));
        expect(
          logs[0].timestamp.isBefore(logs[1].timestamp) ||
              logs[0].timestamp.isAtSameMomentAs(logs[1].timestamp),
          isTrue,
        );
      });
    });
  });
}
