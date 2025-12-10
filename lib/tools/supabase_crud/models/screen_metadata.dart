// Supabase CRUD Models - Disabled due to dependency issues
// Uncomment and add Supabase dependencies when needed

/// Metadata for a screen stored in Supabase
/// Currently disabled - add Supabase dependencies to enable
class ScreenMetadata {
  final String id;
  final String name;
  final String? description;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String? author;
  final Map<String, dynamic>? customFields;
  final String? route;

  const ScreenMetadata({
    required this.id,
    required this.name,
    this.description,
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
    this.version = 1,
    this.author,
    this.customFields,
    this.route,
  });

  /// Create from Firestore document
  factory ScreenMetadata.fromFirestore(Map<String, dynamic> data, String id) {
    return ScreenMetadata(
      id: id,
      name: data['name'] as String,
      description: data['description'] as String?,
      tags: List<String>.from(data['tags'] ?? []),
      createdAt: _parseTimestamp(data['createdAt']),
      updatedAt: _parseTimestamp(data['updatedAt']),
      version: data['version'] as int? ?? 1,
      author: data['author'] as String?,
      customFields: data['customFields'] as Map<String, dynamic>?,
      route: data['route'] as String?,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      if (description != null) 'description': description,
      'tags': tags,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'version': version,
      if (author != null) 'author': author,
      if (customFields != null) 'customFields': customFields,
      if (route != null) 'route': route,
    };
  }

  /// Parse timestamp from Firestore (handles both Timestamp and DateTime)
  static DateTime _parseTimestamp(dynamic timestamp) {
    if (timestamp == null) return DateTime.now();
    if (timestamp is DateTime) return timestamp;
    // For Supabase Timestamp, would be: timestamp.toDate()
    // Since Supabase is disabled, return current time
    return DateTime.now();
  }

  ScreenMetadata copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    String? author,
    Map<String, dynamic>? customFields,
    String? route,
  }) {
    return ScreenMetadata(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      author: author ?? this.author,
      customFields: customFields ?? this.customFields,
      route: route ?? this.route,
    );
  }

  @override
  String toString() {
    return 'ScreenMetadata(id: $id, name: $name, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScreenMetadata && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
