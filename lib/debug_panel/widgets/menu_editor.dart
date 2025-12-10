import 'package:flutter/material.dart';
import '../models/menu_item.dart';

/// Visual editor for menu items
/// Allows adding, editing, deleting, and reordering menu items with drag-and-drop
class MenuEditor extends StatefulWidget {
  /// List of menu items
  final List<MenuItem> menuItems;

  /// Callback when menu items are updated
  final ValueChanged<List<MenuItem>>? onMenuItemsChanged;

  /// Callback when a menu item is selected
  final ValueChanged<MenuItem>? onMenuItemSelected;

  /// Currently selected menu item
  final MenuItem? selectedMenuItem;

  const MenuEditor({
    super.key,
    required this.menuItems,
    this.onMenuItemsChanged,
    this.onMenuItemSelected,
    this.selectedMenuItem,
  });

  @override
  State<MenuEditor> createState() => _MenuEditorState();
}

class _MenuEditorState extends State<MenuEditor> {
  late List<MenuItem> _menuItems;
  MenuItem? _selectedMenuItem;

  @override
  void initState() {
    super.initState();
    _menuItems = List.from(widget.menuItems);
    _selectedMenuItem = widget.selectedMenuItem;
  }

  @override
  void didUpdateWidget(MenuEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.menuItems != oldWidget.menuItems) {
      _menuItems = List.from(widget.menuItems);
    }
    if (widget.selectedMenuItem != oldWidget.selectedMenuItem) {
      _selectedMenuItem = widget.selectedMenuItem;
    }
  }

  void _addMenuItem() {
    final newMenuItem = MenuItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      label: 'New Menu Item',
      icon: 'menu',
      action: MenuAction.navigate('/'),
      order: _menuItems.length,
    );

    setState(() {
      _menuItems.add(newMenuItem);
      _selectedMenuItem = newMenuItem;
    });

    widget.onMenuItemsChanged?.call(_menuItems);
    widget.onMenuItemSelected?.call(newMenuItem);
  }

  void _deleteMenuItem(MenuItem menuItem) {
    setState(() {
      _menuItems.remove(menuItem);
      if (_selectedMenuItem == menuItem) {
        _selectedMenuItem = null;
      }
    });

    widget.onMenuItemsChanged?.call(_menuItems);
  }

  void _updateMenuItem(MenuItem oldMenuItem, MenuItem newMenuItem) {
    setState(() {
      final index = _menuItems.indexOf(oldMenuItem);
      if (index != -1) {
        _menuItems[index] = newMenuItem;
        if (_selectedMenuItem == oldMenuItem) {
          _selectedMenuItem = newMenuItem;
        }
      }
    });

    widget.onMenuItemsChanged?.call(_menuItems);
  }

  void _selectMenuItem(MenuItem menuItem) {
    setState(() {
      _selectedMenuItem = menuItem;
    });
    widget.onMenuItemSelected?.call(menuItem);
  }

  void _reorderMenuItems(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _menuItems.removeAt(oldIndex);
      _menuItems.insert(newIndex, item);

      // Update order values
      for (int i = 0; i < _menuItems.length; i++) {
        _menuItems[i] = _menuItems[i].copyWith(order: i);
      }
    });

    widget.onMenuItemsChanged?.call(_menuItems);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Menu items list
        Expanded(
          flex: 2,
          child: _buildMenuItemsList(),
        ),
        const VerticalDivider(width: 1),
        // Menu item editor
        Expanded(
          flex: 3,
          child: _selectedMenuItem != null
              ? _buildMenuItemEditor(_selectedMenuItem!)
              : _buildEmptyState(),
        ),
      ],
    );
  }

  Widget _buildMenuItemsList() {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Menu Items',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addMenuItem,
                tooltip: 'Add Menu Item',
              ),
            ],
          ),
        ),
        // Menu items list with drag-and-drop
        Expanded(
          child: _menuItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        size: 64,
                        color: Theme.of(context).disabledColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No menu items defined',
                        style: TextStyle(
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _addMenuItem,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Menu Item'),
                      ),
                    ],
                  ),
                )
              : ReorderableListView.builder(
                  itemCount: _menuItems.length,
                  onReorder: _reorderMenuItems,
                  itemBuilder: (context, index) {
                    final menuItem = _menuItems[index];
                    final isSelected = menuItem == _selectedMenuItem;

                    return ListTile(
                      key: ValueKey(menuItem.id),
                      selected: isSelected,
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.drag_handle,
                            color: Theme.of(context).disabledColor,
                          ),
                          const SizedBox(width: 8),
                          Icon(_getIconData(menuItem.icon)),
                        ],
                      ),
                      title: Text(menuItem.label),
                      subtitle: Text(
                        _getActionDescription(menuItem.action),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!menuItem.enabled)
                            const Icon(
                              Icons.visibility_off,
                              size: 16,
                            ),
                          if (menuItem.badge != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Badge(
                                label: Text(menuItem.badge!),
                              ),
                            ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 20),
                            onPressed: () => _deleteMenuItem(menuItem),
                            tooltip: 'Delete Menu Item',
                          ),
                        ],
                      ),
                      onTap: () => _selectMenuItem(menuItem),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildMenuItemEditor(MenuItem menuItem) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Edit Menu Item',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),

          // Label
          _buildTextField(
            label: 'Label',
            value: menuItem.label,
            onChanged: (value) {
              _updateMenuItem(menuItem, menuItem.copyWith(label: value));
            },
            hint: 'e.g., Home, Settings, Profile',
          ),
          const SizedBox(height: 16),

          // Icon
          _buildTextField(
            label: 'Icon',
            value: menuItem.icon ?? '',
            onChanged: (value) {
              _updateMenuItem(
                menuItem,
                menuItem.copyWith(icon: value.isEmpty ? null : value),
              );
            },
            hint: 'e.g., home, settings, person',
            helperText: 'Material icon name',
          ),
          const SizedBox(height: 16),

          // Badge
          _buildTextField(
            label: 'Badge',
            value: menuItem.badge ?? '',
            onChanged: (value) {
              _updateMenuItem(
                menuItem,
                menuItem.copyWith(badge: value.isEmpty ? null : value),
              );
            },
            hint: 'e.g., 5, New',
            helperText: 'Optional badge text (e.g., notification count)',
          ),
          const SizedBox(height: 16),

          // Enabled Toggle
          SwitchListTile(
            title: const Text('Enabled'),
            subtitle: const Text('Menu item can be interacted with'),
            value: menuItem.enabled,
            onChanged: (value) {
              _updateMenuItem(menuItem, menuItem.copyWith(enabled: value));
            },
          ),

          // Visible Toggle
          SwitchListTile(
            title: const Text('Visible'),
            subtitle: const Text('Menu item is shown in the menu'),
            value: menuItem.visible,
            onChanged: (value) {
              _updateMenuItem(menuItem, menuItem.copyWith(visible: value));
            },
          ),
          const SizedBox(height: 24),

          // Action Section
          Text(
            'Action Configuration',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          // Action Type
          DropdownButtonFormField<String>(
            initialValue: menuItem.action.type,
            decoration: const InputDecoration(
              labelText: 'Action Type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'navigate', child: Text('Navigate')),
              DropdownMenuItem(value: 'showDialog', child: Text('Show Dialog')),
              DropdownMenuItem(value: 'custom', child: Text('Custom Action')),
            ],
            onChanged: (value) {
              if (value != null) {
                MenuAction newAction;
                switch (value) {
                  case 'navigate':
                    newAction = MenuAction.navigate('/');
                    break;
                  case 'showDialog':
                    newAction = MenuAction.showDialog(
                      title: 'Title',
                      message: 'Message',
                    );
                    break;
                  case 'custom':
                    newAction = MenuAction.custom('customAction', {});
                    break;
                  default:
                    newAction = menuItem.action;
                }
                _updateMenuItem(menuItem, menuItem.copyWith(action: newAction));
              }
            },
          ),
          const SizedBox(height: 16),

          // Action Parameters based on type
          ..._buildActionParameters(menuItem),
        ],
      ),
    );
  }

  List<Widget> _buildActionParameters(MenuItem menuItem) {
    final action = menuItem.action;
    final widgets = <Widget>[];

    switch (action.type) {
      case 'navigate':
        widgets.add(
          _buildTextField(
            label: 'Route',
            value: action.parameters['route']?.toString() ?? '/',
            onChanged: (value) {
              final newAction = MenuAction(
                type: action.type,
                parameters: {
                  ...action.parameters,
                  'route': value,
                },
              );
              _updateMenuItem(menuItem, menuItem.copyWith(action: newAction));
            },
            hint: 'e.g., /home, /profile',
          ),
        );
        break;

      case 'showDialog':
        widgets.add(
          _buildTextField(
            label: 'Dialog Title',
            value: action.parameters['title']?.toString() ?? '',
            onChanged: (value) {
              final newAction = MenuAction(
                type: action.type,
                parameters: {
                  ...action.parameters,
                  'title': value,
                },
              );
              _updateMenuItem(menuItem, menuItem.copyWith(action: newAction));
            },
            hint: 'Dialog title',
          ),
        );
        widgets.add(const SizedBox(height: 16));
        widgets.add(
          _buildTextField(
            label: 'Dialog Message',
            value: action.parameters['message']?.toString() ?? '',
            onChanged: (value) {
              final newAction = MenuAction(
                type: action.type,
                parameters: {
                  ...action.parameters,
                  'message': value,
                },
              );
              _updateMenuItem(menuItem, menuItem.copyWith(action: newAction));
            },
            hint: 'Dialog message',
            maxLines: 3,
          ),
        );
        break;

      case 'custom':
        widgets.add(
          _buildTextField(
            label: 'Action Name',
            value: action.parameters['actionName']?.toString() ?? '',
            onChanged: (value) {
              final newAction = MenuAction(
                type: action.type,
                parameters: {
                  ...action.parameters,
                  'actionName': value,
                },
              );
              _updateMenuItem(menuItem, menuItem.copyWith(action: newAction));
            },
            hint: 'e.g., openSettings, logout',
          ),
        );
        break;
    }

    return widgets;
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    String? hint,
    String? helperText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: TextEditingController(text: value)
        ..selection = TextSelection.collapsed(offset: value.length),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        border: const OutlineInputBorder(),
      ),
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 64,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Select a menu item to edit',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String? iconName) {
    if (iconName == null || iconName.isEmpty) return Icons.menu;

    // Map common icon names to IconData
    final iconMap = {
      'home': Icons.home,
      'settings': Icons.settings,
      'person': Icons.person,
      'profile': Icons.person,
      'menu': Icons.menu,
      'search': Icons.search,
      'favorite': Icons.favorite,
      'star': Icons.star,
      'notifications': Icons.notifications,
      'message': Icons.message,
      'mail': Icons.mail,
      'phone': Icons.phone,
      'camera': Icons.camera,
      'photo': Icons.photo,
      'video': Icons.video_library,
      'music': Icons.music_note,
      'location': Icons.location_on,
      'map': Icons.map,
      'calendar': Icons.calendar_today,
      'clock': Icons.access_time,
      'info': Icons.info,
      'help': Icons.help,
      'logout': Icons.logout,
      'login': Icons.login,
      'account': Icons.account_circle,
      'dashboard': Icons.dashboard,
      'list': Icons.list,
      'grid': Icons.grid_view,
      'folder': Icons.folder,
      'file': Icons.insert_drive_file,
      'download': Icons.download,
      'upload': Icons.upload,
      'share': Icons.share,
      'edit': Icons.edit,
      'delete': Icons.delete,
      'add': Icons.add,
      'remove': Icons.remove,
      'check': Icons.check,
      'close': Icons.close,
      'arrow_back': Icons.arrow_back,
      'arrow_forward': Icons.arrow_forward,
      'more': Icons.more_vert,
    };

    return iconMap[iconName.toLowerCase()] ?? Icons.menu;
  }

  String _getActionDescription(MenuAction action) {
    switch (action.type) {
      case 'navigate':
        return 'Navigate to ${action.parameters['route'] ?? '/'}';
      case 'showDialog':
        return 'Show dialog: ${action.parameters['title'] ?? 'Dialog'}';
      case 'custom':
        return 'Custom: ${action.parameters['actionName'] ?? 'action'}';
      default:
        return action.type;
    }
  }
}
