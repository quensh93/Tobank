import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobank_sdui/debug_panel/data/playground_templates.dart';
import 'package:tobank_sdui/debug_panel/screens/json_playground_screen.dart';

void main() {
  setUp(() async {
    // Initialize SharedPreferences with mock
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    // Clean up SharedPreferences after each test
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });

  group('JsonPlaygroundScreen Widget Tests', () {
    testWidgets('should display playground screen with app bar', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Check app bar
      expect(find.text('JSON Playground'), findsOneWidget);
      expect(find.byIcon(Icons.library_books), findsOneWidget);
      expect(find.byIcon(Icons.folder_open), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
    });

    testWidgets('should display empty editor and preview initially', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Empty state should be visible in preview
      expect(find.text('Enter JSON to see preview'), findsOneWidget);
    });

    testWidgets('should toggle device frame when button is pressed', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap device frame toggle
      final deviceFrameButton = find.byIcon(Icons.phone_android_outlined);
      expect(deviceFrameButton, findsOneWidget);
      await tester.tap(deviceFrameButton);
      await tester.pumpAndSettle();

      // Assert - Icon should change to filled version
      expect(find.byIcon(Icons.phone_android), findsOneWidget);
      expect(find.byIcon(Icons.phone_android_outlined), findsNothing);
    });

    testWidgets('should open template selector when templates button is pressed',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap templates button
      await tester.tap(find.byIcon(Icons.library_books));
      await tester.pumpAndSettle();

      // Assert - Template selector should be visible
      expect(find.text('Select Template'), findsOneWidget);
    });

    testWidgets('should load template when selected from template selector',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open template selector
      await tester.tap(find.byIcon(Icons.library_books));
      await tester.pumpAndSettle();

      // Find and tap a template
      final simpleTextTemplate = find.text('Simple Text');
      expect(simpleTextTemplate, findsOneWidget);
      await tester.tap(simpleTextTemplate);
      await tester.pumpAndSettle();

      // Assert - Template JSON should be loaded in editor
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('should display template categories in template selector',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open template selector
      await tester.tap(find.byIcon(Icons.library_books));
      await tester.pumpAndSettle();

      // Assert - Categories should be visible
      final categories = PlaygroundTemplates.categories;
      for (final category in categories) {
        expect(find.text(category), findsOneWidget);
      }
    });

    testWidgets('should open saved sessions drawer when button is pressed',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap saved sessions button
      await tester.tap(find.byIcon(Icons.folder_open));
      await tester.pumpAndSettle();

      // Assert - Sessions drawer should be visible
      expect(find.text('Saved Sessions'), findsOneWidget);
      expect(find.text('No saved sessions'), findsOneWidget);
    });

    testWidgets('should show save dialog when save button is pressed with valid JSON',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Load a template to have valid JSON
      await tester.tap(find.byIcon(Icons.library_books));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simple Text'));
      await tester.pumpAndSettle();

      // Act - Tap save button
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      // Assert - Save dialog should be visible
      expect(find.text('Save Session'), findsOneWidget);
      expect(find.text('Enter session name'), findsOneWidget);
    });

    testWidgets('should save session with provided name', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Load a template
      await tester.tap(find.byIcon(Icons.library_books));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simple Text'));
      await tester.pumpAndSettle();

      // Act - Save session
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      // Enter session name
      await tester.enterText(find.byType(TextField).last, 'Test Session');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Assert - Success message should be shown
      expect(find.text('Session saved: Test Session'), findsOneWidget);

      // Verify session is saved
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey('playground_session_Test Session'), isTrue);
    });

    testWidgets('should load saved session when selected', (tester) async {
      // Arrange - Save a session first
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'playground_session_My Session',
        '{"type": "text", "data": "Test"}',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open sessions drawer
      await tester.tap(find.byIcon(Icons.folder_open));
      await tester.pumpAndSettle();

      // Tap on saved session
      expect(find.text('My Session'), findsOneWidget);
      await tester.tap(find.text('My Session'));
      await tester.pumpAndSettle();

      // Assert - Session should be loaded (drawer closes)
      expect(find.text('Saved Sessions'), findsNothing);
    });

    testWidgets('should delete session when delete button is pressed', (tester) async {
      // Arrange - Save a session first
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'playground_session_Delete Me',
        '{"type": "text", "data": "Test"}',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open sessions drawer
      await tester.tap(find.byIcon(Icons.folder_open));
      await tester.pumpAndSettle();

      // Tap delete button
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      // Confirm deletion
      expect(find.text('Delete Session'), findsOneWidget);
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      // Assert - Session should be deleted
      expect(find.text('Session deleted: Delete Me'), findsOneWidget);
      expect(prefs.containsKey('playground_session_Delete Me'), isFalse);
    });

    testWidgets('should not delete session when cancel is pressed', (tester) async {
      // Arrange - Save a session first
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'playground_session_Keep Me',
        '{"type": "text", "data": "Test"}',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open sessions drawer
      await tester.tap(find.byIcon(Icons.folder_open));
      await tester.pumpAndSettle();

      // Tap delete button
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      // Cancel deletion
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Assert - Session should still exist
      expect(prefs.containsKey('playground_session_Keep Me'), isTrue);
    });

    testWidgets('should show more options menu', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap more options button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Assert - Menu items should be visible
      expect(find.text('Export to file'), findsOneWidget);
      expect(find.text('Import from file'), findsOneWidget);
      expect(find.text('Clear'), findsOneWidget);
    });

    testWidgets('should clear editor when clear option is selected', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Load a template first
      await tester.tap(find.byIcon(Icons.library_books));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simple Text'));
      await tester.pumpAndSettle();

      // Act - Clear editor
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Clear'));
      await tester.pumpAndSettle();

      // Assert - Editor should be empty
      expect(find.text('Enter JSON to see preview'), findsOneWidget);
    });

    testWidgets('should disable save button when JSON is invalid', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Save button should be disabled initially (no JSON)
      final saveButton = tester.widget<IconButton>(
        find.byIcon(Icons.save),
      );
      expect(saveButton.onPressed, isNull);
    });

    testWidgets('should display session count in sessions drawer', (tester) async {
      // Arrange - Save multiple sessions
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('playground_session_Session1', '{"type": "text"}');
      await prefs.setString('playground_session_Session2', '{"type": "text"}');

      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open sessions drawer
      await tester.tap(find.byIcon(Icons.folder_open));
      await tester.pumpAndSettle();

      // Assert - Both sessions should be visible
      expect(find.text('Session1'), findsOneWidget);
      expect(find.text('Session2'), findsOneWidget);
    });

    testWidgets('should show character count for saved sessions', (tester) async {
      // Arrange - Save a session
      final prefs = await SharedPreferences.getInstance();
      const testJson = '{"type": "text", "data": "Hello"}';
      await prefs.setString('playground_session_Test', testJson);

      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open sessions drawer
      await tester.tap(find.byIcon(Icons.folder_open));
      await tester.pumpAndSettle();

      // Assert - Character count should be displayed
      expect(find.text('${testJson.length} characters'), findsOneWidget);
    });

    testWidgets('should show template descriptions in template selector',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open template selector
      await tester.tap(find.byIcon(Icons.library_books));
      await tester.pumpAndSettle();

      // Assert - Template descriptions should be visible
      expect(find.text('A basic text widget'), findsOneWidget);
    });

    testWidgets('should close template selector after selecting template',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open template selector and select template
      await tester.tap(find.byIcon(Icons.library_books));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simple Text'));
      await tester.pumpAndSettle();

      // Assert - Template selector should be closed
      expect(find.text('Select Template'), findsNothing);
    });

    testWidgets('should close sessions drawer after loading session',
        (tester) async {
      // Arrange - Save a session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('playground_session_Test', '{"type": "text"}');

      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open sessions drawer and load session
      await tester.tap(find.byIcon(Icons.folder_open));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Test'));
      await tester.pumpAndSettle();

      // Assert - Sessions drawer should be closed
      expect(find.text('Saved Sessions'), findsNothing);
    });

    testWidgets('should cancel save when cancel button is pressed', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: JsonPlaygroundScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Load a template
      await tester.tap(find.byIcon(Icons.library_books));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simple Text'));
      await tester.pumpAndSettle();

      // Act - Open save dialog and cancel
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Assert - Dialog should be closed, no session saved
      expect(find.text('Save Session'), findsNothing);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getKeys().where((k) => k.startsWith('playground_session_')),
          isEmpty);
    });
  });
}
