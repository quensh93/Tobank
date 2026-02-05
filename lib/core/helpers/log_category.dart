// Re-export LogConfig for convenience
export 'log_config.dart';

/// Category of the log message to support granular control
/// 
/// Categories are organized hierarchically:
/// - General categories (general, network, json, etc.)
/// - STAC-specific categories (stacNavigation, stacWidget, stacRegistry, etc.)
enum LogCategory {
  /// Default category for unspecified logs
  general,

  /// Network requests and responses (cURL, responses)
  network,

  /// JSON parsing and data structure handling
  json,

  /// Component registration (non-STAC)
  registry,

  /// Theme related logs
  theme,

  /// String/Localization related logs
  string,

  /// Action execution logs (non-STAC)
  action,

  /// Widget building and rendering logs (non-STAC)
  widget,

  /// Navigation logs (non-STAC)
  navigation,

  /// State management logs (non-STAC)
  state,

  // ═══════════════════════════════════════════════════════════════════════════
  // STAC-SPECIFIC CATEGORIES (for granular control)
  // ═══════════════════════════════════════════════════════════════════════════

  /// STAC Navigation (getModel, assetPath resolution, screen loading)
  stacNavigation,

  /// STAC Widget parsing and building (CustomImageParser, etc.)
  stacWidget,

  /// STAC Registry changes (setValue, getValue, rebuilds)
  stacRegistry,

  /// STAC Actions (CustomSetValueAction, networkRequest, etc.)
  stacAction,

  /// STAC Theme (ThemeReactiveStacWidget, StacThemeWrapper)
  stacTheme,

  /// STAC Mock interceptor (mock file loading, fallback to real)
  stacMock,

  /// STAC Variable resolution (template substitution)
  stacVariable,
}

/// Settings for a specific log category
class LogCategorySettings {
  final bool enabled;
  final bool truncateEnabled;
  final int maxLength;
  /// If true, this setting was hardcoded and cannot be changed from UI
  final bool isHardcoded;

  const LogCategorySettings({
    this.enabled = true,
    this.truncateEnabled = false,
    this.maxLength = 100,
    this.isHardcoded = false,
  });

  factory LogCategorySettings.fromJson(Map<String, dynamic> json) {
    return LogCategorySettings(
      enabled: json['enabled'] as bool? ?? true,
      truncateEnabled: json['truncateEnabled'] as bool? ?? false,
      maxLength: (json['maxLength'] as num?)?.toInt() ?? 100,
      isHardcoded: json['isHardcoded'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'truncateEnabled': truncateEnabled,
      'maxLength': maxLength,
      'isHardcoded': isHardcoded,
    };
  }

  LogCategorySettings copyWith({
    bool? enabled,
    bool? truncateEnabled,
    int? maxLength,
    bool? isHardcoded,
  }) {
    return LogCategorySettings(
      enabled: enabled ?? this.enabled,
      truncateEnabled: truncateEnabled ?? this.truncateEnabled,
      maxLength: maxLength ?? this.maxLength,
      isHardcoded: isHardcoded ?? this.isHardcoded,
    );
  }
}
