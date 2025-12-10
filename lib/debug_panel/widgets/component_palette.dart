import 'package:flutter/material.dart';

/// Represents a category of components in the palette
class ComponentCategory {
  final String name;
  final IconData icon;
  final List<ComponentItem> components;

  const ComponentCategory({
    required this.name,
    required this.icon,
    required this.components,
  });
}

/// Represents a draggable component item
class ComponentItem {
  final String type;
  final String displayName;
  final IconData icon;
  final String description;
  final Map<String, dynamic> defaultProperties;

  const ComponentItem({
    required this.type,
    required this.displayName,
    required this.icon,
    required this.description,
    this.defaultProperties = const {},
  });
}

/// Component palette widget with drag-and-drop support
class ComponentPalette extends StatefulWidget {
  final Function(ComponentItem)? onComponentSelected;

  const ComponentPalette({
    super.key,
    this.onComponentSelected,
  });

  @override
  State<ComponentPalette> createState() => _ComponentPaletteState();
}

class _ComponentPaletteState extends State<ComponentPalette> {
  String _searchQuery = '';
  int? _expandedCategoryIndex;

  // Define all available component categories
  static final List<ComponentCategory> _categories = [
    const ComponentCategory(
      name: 'Layout',
      icon: Icons.view_quilt,
      components: [
        ComponentItem(
          type: 'column',
          displayName: 'Column',
          icon: Icons.view_column,
          description: 'Vertical layout',
          defaultProperties: {'mainAxisAlignment': 'start', 'crossAxisAlignment': 'center'},
        ),
        ComponentItem(
          type: 'row',
          displayName: 'Row',
          icon: Icons.view_week,
          description: 'Horizontal layout',
          defaultProperties: {'mainAxisAlignment': 'start', 'crossAxisAlignment': 'center'},
        ),
        ComponentItem(
          type: 'stack',
          displayName: 'Stack',
          icon: Icons.layers,
          description: 'Overlapping widgets',
          defaultProperties: {'alignment': 'center'},
        ),
        ComponentItem(
          type: 'container',
          displayName: 'Container',
          icon: Icons.crop_square,
          description: 'Box with decoration',
          defaultProperties: {'padding': 16.0},
        ),
        ComponentItem(
          type: 'center',
          displayName: 'Center',
          icon: Icons.center_focus_strong,
          description: 'Center child widget',
        ),
        ComponentItem(
          type: 'padding',
          displayName: 'Padding',
          icon: Icons.space_bar,
          description: 'Add padding',
          defaultProperties: {'padding': 16.0},
        ),
        ComponentItem(
          type: 'sizedBox',
          displayName: 'Sized Box',
          icon: Icons.crop_din,
          description: 'Fixed size box',
          defaultProperties: {'width': 100.0, 'height': 100.0},
        ),
        ComponentItem(
          type: 'expanded',
          displayName: 'Expanded',
          icon: Icons.open_in_full,
          description: 'Fill available space',
          defaultProperties: {'flex': 1},
        ),
      ],
    ),
    const ComponentCategory(
      name: 'Display',
      icon: Icons.text_fields,
      components: [
        ComponentItem(
          type: 'text',
          displayName: 'Text',
          icon: Icons.text_fields,
          description: 'Display text',
          defaultProperties: {'data': 'Text', 'fontSize': 16.0},
        ),
        ComponentItem(
          type: 'image',
          displayName: 'Image',
          icon: Icons.image,
          description: 'Display image',
          defaultProperties: {'url': 'https://via.placeholder.com/150'},
        ),
        ComponentItem(
          type: 'icon',
          displayName: 'Icon',
          icon: Icons.star,
          description: 'Display icon',
          defaultProperties: {'icon': 'star', 'size': 24.0},
        ),
        ComponentItem(
          type: 'divider',
          displayName: 'Divider',
          icon: Icons.horizontal_rule,
          description: 'Horizontal line',
        ),
        ComponentItem(
          type: 'card',
          displayName: 'Card',
          icon: Icons.credit_card,
          description: 'Material card',
          defaultProperties: {'elevation': 2.0},
        ),
        ComponentItem(
          type: 'listTile',
          displayName: 'List Tile',
          icon: Icons.list,
          description: 'List item',
          defaultProperties: {'title': 'Title', 'subtitle': 'Subtitle'},
        ),
      ],
    ),
    const ComponentCategory(
      name: 'Interactive',
      icon: Icons.touch_app,
      components: [
        ComponentItem(
          type: 'elevatedButton',
          displayName: 'Elevated Button',
          icon: Icons.smart_button,
          description: 'Raised button',
          defaultProperties: {'label': 'Button'},
        ),
        ComponentItem(
          type: 'textButton',
          displayName: 'Text Button',
          icon: Icons.text_fields,
          description: 'Flat text button',
          defaultProperties: {'label': 'Button'},
        ),
        ComponentItem(
          type: 'outlinedButton',
          displayName: 'Outlined Button',
          icon: Icons.border_style,
          description: 'Outlined button',
          defaultProperties: {'label': 'Button'},
        ),
        ComponentItem(
          type: 'iconButton',
          displayName: 'Icon Button',
          icon: Icons.radio_button_checked,
          description: 'Icon button',
          defaultProperties: {'icon': 'add'},
        ),
        ComponentItem(
          type: 'textField',
          displayName: 'Text Field',
          icon: Icons.input,
          description: 'Text input',
          defaultProperties: {'hint': 'Enter text'},
        ),
        ComponentItem(
          type: 'checkbox',
          displayName: 'Checkbox',
          icon: Icons.check_box,
          description: 'Checkbox input',
          defaultProperties: {'value': false},
        ),
        ComponentItem(
          type: 'switch',
          displayName: 'Switch',
          icon: Icons.toggle_on,
          description: 'Toggle switch',
          defaultProperties: {'value': false},
        ),
        ComponentItem(
          type: 'slider',
          displayName: 'Slider',
          icon: Icons.linear_scale,
          description: 'Value slider',
          defaultProperties: {'value': 0.5, 'min': 0.0, 'max': 1.0},
        ),
      ],
    ),
    const ComponentCategory(
      name: 'Lists',
      icon: Icons.list_alt,
      components: [
        ComponentItem(
          type: 'listView',
          displayName: 'List View',
          icon: Icons.view_list,
          description: 'Scrollable list',
        ),
        ComponentItem(
          type: 'gridView',
          displayName: 'Grid View',
          icon: Icons.grid_view,
          description: 'Scrollable grid',
          defaultProperties: {'crossAxisCount': 2},
        ),
        ComponentItem(
          type: 'wrap',
          displayName: 'Wrap',
          icon: Icons.wrap_text,
          description: 'Wrapping layout',
          defaultProperties: {'spacing': 8.0},
        ),
      ],
    ),
    const ComponentCategory(
      name: 'Structure',
      icon: Icons.account_tree,
      components: [
        ComponentItem(
          type: 'scaffold',
          displayName: 'Scaffold',
          icon: Icons.web_asset,
          description: 'App structure',
        ),
        ComponentItem(
          type: 'appBar',
          displayName: 'App Bar',
          icon: Icons.web,
          description: 'Top app bar',
          defaultProperties: {'title': 'App Bar'},
        ),
        ComponentItem(
          type: 'bottomNavigationBar',
          displayName: 'Bottom Nav',
          icon: Icons.navigation,
          description: 'Bottom navigation',
        ),
        ComponentItem(
          type: 'drawer',
          displayName: 'Drawer',
          icon: Icons.menu,
          description: 'Side drawer',
        ),
      ],
    ),
  ];

  List<ComponentItem> get _filteredComponents {
    if (_searchQuery.isEmpty) {
      return [];
    }

    final query = _searchQuery.toLowerCase();
    final List<ComponentItem> results = [];

    for (final category in _categories) {
      for (final component in category.components) {
        if (component.displayName.toLowerCase().contains(query) ||
            component.type.toLowerCase().contains(query) ||
            component.description.toLowerCase().contains(query)) {
          results.add(component);
        }
      }
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          Expanded(
            child: _searchQuery.isEmpty
                ? _buildCategoryList()
                : _buildSearchResults(),
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
          Icon(Icons.widgets, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Text(
            'Components',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search components...',
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          isDense: true,
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildCategoryList() {
    return ListView.builder(
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        final isExpanded = _expandedCategoryIndex == index;

        return Column(
          children: [
            ListTile(
              leading: Icon(category.icon, size: 20),
              title: Text(
                category.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 20,
              ),
              onTap: () {
                setState(() {
                  _expandedCategoryIndex = isExpanded ? null : index;
                });
              },
            ),
            if (isExpanded)
              ...category.components.map((component) => _buildComponentItem(component)),
          ],
        );
      },
    );
  }

  Widget _buildSearchResults() {
    final results = _filteredComponents;

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No components found',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return _buildComponentItem(results[index]);
      },
    );
  }

  Widget _buildComponentItem(ComponentItem component) {
    return Draggable<ComponentItem>(
      data: component,
      feedback: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(component.icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                component.displayName,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildComponentTile(component),
      ),
      child: _buildComponentTile(component),
    );
  }

  Widget _buildComponentTile(ComponentItem component) {
    return ListTile(
      dense: true,
      leading: Icon(component.icon, size: 20),
      title: Text(component.displayName),
      subtitle: Text(
        component.description,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      onTap: () {
        widget.onComponentSelected?.call(component);
      },
    );
  }
}
