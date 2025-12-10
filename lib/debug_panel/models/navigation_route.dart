/// Represents a navigation route in the STAC application
class NavigationRoute {
  /// Unique identifier for this route
  final String id;

  /// Route path (e.g., '/home', '/profile/:id')
  final String path;

  /// Display name for the route
  final String name;

  /// Screen name to load for this route
  final String screenName;

  /// Route parameters (e.g., {'id': 'string', 'tab': 'int'})
  final Map<String, String> parameters;

  /// Whether this is the initial route
  final bool isInitial;

  /// Route metadata (description, tags, etc.)
  final Map<String, dynamic> metadata;

  NavigationRoute({
    required this.id,
    required this.path,
    required this.name,
    required this.screenName,
    Map<String, String>? parameters,
    this.isInitial = false,
    Map<String, dynamic>? metadata,
  })  : parameters = parameters ?? {},
        metadata = metadata ?? {};

  /// Create a copy with updated fields
  NavigationRoute copyWith({
    String? id,
    String? path,
    String? name,
    String? screenName,
    Map<String, String>? parameters,
    bool? isInitial,
    Map<String, dynamic>? metadata,
  }) {
    return NavigationRoute(
      id: id ?? this.id,
      path: path ?? this.path,
      name: name ?? this.name,
      screenName: screenName ?? this.screenName,
      parameters: parameters ?? this.parameters,
      isInitial: isInitial ?? this.isInitial,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'name': name,
      'screenName': screenName,
      'parameters': parameters,
      'isInitial': isInitial,
      'metadata': metadata,
    };
  }

  /// Create from JSON format
  factory NavigationRoute.fromJson(Map<String, dynamic> json) {
    return NavigationRoute(
      id: json['id'] as String? ?? '',
      path: json['path'] as String? ?? '',
      name: json['name'] as String? ?? '',
      screenName: json['screenName'] as String? ?? '',
      parameters: Map<String, String>.from(json['parameters'] as Map? ?? {}),
      isInitial: json['isInitial'] as bool? ?? false,
      metadata: Map<String, dynamic>.from(json['metadata'] as Map? ?? {}),
    );
  }

  /// Get parameter names from path (e.g., '/profile/:id' -> ['id'])
  List<String> get pathParameters {
    final regex = RegExp(r':(\w+)');
    final matches = regex.allMatches(path);
    return matches.map((m) => m.group(1)!).toList();
  }

  /// Validate that all path parameters are defined
  bool get isValid {
    final pathParams = pathParameters;
    return pathParams.every((param) => parameters.containsKey(param));
  }

  @override
  String toString() {
    return 'NavigationRoute(path: $path, name: $name, screen: $screenName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NavigationRoute && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
