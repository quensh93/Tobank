/// Represents a menu item in the STAC application
class MenuItem {
  /// Unique identifier for this menu item
  final String id;

  /// Display label for the menu item
  final String label;

  /// Icon name (e.g., 'home', 'settings', 'person')
  final String? icon;

  /// Action to perform when menu item is tapped
  final MenuAction action;

  /// Order/position in the menu (lower numbers appear first)
  final int order;

  /// Whether this menu item is enabled
  final bool enabled;

  /// Whether this menu item is visible
  final bool visible;

  /// Badge text (e.g., notification count)
  final String? badge;

  /// Submenu items (for nested menus)
  final List<MenuItem> children;

  /// Menu item metadata
  final Map<String, dynamic> metadata;

  MenuItem({
    required this.id,
    required this.label,
    this.icon,
    required this.action,
    this.order = 0,
    this.enabled = true,
    this.visible = true,
    this.badge,
    List<MenuItem>? children,
    Map<String, dynamic>? metadata,
  })  : children = children ?? [],
        metadata = metadata ?? {};

  /// Create a copy with updated fields
  MenuItem copyWith({
    String? id,
    String? label,
    String? icon,
    MenuAction? action,
    int? order,
    bool? enabled,
    bool? visible,
    String? badge,
    List<MenuItem>? children,
    Map<String, dynamic>? metadata,
  }) {
    return MenuItem(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      action: action ?? this.action,
      order: order ?? this.order,
      enabled: enabled ?? this.enabled,
      visible: visible ?? this.visible,
      badge: badge ?? this.badge,
      children: children ?? this.children,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      if (icon != null) 'icon': icon,
      'action': action.toJson(),
      'order': order,
      'enabled': enabled,
      'visible': visible,
      if (badge != null) 'badge': badge,
      if (children.isNotEmpty)
        'children': children.map((c) => c.toJson()).toList(),
      'metadata': metadata,
    };
  }

  /// Create from JSON format
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      icon: json['icon'] as String?,
      action: MenuAction.fromJson(json['action'] as Map<String, dynamic>? ?? {}),
      order: json['order'] as int? ?? 0,
      enabled: json['enabled'] as bool? ?? true,
      visible: json['visible'] as bool? ?? true,
      badge: json['badge'] as String?,
      children: (json['children'] as List?)
              ?.map((c) => MenuItem.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      metadata: Map<String, dynamic>.from(json['metadata'] as Map? ?? {}),
    );
  }

  /// Check if this menu item has children
  bool get hasChildren => children.isNotEmpty;

  @override
  String toString() {
    return 'MenuItem(label: $label, action: ${action.type})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Represents an action that can be performed by a menu item
class MenuAction {
  /// Action type (e.g., 'navigate', 'showDialog', 'custom')
  final String type;

  /// Action parameters
  final Map<String, dynamic> parameters;

  MenuAction({
    required this.type,
    Map<String, dynamic>? parameters,
  }) : parameters = parameters ?? {};

  /// Create a navigation action
  factory MenuAction.navigate(String route, {Map<String, dynamic>? params}) {
    return MenuAction(
      type: 'navigate',
      parameters: {
        'route': route,
        if (params != null) 'params': params,
      },
    );
  }

  /// Create a dialog action
  factory MenuAction.showDialog({
    required String title,
    required String message,
  }) {
    return MenuAction(
      type: 'showDialog',
      parameters: {
        'title': title,
        'message': message,
      },
    );
  }

  /// Create a custom action
  factory MenuAction.custom(String actionName, Map<String, dynamic> params) {
    return MenuAction(
      type: 'custom',
      parameters: {
        'actionName': actionName,
        ...params,
      },
    );
  }

  /// Create a copy with updated fields
  MenuAction copyWith({
    String? type,
    Map<String, dynamic>? parameters,
  }) {
    return MenuAction(
      type: type ?? this.type,
      parameters: parameters ?? this.parameters,
    );
  }

  /// Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'parameters': parameters,
    };
  }

  /// Create from JSON format
  factory MenuAction.fromJson(Map<String, dynamic> json) {
    return MenuAction(
      type: json['type'] as String? ?? 'navigate',
      parameters: Map<String, dynamic>.from(json['parameters'] as Map? ?? {}),
    );
  }

  @override
  String toString() {
    return 'MenuAction(type: $type)';
  }
}
