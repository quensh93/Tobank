import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/widget_node.dart';

/// Property editor panel for editing widget properties
class PropertyEditor extends StatefulWidget {
  final WidgetNode? selectedNode;
  final Function(WidgetNode) onPropertyChanged;

  const PropertyEditor({
    super.key,
    this.selectedNode,
    required this.onPropertyChanged,
  });

  @override
  State<PropertyEditor> createState() => _PropertyEditorState();
}

class _PropertyEditorState extends State<PropertyEditor> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void didUpdateWidget(PropertyEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedNode?.id != widget.selectedNode?.id) {
      _disposeControllers();
      _initializeControllers();
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
  }

  void _initializeControllers() {
    if (widget.selectedNode != null) {
      for (final entry in widget.selectedNode!.properties.entries) {
        _controllers[entry.key] = TextEditingController(
          text: entry.value.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          left: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: widget.selectedNode == null
                ? _buildEmptyState()
                : _buildPropertiesEditor(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.tune, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Text(
            'Properties',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.tune_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No widget selected',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Select a widget to edit properties',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesEditor() {
    final node = widget.selectedNode!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Widget type (read-only)
        _buildSection(
          'Widget Type',
          [
            _buildReadOnlyField('Type', node.type),
            _buildReadOnlyField('ID', node.id),
          ],
        ),
        const SizedBox(height: 16),

        // Properties
        _buildSection(
          'Properties',
          [
            ...node.properties.entries.map((entry) {
              return _buildPropertyField(entry.key, entry.value);
            }),
            const SizedBox(height: 8),
            _buildAddPropertyButton(),
          ],
        ),

        const SizedBox(height: 16),

        // Common properties based on widget type
        _buildCommonProperties(node),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyField(String key, dynamic value) {
    // Determine property type
    if (value is bool) {
      return _buildBooleanField(key, value);
    } else if (value is num) {
      return _buildNumberField(key, value);
    } else if (key.toLowerCase().contains('color')) {
      return _buildColorField(key, value.toString());
    } else {
      return _buildTextField(key, value.toString());
    }
  }

  Widget _buildTextField(String key, String value) {
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController(text: value);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  key,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _removeProperty(key),
              ),
            ],
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _controllers[key],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(12),
              isDense: true,
              hintText: 'Enter $key',
            ),
            onChanged: (newValue) => _updateProperty(key, newValue),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberField(String key, num value) {
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController(text: value.toString());
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  key,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _removeProperty(key),
              ),
            ],
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _controllers[key],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(12),
              isDense: true,
              hintText: 'Enter number',
              suffixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      final current = num.tryParse(_controllers[key]!.text) ?? 0;
                      _controllers[key]!.text = (current + 1).toString();
                      _updateProperty(key, current + 1);
                    },
                    child: const Icon(Icons.arrow_drop_up, size: 16),
                  ),
                  InkWell(
                    onTap: () {
                      final current = num.tryParse(_controllers[key]!.text) ?? 0;
                      _controllers[key]!.text = (current - 1).toString();
                      _updateProperty(key, current - 1);
                    },
                    child: const Icon(Icons.arrow_drop_down, size: 16),
                  ),
                ],
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
            ],
            onChanged: (newValue) {
              final numValue = num.tryParse(newValue);
              if (numValue != null) {
                _updateProperty(key, numValue);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBooleanField(String key, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              key,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          Switch(
            value: value,
            onChanged: (newValue) => _updateProperty(key, newValue),
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 16),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => _removeProperty(key),
          ),
        ],
      ),
    );
  }

  Widget _buildColorField(String key, String value) {
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController(text: value);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  key,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _removeProperty(key),
              ),
            ],
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _controllers[key],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(12),
              isDense: true,
              hintText: '#RRGGBB or color name',
              prefixIcon: Container(
                margin: const EdgeInsets.all(8),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _parseColor(value),
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            onChanged: (newValue) => _updateProperty(key, newValue),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPropertyButton() {
    return OutlinedButton.icon(
      onPressed: _showAddPropertyDialog,
      icon: const Icon(Icons.add, size: 16),
      label: const Text('Add Property'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildCommonProperties(WidgetNode node) {
    final suggestions = _getPropertySuggestions(node.type);
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return _buildSection(
      'Suggested Properties',
      [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: suggestions.map((prop) {
            final alreadyExists = node.properties.containsKey(prop);
            return FilterChip(
              label: Text(prop, style: const TextStyle(fontSize: 11)),
              selected: alreadyExists,
              onSelected: alreadyExists
                  ? null
                  : (selected) {
                      if (selected) {
                        _addProperty(prop, _getDefaultValue(prop));
                      }
                    },
            );
          }).toList(),
        ),
      ],
    );
  }

  List<String> _getPropertySuggestions(String type) {
    const commonProps = {
      'text': ['data', 'fontSize', 'color', 'fontWeight', 'textAlign'],
      'container': ['width', 'height', 'padding', 'margin', 'color', 'borderRadius'],
      'image': ['url', 'width', 'height', 'fit'],
      'elevatedButton': ['label', 'onPressed', 'color'],
      'textField': ['hint', 'label', 'value', 'maxLines'],
      'column': ['mainAxisAlignment', 'crossAxisAlignment', 'spacing'],
      'row': ['mainAxisAlignment', 'crossAxisAlignment', 'spacing'],
    };

    return commonProps[type] ?? [];
  }

  dynamic _getDefaultValue(String key) {
    if (key.contains('color')) return '#000000';
    if (key.contains('size') || key.contains('width') || key.contains('height')) {
      return 100.0;
    }
    if (key.contains('padding') || key.contains('margin')) return 16.0;
    return '';
  }

  void _updateProperty(String key, dynamic value) {
    if (widget.selectedNode != null) {
      widget.selectedNode!.updateProperty(key, value);
      widget.onPropertyChanged(widget.selectedNode!);
    }
  }

  void _removeProperty(String key) {
    if (widget.selectedNode != null) {
      widget.selectedNode!.removeProperty(key);
      _controllers.remove(key)?.dispose();
      widget.onPropertyChanged(widget.selectedNode!);
      setState(() {});
    }
  }

  void _addProperty(String key, dynamic value) {
    if (widget.selectedNode != null) {
      widget.selectedNode!.updateProperty(key, value);
      _controllers[key] = TextEditingController(text: value.toString());
      widget.onPropertyChanged(widget.selectedNode!);
      setState(() {});
    }
  }

  void _showAddPropertyDialog() {
    final keyController = TextEditingController();
    final valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Property'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyController,
              decoration: const InputDecoration(
                labelText: 'Property Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(
                labelText: 'Property Value',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (keyController.text.isNotEmpty) {
                _addProperty(keyController.text, valueController.text);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Color _parseColor(String colorString) {
    try {
      if (colorString.startsWith('#')) {
        final hex = colorString.substring(1);
        if (hex.length == 6) {
          return Color(int.parse('FF$hex', radix: 16));
        } else if (hex.length == 8) {
          return Color(int.parse(hex, radix: 16));
        }
      }
    } catch (e) {
      // Invalid color format
    }
    return Colors.grey;
  }
}
