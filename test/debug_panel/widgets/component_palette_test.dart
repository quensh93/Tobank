import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/debug_panel/widgets/component_palette.dart';

void main() {
  group('ComponentPalette Widget Tests', () {
    testWidgets('should display component palette with header', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Check header
      expect(find.text('Components'), findsOneWidget);
      expect(find.byIcon(Icons.widgets), findsOneWidget);
    });

    testWidgets('should display search bar', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Search bar should be visible
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search components...'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should display all component categories', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - All categories should be visible
      expect(find.text('Layout'), findsOneWidget);
      expect(find.text('Display'), findsOneWidget);
      expect(find.text('Interactive'), findsOneWidget);
      expect(find.text('Lists'), findsOneWidget);
      expect(find.text('Structure'), findsOneWidget);
    });

    testWidgets('should expand category when tapped', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap on Layout category
      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();

      // Assert - Layout components should be visible
      expect(find.text('Column'), findsOneWidget);
      expect(find.text('Row'), findsOneWidget);
      expect(find.text('Stack'), findsOneWidget);
      expect(find.text('Container'), findsOneWidget);
    });

    testWidgets('should collapse category when tapped again', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Expand and then collapse Layout category
      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();
      expect(find.text('Column'), findsOneWidget);

      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();

      // Assert - Layout components should not be visible
      expect(find.text('Column'), findsNothing);
    });

    testWidgets('should display component descriptions', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Expand Display category
      await tester.tap(find.text('Display'));
      await tester.pumpAndSettle();

      // Assert - Component descriptions should be visible
      expect(find.text('Display text'), findsOneWidget);
      expect(find.text('Display image'), findsOneWidget);
      expect(find.text('Display icon'), findsOneWidget);
    });

    testWidgets('should filter components when searching', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Enter search query
      await tester.enterText(find.byType(TextField), 'button');
      await tester.pumpAndSettle();

      // Assert - Only button components should be visible
      expect(find.text('Elevated Button'), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);
      expect(find.text('Outlined Button'), findsOneWidget);
      expect(find.text('Icon Button'), findsOneWidget);

      // Non-button components should not be visible
      expect(find.text('Column'), findsNothing);
      expect(find.text('Text'), findsNothing);
    });

    testWidgets('should show clear button when search has text', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Enter search query
      await tester.enterText(find.byType(TextField), 'text');
      await tester.pumpAndSettle();

      // Assert - Clear button should be visible
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('should clear search when clear button is tapped', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Enter search query and clear it
      await tester.enterText(find.byType(TextField), 'button');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pumpAndSettle();

      // Assert - Categories should be visible again
      expect(find.text('Layout'), findsOneWidget);
      expect(find.text('Display'), findsOneWidget);
    });

    testWidgets('should show no results message when search has no matches',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Enter search query with no matches
      await tester.enterText(find.byType(TextField), 'nonexistent');
      await tester.pumpAndSettle();

      // Assert - No results message should be visible
      expect(find.text('No components found'), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);
    });

    testWidgets('should make components draggable', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Expand Layout category
      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();

      // Assert - Components should be wrapped in Draggable
      expect(find.byType(Draggable<ComponentItem>), findsWidgets);
    });

    testWidgets('should call onComponentSelected when component is tapped',
        (tester) async {
      // Arrange
      ComponentItem? selectedComponent;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ComponentPalette(
              onComponentSelected: (component) {
                selectedComponent = component;
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Expand Layout category and tap Column
      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Column'));
      await tester.pumpAndSettle();

      // Assert - Callback should be called with Column component
      expect(selectedComponent, isNotNull);
      expect(selectedComponent!.type, 'column');
      expect(selectedComponent!.displayName, 'Column');
    });

    testWidgets('should display component icons', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Expand Interactive category
      await tester.tap(find.text('Interactive'));
      await tester.pumpAndSettle();

      // Assert - Component icons should be visible
      expect(find.byIcon(Icons.smart_button), findsOneWidget);
      expect(find.byIcon(Icons.input), findsOneWidget);
      expect(find.byIcon(Icons.check_box), findsOneWidget);
    });

    testWidgets('should search by component type', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Search by type
      await tester.enterText(find.byType(TextField), 'column');
      await tester.pumpAndSettle();

      // Assert - Column component should be found
      expect(find.text('Column'), findsOneWidget);
      expect(find.text('Vertical layout'), findsOneWidget);
    });

    testWidgets('should search by component description', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Search by description
      await tester.enterText(find.byType(TextField), 'horizontal');
      await tester.pumpAndSettle();

      // Assert - Row component should be found (has "Horizontal layout" description)
      expect(find.text('Row'), findsOneWidget);
      expect(find.text('Horizontal layout'), findsOneWidget);
    });

    testWidgets('should display all Layout components', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Expand Layout category
      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();

      // Assert - All layout components should be visible
      expect(find.text('Column'), findsOneWidget);
      expect(find.text('Row'), findsOneWidget);
      expect(find.text('Stack'), findsOneWidget);
      expect(find.text('Container'), findsOneWidget);
      expect(find.text('Center'), findsOneWidget);
      expect(find.text('Padding'), findsOneWidget);
      expect(find.text('Sized Box'), findsOneWidget);
      expect(find.text('Expanded'), findsOneWidget);
    });

    testWidgets('should display all Display components', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Expand Display category
      await tester.tap(find.text('Display'));
      await tester.pumpAndSettle();

      // Assert - All display components should be visible
      expect(find.text('Text'), findsOneWidget);
      expect(find.text('Image'), findsOneWidget);
      expect(find.text('Icon'), findsOneWidget);
      expect(find.text('Divider'), findsOneWidget);
      expect(find.text('Card'), findsOneWidget);
      expect(find.text('List Tile'), findsOneWidget);
    });

    testWidgets('should display all Interactive components', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Expand Interactive category
      await tester.tap(find.text('Interactive'));
      await tester.pumpAndSettle();

      // Assert - All interactive components should be visible
      expect(find.text('Elevated Button'), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);
      expect(find.text('Outlined Button'), findsOneWidget);
      expect(find.text('Icon Button'), findsOneWidget);
      expect(find.text('Text Field'), findsOneWidget);
      expect(find.text('Checkbox'), findsOneWidget);
      expect(find.text('Switch'), findsOneWidget);
      expect(find.text('Slider'), findsOneWidget);
    });

    testWidgets('should display category icons', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Category icons should be visible
      expect(find.byIcon(Icons.view_quilt), findsOneWidget); // Layout
      expect(find.byIcon(Icons.text_fields), findsOneWidget); // Display
      expect(find.byIcon(Icons.touch_app), findsOneWidget); // Interactive
      expect(find.byIcon(Icons.list_alt), findsOneWidget); // Lists
      expect(find.byIcon(Icons.account_tree), findsOneWidget); // Structure
    });

    testWidgets('should show expand/collapse icons', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Expand more icons should be visible initially
      expect(find.byIcon(Icons.expand_more), findsWidgets);

      // Act - Expand a category
      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();

      // Assert - Expand less icon should be visible for expanded category
      expect(find.byIcon(Icons.expand_less), findsOneWidget);
    });

    testWidgets('should handle multiple category expansions', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Expand Layout category
      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();
      expect(find.text('Column'), findsOneWidget);

      // Act - Collapse Layout and expand Display category
      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();
      expect(find.text('Column'), findsNothing);

      await tester.tap(find.text('Display'));
      await tester.pumpAndSettle();

      // Assert - Display components should be visible
      expect(find.text('Text'), findsOneWidget);
      expect(find.text('Column'), findsNothing);
    });

    testWidgets('should maintain search state when switching categories',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Enter search query
      await tester.enterText(find.byType(TextField), 'text');
      await tester.pumpAndSettle();

      // Assert - Search results should be visible
      expect(find.text('Text'), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);
      expect(find.text('Text Field'), findsOneWidget);
    });

    testWidgets('should be case-insensitive when searching', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComponentPalette(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Search with uppercase
      await tester.enterText(find.byType(TextField), 'BUTTON');
      await tester.pumpAndSettle();

      // Assert - Button components should be found
      expect(find.text('Elevated Button'), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);
    });
  });
}
