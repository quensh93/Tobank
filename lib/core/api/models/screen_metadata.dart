/// Screen metadata model
///
/// Contains metadata information about a STAC screen configuration.
class ScreenMetadata {
  /// Screen name/identifier
  final String name;

  /// Route path for navigation
  final String route;

  /// Version number of the screen configuration
  final int version;

  /// Last update timestamp
  final DateTime updatedAt;

  /// Optional description of the screen
  final String? description;

  /// Tags for categorization and search
  final List<String> tags;

  const ScreenMetadata({
    required this.name,
    required this.route,
    required this.version,
    required this.updatedAt,
    this.description,
    this.tags = const [],
  });

  /// Create from JSON
  factory ScreenMetadata.fromJson(Map<String, dynamic> json) {
    return ScreenMetadata(
      name: json['name'] as String,
      route: json['route'] as String,
      version: json['version'] as int,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      description: json['description'] as String?,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'route': route,
      'version': version,
      'updated_at': updatedAt.toIso8601String(),
      if (description != null) 'description': description,
      'tags': tags,
    };
  }

  /// Copy with method
  ScreenMetadata copyWith({
    String? name,
    String? route,
    int? version,
    DateTime? updatedAt,
    String? description,
    List<String>? tags,
  }) {
    return ScreenMetadata(
      name: name ?? this.name,
      route: route ?? this.route,
      version: version ?? this.version,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      tags: tags ?? this.tags,
    );
  }

  @override
  String toString() {
    return 'ScreenMetadata(name: $name, route: $route, version: $version, '
        'updatedAt: $updatedAt, description: $description, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenMetadata &&
        other.name == name &&
        other.route == route &&
        other.version == version &&
        other.updatedAt == updatedAt &&
        other.description == description;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        route.hashCode ^
        version.hashCode ^
        updatedAt.hashCode ^
        description.hashCode;
  }
}
