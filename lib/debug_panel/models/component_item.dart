/// A model representing a component item in the debug panel's component palette
class ComponentItem {
  final String type;
  final String name;
  final String description;
  final Map<String, dynamic> defaultProperties;
  final String? icon;
  final String category;

  const ComponentItem({
    required this.type,
    required this.name,
    required this.description,
    required this.defaultProperties,
    this.icon,
    this.category = 'General',
  });

  ComponentItem copyWith({
    String? type,
    String? name,
    String? description,
    Map<String, dynamic>? defaultProperties,
    String? icon,
    String? category,
  }) {
    return ComponentItem(
      type: type ?? this.type,
      name: name ?? this.name,
      description: description ?? this.description,
      defaultProperties: defaultProperties ?? this.defaultProperties,
      icon: icon ?? this.icon,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'description': description,
      'defaultProperties': defaultProperties,
      'icon': icon,
      'category': category,
    };
  }

  factory ComponentItem.fromJson(Map<String, dynamic> json) {
    return ComponentItem(
      type: json['type'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      defaultProperties: json['defaultProperties'] as Map<String, dynamic>,
      icon: json['icon'] as String?,
      category: json['category'] as String? ?? 'General',
    );
  }
}