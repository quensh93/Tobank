/// A model representing a widget node in the debug panel's visual editor
class WidgetNode {
  final String id;
  final String type;
  final Map<String, dynamic> properties;
  final List<WidgetNode> children;
  final WidgetNode? parent;

  const WidgetNode({
    required this.id,
    required this.type,
    required this.properties,
    this.children = const [],
    this.parent,
  });

  /// Whether this widget type supports having children
  bool get supportsChildren {
    const containerTypes = [
      'Container',
      'Column',
      'Row',
      'Stack',
      'Scaffold',
      'Card',
      'Padding',
      'Center',
      'Align',
    ];
    return containerTypes.contains(type);
  }

  /// Add a child to this node
  WidgetNode addChild(WidgetNode child) {
    if (!supportsChildren) {
      throw UnsupportedError('Widget type $type does not support children');
    }
    final newChildren = List<WidgetNode>.from(children)..add(child);
    return copyWith(children: newChildren);
  }

  /// Update a property of this node
  WidgetNode updateProperty(String key, dynamic value) {
    final newProperties = Map<String, dynamic>.from(properties);
    newProperties[key] = value;
    return copyWith(properties: newProperties);
  }

  /// Remove a property from this node
  WidgetNode removeProperty(String key) {
    final newProperties = Map<String, dynamic>.from(properties);
    newProperties.remove(key);
    return copyWith(properties: newProperties);
  }

  WidgetNode copyWith({
    String? id,
    String? type,
    Map<String, dynamic>? properties,
    List<WidgetNode>? children,
    WidgetNode? parent,
  }) {
    return WidgetNode(
      id: id ?? this.id,
      type: type ?? this.type,
      properties: properties ?? this.properties,
      children: children ?? this.children,
      parent: parent ?? this.parent,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'properties': properties,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  factory WidgetNode.fromJson(Map<String, dynamic> json) {
    return WidgetNode(
      id: json['id'] as String,
      type: json['type'] as String,
      properties: json['properties'] as Map<String, dynamic>,
      children: (json['children'] as List<dynamic>?)
              ?.map((child) => WidgetNode.fromJson(child as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}