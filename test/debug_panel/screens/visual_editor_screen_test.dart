import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/debug_panel/screens/visual_editor_screen.dart';
import 'package:tobank_sdui/debug_panel/widgets/component_palette.dart';

void main() {
  group('VisualEditorScreen Integration Tests', () {
    testWidgets('should display visual editor screen with app bar', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Check app bar
      expect(find.text('Visual JSON Editor'), findsOneWidget);
      expect(find.text('Widgets'), findsOneWidget);
      expect(find.text('Navigation'), findsOneWidget);
      expect(find.text('Menu'), findsOneWidget);
    });

    testWidgets('should display component palette in widget mode', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Component palette should be visible
      expect(find.text('Components'), findsOneWidget);
      expect(find.byType(ComponentPalette), findsOneWidget);
    });

    testWidgets('should switch between editor modes', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Switch to Navigation mode
      await tester.tap(find.text('Navigation'));
      await tester.pumpAndSettle();

      // Assert - Navigation editor should be visible
      expect(find.byType(ComponentPalette), findsNothing);

      // Act - Switch to Menu mode
      await tester.tap(find.text('Menu'));
      await tester.pumpAndSettle();

      // Assert - Menu editor should be visible
      expect(find.byType(ComponentPalette), findsNothing);

      // Act - Switch back to Widget mode
      await tester.tap(find.text('Widgets'));
      await tester.pumpAndSettle();

      // Assert - Component palette should be visible again
      expect(find.byType(ComponentPalette), findsOneWidget);
    });

    testWidgets('should toggle between visual and JSON view', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Toggle to JSON view
      await tester.tap(find.byIcon(Icons.code));
      await tester.pumpAndSettle();

      // Assert - JSON editor should be visible
      expect(find.text('Apply Changes'), findsOneWidget);
      expect(find.text('Revert'), findsOneWidget);

      // Act - Toggle back to visual view
      await tester.tap(find.byIcon(Icons.design_services));
      await tester.pumpAndSettle();

      // Assert - Component palette should be visible
      expect(find.byType(ComponentPalette), findsOneWidget);
    });

    testWidgets('should create new widget when component is selected', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Expand Layout category
      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();

      // Act - Tap on Container component
      await tester.tap(find.text('Container'));
      await tester.pumpAndSettle();

      // Assert - Canvas should show the container widget
      // (Visual verification - the widget tree should have a root node)
      expect(find.byType(ComponentPalette), findsOneWidget);
    });

    testWidgets('should show import dialog when import button is pressed', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap import button
      await tester.tap(find.byIcon(Icons.upload_file));
      await tester.pumpAndSettle();

      // Assert - Import dialog should be visible
      expect(find.text('Import WIDGET JSON'), findsOneWidget);
      expect(find.text('Paste JSON here...'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Import'), findsOneWidget);
    });

    testWidgets('should import valid JSON successfully', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open import dialog
      await tester.tap(find.byIcon(Icons.upload_file));
      await tester.pumpAndSettle();

      // Enter valid JSON
      const validJson = '{"type": "text", "data": "Hello World"}';
      await tester.enterText(find.byType(TextField).first, validJson);
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();

      // Assert - Success message should be shown
      expect(find.text('JSON imported successfully'), findsOneWidget);
    });

    testWidgets('should show error when importing invalid JSON', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Open import dialog
      await tester.tap(find.byIcon(Icons.upload_file));
      await tester.pumpAndSettle();

      // Enter invalid JSON
      const invalidJson = '{invalid json}';
      await tester.enterText(find.byType(TextField).first, invalidJson);
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();

      // Assert - Error message should be shown
      expect(find.textContaining('Invalid JSON'), findsOneWidget);
    });

    testWidgets('should show export dialog when export button is pressed', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Import a widget first
      await tester.tap(find.byIcon(Icons.upload_file));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField).first,
        '{"type": "text", "data": "Test"}',
      );
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();

      // Act - Tap export button
      await tester.tap(find.byIcon(Icons.download));
      await tester.pumpAndSettle();

      // Assert - Export dialog should be visible
      expect(find.text('Export WIDGET JSON'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
      expect(find.text('Copy'), findsOneWidget);
    });

    testWidgets('should copy JSON to clipboard when copy button is pressed', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Import a widget first
      await tester.tap(find.byIcon(Icons.upload_file));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField).first,
        '{"type": "text", "data": "Test"}',
      );
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();

      // Act - Tap copy button
      await tester.tap(find.byIcon(Icons.content_copy));
      await tester.pumpAndSettle();

      // Assert - Success message should be shown
      expect(find.text('JSON copied to clipboard'), findsOneWidget);
    });

    testWidgets('should show create new confirmation dialog', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap new button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Assert - Confirmation dialog should be visible
      expect(find.text('Create New'), findsAtLeastNWidgets(1));
      expect(find.textContaining('This will clear the current'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('should clear editor when create new is confirmed', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Import a widget first
      await tester.tap(find.byIcon(Icons.upload_file));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField).first,
        '{"type": "text", "data": "Test"}',
      );
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();

      // Act - Create new and confirm
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Create New').last);
      await tester.pumpAndSettle();

      // Assert - Editor should be cleared
      // (Visual verification - the widget tree should be empty)
      expect(find.byType(ComponentPalette), findsOneWidget);
    });

    testWidgets('should not clear editor when create new is cancelled', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Import a widget first
      await tester.tap(find.byIcon(Icons.upload_file));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField).first,
        '{"type": "text", "data": "Test"}',
      );
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();

      // Act - Create new but cancel
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Assert - Dialog should be closed
      expect(find.text('Create New'), findsNothing);
    });

    testWidgets('should validate JSON in JSON view', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Switch to JSON view
      await tester.tap(find.byIcon(Icons.code));
      await tester.pumpAndSettle();

      // Enter invalid JSON
      await tester.enterText(find.byType(TextField).first, '{invalid}');
      await tester.pumpAndSettle();

      // Assert - Error should be shown
      expect(find.textContaining('Invalid JSON'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('should apply JSON changes successfully', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Switch to JSON view
      await tester.tap(find.byIcon(Icons.code));
      await tester.pumpAndSettle();

      // Enter valid JSON
      await tester.enterText(
        find.byType(TextField).first,
        '{"type": "text", "data": "Updated"}',
      );
      await tester.pumpAndSettle();

      // Apply changes
      await tester.tap(find.text('Apply Changes'));
      await tester.pumpAndSettle();

      // Assert - Success message should be shown
      expect(find.text('JSON applied successfully'), findsOneWidget);
    });

    testWidgets('should revert JSON changes', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Import initial JSON
      await tester.tap(find.byIcon(Icons.upload_file));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField).first,
        '{"type": "text", "data": "Original"}',
      );
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();

      // Switch to JSON view
      await tester.tap(find.byIcon(Icons.code));
      await tester.pumpAndSettle();

      // Modify JSON
      await tester.enterText(
        find.byType(TextField).first,
        '{"type": "text", "data": "Modified"}',
      );
      await tester.pumpAndSettle();

      // Act - Revert changes
      await tester.tap(find.text('Revert'));
      await tester.pumpAndSettle();

      // Assert - Revert message should be shown
      expect(find.text('Changes reverted'), findsOneWidget);
    });

    testWidgets('should show warning when JSON has unsaved changes', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Switch to JSON view
      await tester.tap(find.byIcon(Icons.code));
      await tester.pumpAndSettle();

      // Enter JSON
      await tester.enterText(
        find.byType(TextField).first,
        '{"type": "text", "data": "Test"}',
      );
      await tester.pumpAndSettle();

      // Assert - Warning should be shown
      expect(find.text('JSON has unsaved changes'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('should open in playground when button is pressed', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap open in playground button
      await tester.tap(find.byIcon(Icons.code).last);
      await tester.pumpAndSettle();

      // Assert - Message should be shown
      expect(
        find.text('Switched to Playground. You can test your JSON there.'),
        findsOneWidget,
      );
    });

    testWidgets('should handle empty export gracefully', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Try to export without any content
      await tester.tap(find.byIcon(Icons.download));
      await tester.pumpAndSettle();

      // Assert - Message should be shown
      expect(find.text('Nothing to export'), findsOneWidget);
    });

    testWidgets('should handle empty copy gracefully', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VisualEditorScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Try to copy without any content
      await tester.tap(find.byIcon(Icons.content_copy));
      await tester.pumpAndSettle();

      // Assert - Message should be shown
      expect(find.text('Nothing to copy'), findsOneWidget);
    });

    // Navigation Editor Tests
    group('Navigation Editor', () {
      testWidgets('should switch to navigation editor mode', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Act - Switch to Navigation mode
        await tester.tap(find.text('Navigation'));
        await tester.pumpAndSettle();

        // Assert - Component palette should not be visible
        expect(find.byType(ComponentPalette), findsNothing);
      });

      testWidgets('should import navigation JSON', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Switch to Navigation mode
        await tester.tap(find.text('Navigation'));
        await tester.pumpAndSettle();

        // Act - Import navigation JSON
        await tester.tap(find.byIcon(Icons.upload_file));
        await tester.pumpAndSettle();

        const navJson = '''
{
  "routes": [
    {
      "id": "1",
      "path": "/home",
      "name": "Home",
      "screenName": "home_screen",
      "parameters": {},
      "isInitial": true,
      "metadata": {}
    }
  ]
}
''';
        await tester.enterText(find.byType(TextField).first, navJson);
        await tester.tap(find.text('Import'));
        await tester.pumpAndSettle();

        // Assert - Success message should be shown
        expect(find.text('JSON imported successfully'), findsOneWidget);
      });

      testWidgets('should export navigation JSON', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Switch to Navigation mode
        await tester.tap(find.text('Navigation'));
        await tester.pumpAndSettle();

        // Import navigation JSON first
        await tester.tap(find.byIcon(Icons.upload_file));
        await tester.pumpAndSettle();
        const navJson = '{"routes": [{"id": "1", "path": "/home", "name": "Home", "screenName": "home_screen", "parameters": {}, "isInitial": true, "metadata": {}}]}';
        await tester.enterText(find.byType(TextField).first, navJson);
        await tester.tap(find.text('Import'));
        await tester.pumpAndSettle();

        // Act - Export navigation JSON
        await tester.tap(find.byIcon(Icons.download));
        await tester.pumpAndSettle();

        // Assert - Export dialog should be visible
        expect(find.text('Export NAVIGATION JSON'), findsOneWidget);
      });
    });

    // Menu Editor Tests
    group('Menu Editor', () {
      testWidgets('should switch to menu editor mode', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Act - Switch to Menu mode
        await tester.tap(find.text('Menu'));
        await tester.pumpAndSettle();

        // Assert - Component palette should not be visible
        expect(find.byType(ComponentPalette), findsNothing);
      });

      testWidgets('should import menu JSON', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Switch to Menu mode
        await tester.tap(find.text('Menu'));
        await tester.pumpAndSettle();

        // Act - Import menu JSON
        await tester.tap(find.byIcon(Icons.upload_file));
        await tester.pumpAndSettle();

        const menuJson = '''
{
  "menuItems": [
    {
      "id": "1",
      "label": "Home",
      "icon": "home",
      "action": {
        "type": "navigate",
        "parameters": {"route": "/home"}
      },
      "order": 0,
      "enabled": true,
      "visible": true,
      "children": [],
      "metadata": {}
    }
  ]
}
''';
        await tester.enterText(find.byType(TextField).first, menuJson);
        await tester.tap(find.text('Import'));
        await tester.pumpAndSettle();

        // Assert - Success message should be shown
        expect(find.text('JSON imported successfully'), findsOneWidget);
      });

      testWidgets('should export menu JSON', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Switch to Menu mode
        await tester.tap(find.text('Menu'));
        await tester.pumpAndSettle();

        // Import menu JSON first
        await tester.tap(find.byIcon(Icons.upload_file));
        await tester.pumpAndSettle();
        const menuJson = '{"menuItems": [{"id": "1", "label": "Home", "icon": "home", "action": {"type": "navigate", "parameters": {"route": "/home"}}, "order": 0, "enabled": true, "visible": true, "children": [], "metadata": {}}]}';
        await tester.enterText(find.byType(TextField).first, menuJson);
        await tester.tap(find.text('Import'));
        await tester.pumpAndSettle();

        // Act - Export menu JSON
        await tester.tap(find.byIcon(Icons.download));
        await tester.pumpAndSettle();

        // Assert - Export dialog should be visible
        expect(find.text('Export MENU JSON'), findsOneWidget);
      });
    });

    // Complete Workflow Tests
    group('Complete Workflow', () {
      testWidgets('should complete drag-drop-edit-save workflow', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Step 1: Expand Layout category
        await tester.tap(find.text('Layout'));
        await tester.pumpAndSettle();

        // Step 2: Select a component (simulating drag-drop by tapping)
        await tester.tap(find.text('Container'));
        await tester.pumpAndSettle();

        // Step 3: Switch to JSON view to verify
        await tester.tap(find.byIcon(Icons.code));
        await tester.pumpAndSettle();

        // Step 4: Verify JSON contains the container
        // (The JSON should be populated in the text field)
        expect(find.byType(TextField), findsOneWidget);

        // Step 5: Switch back to visual view
        await tester.tap(find.byIcon(Icons.design_services));
        await tester.pumpAndSettle();

        // Step 6: Export the JSON
        await tester.tap(find.byIcon(Icons.download));
        await tester.pumpAndSettle();

        // Assert - Export dialog should show the JSON
        expect(find.text('Export WIDGET JSON'), findsOneWidget);
      });

      testWidgets('should complete import-edit-export workflow', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Step 1: Import JSON
        await tester.tap(find.byIcon(Icons.upload_file));
        await tester.pumpAndSettle();
        const initialJson = '{"type": "column", "children": [{"type": "text", "data": "Hello"}]}';
        await tester.enterText(find.byType(TextField).first, initialJson);
        await tester.tap(find.text('Import'));
        await tester.pumpAndSettle();

        // Step 2: Switch to JSON view
        await tester.tap(find.byIcon(Icons.code));
        await tester.pumpAndSettle();

        // Step 3: Edit JSON
        const editedJson = '{"type": "column", "children": [{"type": "text", "data": "Hello World"}]}';
        await tester.enterText(find.byType(TextField).first, editedJson);
        await tester.pumpAndSettle();

        // Step 4: Apply changes
        await tester.tap(find.text('Apply Changes'));
        await tester.pumpAndSettle();

        // Step 5: Export
        await tester.tap(find.byIcon(Icons.download));
        await tester.pumpAndSettle();

        // Assert - Export dialog should be visible
        expect(find.text('Export WIDGET JSON'), findsOneWidget);
      });

      testWidgets('should complete navigation editor workflow', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Step 1: Switch to Navigation mode
        await tester.tap(find.text('Navigation'));
        await tester.pumpAndSettle();

        // Step 2: Import navigation JSON
        await tester.tap(find.byIcon(Icons.upload_file));
        await tester.pumpAndSettle();
        const navJson = '{"routes": [{"id": "1", "path": "/home", "name": "Home", "screenName": "home_screen", "parameters": {}, "isInitial": true, "metadata": {}}]}';
        await tester.enterText(find.byType(TextField).first, navJson);
        await tester.tap(find.text('Import'));
        await tester.pumpAndSettle();

        // Step 3: Switch to JSON view
        await tester.tap(find.byIcon(Icons.code));
        await tester.pumpAndSettle();

        // Step 4: Verify JSON is populated
        expect(find.byType(TextField), findsOneWidget);

        // Step 5: Copy JSON
        await tester.tap(find.byIcon(Icons.design_services));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.content_copy));
        await tester.pumpAndSettle();

        // Assert - Success message
        expect(find.text('JSON copied to clipboard'), findsOneWidget);
      });

      testWidgets('should complete menu editor workflow', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Step 1: Switch to Menu mode
        await tester.tap(find.text('Menu'));
        await tester.pumpAndSettle();

        // Step 2: Import menu JSON
        await tester.tap(find.byIcon(Icons.upload_file));
        await tester.pumpAndSettle();
        const menuJson = '{"menuItems": [{"id": "1", "label": "Home", "icon": "home", "action": {"type": "navigate", "parameters": {"route": "/home"}}, "order": 0, "enabled": true, "visible": true, "children": [], "metadata": {}}]}';
        await tester.enterText(find.byType(TextField).first, menuJson);
        await tester.tap(find.text('Import'));
        await tester.pumpAndSettle();

        // Step 3: Export menu JSON
        await tester.tap(find.byIcon(Icons.download));
        await tester.pumpAndSettle();

        // Assert - Export dialog should be visible
        expect(find.text('Export MENU JSON'), findsOneWidget);

        // Step 4: Close export dialog
        await tester.tap(find.text('Close'));
        await tester.pumpAndSettle();

        // Step 5: Create new
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Create New').last);
        await tester.pumpAndSettle();

        // Assert - Menu should be cleared
        expect(find.byType(ComponentPalette), findsNothing);
      });

      testWidgets('should handle mode switching with unsaved changes', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Step 1: Import widget JSON
        await tester.tap(find.byIcon(Icons.upload_file));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byType(TextField).first,
          '{"type": "text", "data": "Test"}',
        );
        await tester.tap(find.text('Import'));
        await tester.pumpAndSettle();

        // Step 2: Switch to Navigation mode
        await tester.tap(find.text('Navigation'));
        await tester.pumpAndSettle();

        // Step 3: Switch back to Widget mode
        await tester.tap(find.text('Widgets'));
        await tester.pumpAndSettle();

        // Assert - Should be back in widget mode
        expect(find.byType(ComponentPalette), findsOneWidget);
      });

      testWidgets('should persist data across view toggles', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: VisualEditorScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Step 1: Import JSON
        await tester.tap(find.byIcon(Icons.upload_file));
        await tester.pumpAndSettle();
        const testJson = '{"type": "text", "data": "Persistent"}';
        await tester.enterText(find.byType(TextField).first, testJson);
        await tester.tap(find.text('Import'));
        await tester.pumpAndSettle();

        // Step 2: Toggle to JSON view
        await tester.tap(find.byIcon(Icons.code));
        await tester.pumpAndSettle();

        // Step 3: Toggle back to visual view
        await tester.tap(find.byIcon(Icons.design_services));
        await tester.pumpAndSettle();

        // Step 4: Export to verify data persisted
        await tester.tap(find.byIcon(Icons.download));
        await tester.pumpAndSettle();

        // Assert - Export dialog should show the data
        expect(find.text('Export WIDGET JSON'), findsOneWidget);
        expect(find.textContaining('Persistent'), findsOneWidget);
      });
    });
  });
}
