import 'package:flutter/material.dart';
import '../models/widget_node.dart';
import '../models/component_item.dart';

/// Canvas widget for the visual editor with drag-and-drop support
class EditorCanvas extends StatefulWidget {
  final WidgetNode? rootNode;
  final WidgetNode? selectedNode;
  final Function(WidgetNode) onNodeSelected;
  final Function(WidgetNode) onNodeUpdated;
  final Function(WidgetNode, ComponentItem) onComponentDropped;

  const EditorCanvas({
    super.key,
    this.rootNode,
    this.selectedNode,
    required this.onNodeSelected,
    required this.onNodeUpdated,
    required this.onComponentDropped,
  });

  @override
  State<EditorCanvas> createState() => _EditorCanvasState();
}

class _EditorCanvasState extends State<EditorCanvas> {
  WidgetNode? _dragOverNode;
  int? _dragOverIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.rootNode == null) {
      return _buildEmptyCanvas();
    }

    return Container(
      color: Colors.grey[100],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _buildNodeWidget(widget.rootNode!),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCanvas() {
    return DragTarget<ComponentItem>(
      onAcceptWithDetails: (details) {
        final component = details.data;
        final newNode = WidgetNode(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: component.type,
          properties: Map<String, dynamic>.from(component.defaultProperties),
        );
        widget.onComponentDropped(newNode, component);
      },
      builder: (context, candidateData, rejectedData) {
        final isDraggingOver = candidateData.isNotEmpty;

        return Container(
          color: Colors.grey[100],
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(
                color: isDraggingOver
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDraggingOver
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300]!,
                  width: isDraggingOver ? 2 : 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isDraggingOver ? Icons.add_circle : Icons.widgets_outlined,
                    size: 64,
                    color: isDraggingOver
                        ? Theme.of(context).primaryColor
                        : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isDraggingOver
                        ? 'Drop component here'
                        : 'Drag components here to start',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDraggingOver
                          ? Theme.of(context).primaryColor
                          : Colors.grey[600],
                      fontWeight:
                          isDraggingOver ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNodeWidget(WidgetNode node) {
    final isSelected = widget.selectedNode?.id == node.id;
    final isDragOver = _dragOverNode?.id == node.id;

    return GestureDetector(
      onTap: () {
        widget.onNodeSelected(node);
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : isDragOver
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.5)
                    : Colors.transparent,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNodeHeader(node, isSelected),
            if (node.supportsChildren) _buildDropZone(node),
          ],
        ),
      ),
    );
  }

  Widget _buildNodeHeader(WidgetNode node, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
            : Colors.grey[50],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      ),
      child: Row(
        children: [
          Icon(
            _getIconForType(node.type),
            size: 16,
            color:
                isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              node.type,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[800],
              ),
            ),
          ),
          if (node.properties.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${node.properties.length}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropZone(WidgetNode parentNode) {
    return DragTarget<ComponentItem>(
      onWillAcceptWithDetails: (data) {
        setState(() {
          _dragOverNode = parentNode;
        });
        return true;
      },
      onLeave: (data) {
        setState(() {
          _dragOverNode = null;
          _dragOverIndex = null;
        });
      },
      onAcceptWithDetails: (details) {
        setState(() {
          _dragOverNode = null;
          _dragOverIndex = null;
        });
        widget.onComponentDropped(parentNode, details.data);
      },
      builder: (context, candidateData, rejectedData) {
        final isDraggingOver = candidateData.isNotEmpty;

        if (parentNode.children.isEmpty) {
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDraggingOver
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.05)
                  : Colors.transparent,
              border: Border.all(
                color: isDraggingOver
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300]!,
                width: 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                isDraggingOver ? 'Drop here' : 'Empty - drag components here',
                style: TextStyle(
                  fontSize: 12,
                  color: isDraggingOver
                      ? Theme.of(context).primaryColor
                      : Colors.grey[500],
                ),
              ),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDraggingOver
                ? Theme.of(context).primaryColor.withValues(alpha: 0.05)
                : Colors.transparent,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(4)),
          ),
          child: Column(
            children: [
              for (int i = 0; i < parentNode.children.length; i++) ...[
                _buildDropIndicator(parentNode, i, isDraggingOver),
                _buildNodeWidget(parentNode.children[i]),
              ],
              _buildDropIndicator(
                  parentNode, parentNode.children.length, isDraggingOver),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropIndicator(
      WidgetNode parentNode, int index, bool showAlways) {
    final isHovering =
        _dragOverNode?.id == parentNode.id && _dragOverIndex == index;

    return DragTarget<ComponentItem>(
      onWillAcceptWithDetails: (data) {
        setState(() {
          _dragOverNode = parentNode;
          _dragOverIndex = index;
        });
        return true;
      },
      onLeave: (data) {
        if (_dragOverIndex == index) {
          setState(() {
            _dragOverIndex = null;
          });
        }
      },
      onAcceptWithDetails: (details) {
        final component = details.data;
        final newNode = WidgetNode(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: component.type,
          properties: Map<String, dynamic>.from(component.defaultProperties),
        );
        final updatedParent = parentNode.addChild(newNode);
        widget.onNodeUpdated(updatedParent);
        setState(() {
          _dragOverNode = null;
          _dragOverIndex = null;
        });
      },
      builder: (context, candidateData, rejectedData) {
        if (!isHovering && !showAlways) {
          return const SizedBox(height: 4);
        }

        return Container(
          height: isHovering ? 32 : 4,
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: isHovering
                ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
            border: isHovering
                ? Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                    style: BorderStyle.solid,
                  )
                : null,
          ),
          child: isHovering
              ? Center(
                  child: Text(
                    'Drop here',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  IconData _getIconForType(String type) {
    const iconMap = {
      'column': Icons.view_column,
      'row': Icons.view_week,
      'stack': Icons.layers,
      'container': Icons.crop_square,
      'text': Icons.text_fields,
      'image': Icons.image,
      'icon': Icons.star,
      'elevatedButton': Icons.smart_button,
      'textButton': Icons.text_fields,
      'outlinedButton': Icons.border_style,
      'textField': Icons.input,
      'card': Icons.credit_card,
      'listView': Icons.view_list,
      'gridView': Icons.grid_view,
      'scaffold': Icons.web_asset,
      'appBar': Icons.web,
    };

    return iconMap[type] ?? Icons.widgets;
  }
}
