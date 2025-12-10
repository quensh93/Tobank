import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/debug_panel/models/widget_node.dart';
import 'package:tobank_sdui/debug_panel/models/component_item.dart';
import 'package:tobank_sdui/debug_panel/widgets/editor_canvas.dart';

void main() {
  group('EditorCanvas Widget Tests', () {
    testWidgets('should display empty canvas when no root node', (tester) async {
      // Arrange
      WidgetNode? selectedNode;
      WidgetNode? updatedNode;
      WidgetNode? droppedParent;
      ComponentItem? droppedComponent;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: null,
              selectedNode: selectedNode,
              onNodeSelected: (node) {
                selectedNode = node;
              },
              onNodeUpdated: (node) {
                updatedNode = node;
              },
              onComponentDropped: (parent, component) {
                droppedParent = parent;
                droppedComponent = component;
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Empty state should be visible
      expect(find.text('Drag components here to start'), findsOneWidget);
      expect(find.byIcon(Icons.widgets_outlined), findsOneWidget);
    });

    testWidgets('should display root node when provided', (tester) async {
      // Arrange
      final rootNode = WidgetNode(
        id: 'root_1',
        type: 'container',
        properties: {'padding': 16.0},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: rootNode,
              selectedNode: null,
              onNodeSelected: (_) {},
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Root node should be visible
      expect(find.text('container'), findsOneWidget);
    });

    testWidgets('should highlight selected node', (tester) async {
      // Arrange
      final rootNode = WidgetNode(
        id: 'root_2',
        type: 'column',
        properties: {},
      );
      final childNode = WidgetNode(
        id: 'child_1',
        type: 'text',
        properties: {'data': 'Hello'},
      );
      rootNode.addChild(childNode);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: rootNode,
              selectedNode: childNode,
              onNodeSelected: (_) {},
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Both nodes should be visible
      expect(find.text('column'), findsOneWidget);
      expect(find.text('text'), findsOneWidget);
    });

    testWidgets('should call onNodeSelected when node is tapped', (tester) async {
      // Arrange
      final rootNode = WidgetNode(
        id: 'root_3',
        type: 'container',
        properties: {},
      );
      WidgetNode? selectedNode;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: rootNode,
              selectedNode: null,
              onNodeSelected: (node) {
                selectedNode = node;
              },
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap on the node
      await tester.tap(find.text('container'));
      await tester.pumpAndSettle();

      // Assert - Callback should be called
      expect(selectedNode, isNotNull);
      expect(selectedNode!.type, 'container');
    });

    testWidgets('should display node properties count', (tester) async {
      // Arrange
      final rootNode = WidgetNode(
        id: 'root_4',
        type: 'text',
        properties: {
          'data': 'Hello',
          'fontSize': 16.0,
          'color': '#000000',
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: rootNode,
              selectedNode: null,
              onNodeSelected: (_) {},
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Properties count should be visible
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('should display empty drop zone for container with no children',
        (tester) async {
      // Arrange
      final rootNode = WidgetNode(
        id: 'root_5',
        type: 'column',
        properties: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: rootNode,
              selectedNode: null,
              onNodeSelected: (_) {},
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Empty drop zone message should be visible
      expect(find.text('Empty - drag components here'), findsOneWidget);
    });

    testWidgets('should display child nodes', (tester) async {
      // Arrange
      final rootNode = WidgetNode(
        id: 'root_6',
        type: 'column',
        properties: {},
      );
      final child1 = WidgetNode(
        id: 'child_2',
        type: 'text',
        properties: {'data': 'First'},
      );
      final child2 = WidgetNode(
        id: 'child_3',
        type: 'text',
        properties: {'data': 'Second'},
      );
      rootNode.addChild(child1);
      rootNode.addChild(child2);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: rootNode,
              selectedNode: null,
              onNodeSelected: (_) {},
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - All nodes should be visible
      expect(find.text('column'), findsOneWidget);
      expect(find.text('text'), findsNWidgets(2));
    });

    testWidgets('should display nested nodes', (tester) async {
      // Arrange
      final rootNode = WidgetNode(
        id: 'root_7',
        type: 'column',
        properties: {},
      );
      final containerNode = WidgetNode(
        id: 'container_1',
        type: 'container',
        properties: {},
      );
      final textNode = WidgetNode(
        id: 'text_1',
        type: 'text',
        properties: {'data': 'Nested'},
      );
      containerNode.addChild(textNode);
      rootNode.addChild(containerNode);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: rootNode,
              selectedNode: null,
              onNodeSelected: (_) {},
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - All nested nodes should be visible
      expect(find.text('column'), findsOneWidget);
      expect(find.text('container'), findsOneWidget);
      expect(find.text('text'), findsOneWidget);
    });

    testWidgets('should display appropriate icons for widget types', (tester) async {
      // Arrange
      final rootNode = WidgetNode(
        id: 'root_8',
        type: 'column',
        properties: {},
      );
      final textNode = WidgetNode(
        id: 'text_2',
        type: 'text',
        properties: {},
      );
      final imageNode = WidgetNode(
        id: 'image_1',
        type: 'image',
        properties: {},
      );
      rootNode.addChild(textNode);
      rootNode.addChild(imageNode);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: rootNode,
              selectedNode: null,
              onNodeSelected: (_) {},
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Type-specific icons should be visible
      expect(find.byIcon(Icons.view_column), findsOneWidget);
      expect(find.byIcon(Icons.text_fields), findsOneWidget);
      expect(find.byIcon(Icons.image), findsOneWidget);
    });

    testWidgets('should use default icon for unknown widget types', (tester) async {
      // Arrange
      final rootNode = WidgetNode(
        id: 'root_9',
        type: 'unknownWidget',
        properties: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: rootNode,
              selectedNode: null,
              onNodeSelected: (_) {},
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Default widgets icon should be used
      expect(find.byIcon(Icons.widgets), findsOneWidget);
    });

    testWidgets('should handle empty properties', (tester) async {
      // Arrange
      final rootNode = WidgetNode(
        id: 'root_10',
        type: 'container',
        properties: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: rootNode,
              selectedNode: null,
              onNodeSelected: (_) {},
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Node should be visible without properties count
      expect(find.text('container'), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });

    testWidgets('should display drop target for empty canvas', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditorCanvas(
              rootNode: null,
              selectedNode: null,
              onNodeSelected: (_) {},
              onNodeUpdated: (_) {},
              onComponentDropped: (_, __) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Drop target should be visible
      expect(find.byType(DragTarget<ComponentItem>), findsOneWidget);
    });
  });
}
