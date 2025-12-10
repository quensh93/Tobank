import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/core/logging/stac_logger.dart';
import 'package:tobank_sdui/core/logging/stac_log_models.dart';
import 'package:tobank_sdui/debug_panel_extensions/widgets/stac_logs_tab.dart';

void main() {
  setUp(() {
    // Clear logs before each test
    StacLogger.instance.clearLogs();
  });

  tearDown(() {
    // Clean up after each test
    StacLogger.instance.clearLogs();
  });

  group('StacLogsTab Widget Tests', () {
    testWidgets('should display empty state when no logs exist', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No STAC logs found'), findsOneWidget);
      expect(find.text('Try adjusting your filters or perform some STAC operations'), findsOneWidget);
      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    });

    testWidgets('should display statistics bar with correct counts', (tester) async {
      // Arrange - Add some test logs
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );
      StacLogger.logJsonParsing(
        screenName: 'home_screen',
        widgetTypes: ['text', 'button'],
        duration: const Duration(milliseconds: 30),
      );
      StacLogger.logError(
        operation: 'fetch',
        error: 'Test error',
        screenName: 'error_screen',
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Check statistics
      expect(find.text('Total: 3'), findsOneWidget);
      expect(find.text('Fetch: 1'), findsOneWidget);
      expect(find.text('Parse: 1'), findsOneWidget);
      expect(find.text('Errors: 1'), findsOneWidget);
    });

    testWidgets('should display log entries in list', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );
      StacLogger.logJsonParsing(
        screenName: 'profile_screen',
        widgetTypes: ['text', 'image'],
        duration: const Duration(milliseconds: 30),
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('home_screen'), findsOneWidget);
      expect(find.text('profile_screen'), findsOneWidget);
      expect(find.text('MOCK'), findsOneWidget);
    });

    testWidgets('should filter logs by operation type', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );
      StacLogger.logJsonParsing(
        screenName: 'profile_screen',
        widgetTypes: ['text'],
        duration: const Duration(milliseconds: 30),
      );
      StacLogger.logComponentRender(
        componentType: 'CustomCard',
        properties: {'title': 'Test'},
        duration: const Duration(milliseconds: 10),
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Deselect Parse filter
      final parseChip = find.widgetWithText(FilterChip, 'Parse');
      expect(parseChip, findsOneWidget);
      await tester.tap(parseChip);
      await tester.pumpAndSettle();

      // Assert - Parse log should be hidden
      expect(find.text('home_screen'), findsOneWidget);
      expect(find.text('profile_screen'), findsNothing);
    });

    testWidgets('should filter logs by API source', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'mock_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );
      StacLogger.logScreenFetch(
        screenName: 'supabase_screen',
        source: ApiSource.supabase,
        duration: const Duration(milliseconds: 100),
        jsonSize: 2048,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Deselect MOCK filter
      final mockChip = find.widgetWithText(FilterChip, 'MOCK');
      expect(mockChip, findsOneWidget);
      await tester.tap(mockChip);
      await tester.pumpAndSettle();

      // Assert - Mock log should be hidden
      expect(find.text('mock_screen'), findsNothing);
      expect(find.text('supabase_screen'), findsOneWidget);
    });

    testWidgets('should search logs by screen name', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );
      StacLogger.logScreenFetch(
        screenName: 'profile_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 60),
        jsonSize: 1024,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Search for "home"
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);
      await tester.enterText(searchField, 'home');
      await tester.pumpAndSettle();

      // Assert - Only home_screen should be visible
      expect(find.text('home_screen'), findsOneWidget);
      expect(find.text('profile_screen'), findsNothing);
    });

    testWidgets('should select log entry and show detail view', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap on log entry
      final logEntry = find.text('home_screen');
      await tester.tap(logEntry);
      await tester.pumpAndSettle();

      // Assert - Detail view should be visible
      expect(find.text('Screen Fetch'), findsOneWidget);
      expect(find.text('Details'), findsOneWidget);
      expect(find.text('Duration'), findsOneWidget);
      expect(find.text('50ms'), findsOneWidget);
    });

    testWidgets('should close detail view when tapping close button', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open detail view
      await tester.tap(find.text('home_screen'));
      await tester.pumpAndSettle();

      // Verify detail view is open
      expect(find.text('Details'), findsOneWidget);

      // Act - Close detail view
      final closeButton = find.byIcon(Icons.close);
      await tester.tap(closeButton);
      await tester.pumpAndSettle();

      // Assert - Detail view should be closed
      expect(find.text('Details'), findsNothing);
    });

    testWidgets('should display error information in detail view', (tester) async {
      // Arrange
      StacLogger.logError(
        operation: 'fetch',
        error: 'Network timeout',
        screenName: 'error_screen',
        suggestion: 'Check your internet connection',
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open detail view
      await tester.tap(find.text('error_screen'));
      await tester.pumpAndSettle();

      // Assert - Error details should be visible
      expect(find.text('Error Information'), findsOneWidget);
      expect(find.text('Network timeout'), findsOneWidget);
      expect(find.text('Check your internet connection'), findsOneWidget);
    });

    testWidgets('should display metadata in detail view', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
        additionalMetadata: {'custom_key': 'custom_value'},
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open detail view
      await tester.tap(find.text('home_screen'));
      await tester.pumpAndSettle();

      // Assert - Metadata should be visible
      expect(find.text('Metadata'), findsOneWidget);
      expect(find.text('custom_key'), findsOneWidget);
      expect(find.text('custom_value'), findsOneWidget);
    });

    testWidgets('should show clear logs confirmation dialog', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap clear logs button
      final clearButton = find.byIcon(Icons.delete_outline);
      await tester.tap(clearButton);
      await tester.pumpAndSettle();

      // Assert - Dialog should be visible
      expect(find.text('Clear All Logs'), findsOneWidget);
      expect(find.text('Are you sure you want to clear all STAC logs? This action cannot be undone.'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Clear'), findsOneWidget);
    });

    testWidgets('should clear logs when confirming in dialog', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify log exists
      expect(find.text('home_screen'), findsOneWidget);

      // Act - Open dialog and confirm
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Clear'));
      await tester.pumpAndSettle();

      // Assert - Logs should be cleared
      expect(find.text('No STAC logs found'), findsOneWidget);
      expect(find.text('home_screen'), findsNothing);
    });

    testWidgets('should not clear logs when canceling dialog', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open dialog and cancel
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Assert - Logs should still exist
      expect(find.text('home_screen'), findsOneWidget);
    });

    testWidgets('should display slow operation indicator', (tester) async {
      // Arrange - Create a slow operation (>100ms)
      StacLogger.logScreenFetch(
        screenName: 'slow_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 150),
        jsonSize: 1024,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Duration should be displayed with slow indicator styling
      expect(find.text('150ms'), findsOneWidget);
    });

    testWidgets('should display operation type icons correctly', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'fetch_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );
      StacLogger.logJsonParsing(
        screenName: 'parse_screen',
        widgetTypes: ['text'],
        duration: const Duration(milliseconds: 30),
      );
      StacLogger.logComponentRender(
        componentType: 'CustomCard',
        properties: {'title': 'Test'},
        duration: const Duration(milliseconds: 10),
      );
      StacLogger.logError(
        operation: 'test',
        error: 'Test error',
        screenName: 'error_screen',
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - All operation type icons should be present
      expect(find.byIcon(Icons.download), findsWidgets); // Fetch icon
      expect(find.byIcon(Icons.code), findsWidgets); // Parse icon
      expect(find.byIcon(Icons.brush), findsWidgets); // Render icon
      expect(find.byIcon(Icons.error), findsWidgets); // Error icon
    });

    testWidgets('should toggle log selection when tapping same entry twice', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'home_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap to select
      await tester.tap(find.text('home_screen'));
      await tester.pumpAndSettle();
      expect(find.text('Details'), findsOneWidget);

      // Act - Tap again to deselect
      await tester.tap(find.text('home_screen'));
      await tester.pumpAndSettle();

      // Assert - Detail view should be closed
      expect(find.text('Details'), findsNothing);
    });

    testWidgets('should display multiple filter chips', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - All filter chips should be present
      expect(find.widgetWithText(FilterChip, 'Fetch'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Parse'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Render'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Error'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'MOCK'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'supabase'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'CUSTOM'), findsOneWidget);
    });

    testWidgets('should combine multiple filters correctly', (tester) async {
      // Arrange
      StacLogger.logScreenFetch(
        screenName: 'mock_screen',
        source: ApiSource.mock,
        duration: const Duration(milliseconds: 50),
        jsonSize: 1024,
      );
      StacLogger.logScreenFetch(
        screenName: 'supabase_screen',
        source: ApiSource.supabase,
        duration: const Duration(milliseconds: 100),
        jsonSize: 2048,
      );
      StacLogger.logJsonParsing(
        screenName: 'parse_screen',
        widgetTypes: ['text'],
        duration: const Duration(milliseconds: 30),
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StacLogsTab(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Deselect Parse and supabase filters
      await tester.tap(find.widgetWithText(FilterChip, 'Parse'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilterChip, 'supabase'));
      await tester.pumpAndSettle();

      // Assert - Only mock_screen should be visible
      expect(find.text('mock_screen'), findsOneWidget);
      expect(find.text('supabase_screen'), findsNothing);
      expect(find.text('parse_screen'), findsNothing);
    });
  });
}
