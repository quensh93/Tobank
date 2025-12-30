/// Category of the log message to support granular control
enum LogCategory {
  /// Default category for unspecified logs
  general,

  /// Network requests and responses
  network,

  /// JSON parsing and data structure handling
  json,

  /// component registration
  registry,

  /// Theme related logs
  theme,

  /// String/Localization related logs
  string,

  /// Action execution logs
  action,

  /// Widget building and rendering logs
  widget,

  /// Navigation logs
  navigation,

  /// State management logs
  state,
}

/// Settings for a specific log category
class LogCategorySettings {
  final bool enabled;
  final bool truncateEnabled;
  final int maxLength;

  const LogCategorySettings({
    this.enabled = true,
    this.truncateEnabled = false,
    this.maxLength = 100,
  });

  factory LogCategorySettings.fromJson(Map<String, dynamic> json) {
    return LogCategorySettings(
      enabled: json['enabled'] as bool? ?? true,
      truncateEnabled: json['truncateEnabled'] as bool? ?? false,
      maxLength: (json['maxLength'] as num?)?.toInt() ?? 100,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'truncateEnabled': truncateEnabled,
      'maxLength': maxLength,
    };
  }

  LogCategorySettings copyWith({
    bool? enabled,
    bool? truncateEnabled,
    int? maxLength,
  }) {
    return LogCategorySettings(
      enabled: enabled ?? this.enabled,
      truncateEnabled: truncateEnabled ?? this.truncateEnabled,
      maxLength: maxLength ?? this.maxLength,
    );
  }
}
