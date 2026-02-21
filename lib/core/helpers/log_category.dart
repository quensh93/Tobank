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

  /// Flutter framework logs (debugPrint forwarded logs)
  flutter,

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

  /// STAC Variable resolution (template substitution like {{data.data.name}})
  stacVariable,

  /// STAC Data handling (response structure, data_payload, registry storage)
  stacData,
}

extension LogCategoryEmoji on LogCategory {
  String get emoji {
    switch (this) {
      case LogCategory.general:
        return '🐛';
      case LogCategory.network:
        return '🌐';
      case LogCategory.json:
        return '📄';
      case LogCategory.registry:
        return '📦';
      case LogCategory.theme:
        return '🎨';
      case LogCategory.string:
        return '🌍';
      case LogCategory.action:
        return '⚡';
      case LogCategory.widget:
        return '🧩';
      case LogCategory.navigation:
        return '🧭';
      case LogCategory.state:
        return '💾';
      case LogCategory.flutter:
        return '🦋';
      case LogCategory.stacNavigation:
        return '🗺️';
      case LogCategory.stacWidget:
        return '🏗️';
      case LogCategory.stacRegistry:
        return '♻️';
      case LogCategory.stacAction:
        return '🎬';
      case LogCategory.stacTheme:
        return '🎭';
      case LogCategory.stacMock:
        return '🧪';
      case LogCategory.stacVariable:
        return '💲';
      case LogCategory.stacData:
        return '📦';
    }
  }
}

/// Helper enum for easier configuration in log_config.dart
enum LogState {
  /// Always show logs for this category (overrides debug panel)
  enabled,

  /// Always hide logs for this category (overrides debug panel)
  disabled,

  /// Check debug panel settings (user can toggle in app)
  sync,
}

/// Settings for a specific log category
class LogCategorySettings {
  final bool enabled;
  final bool truncateEnabled;
  final bool ispectEnabled; // New field
  final int maxLength;

  /// If true, this setting was hardcoded and cannot be changed from UI
  final bool isHardcoded;

  /// Emoji for the category
  final String? emoji;

  const LogCategorySettings({
    this.enabled = true,
    this.truncateEnabled = true, // Default to true to prevent massive logs
    this.ispectEnabled = true, // Default true
    this.maxLength = 800, // Reasonable default limit
    this.isHardcoded = false,
    this.emoji,
  });

  factory LogCategorySettings.fromJson(Map<String, dynamic> json) {
    return LogCategorySettings(
      enabled: json['enabled'] as bool? ?? true,
      truncateEnabled: json['truncateEnabled'] as bool? ?? true,
      ispectEnabled: json['ispectEnabled'] as bool? ?? true,
      maxLength: (json['maxLength'] as num?)?.toInt() ?? 800,
      isHardcoded: json['isHardcoded'] as bool? ?? false,
      emoji: json['emoji'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'truncateEnabled': truncateEnabled,
      'ispectEnabled': ispectEnabled,
      'maxLength': maxLength,
      'isHardcoded': isHardcoded,
      'emoji': emoji,
    };
  }

  LogCategorySettings copyWith({
    bool? enabled,
    bool? truncateEnabled,
    bool? ispectEnabled,
    int? maxLength,
    bool? isHardcoded,
    String? emoji,
  }) {
    return LogCategorySettings(
      enabled: enabled ?? this.enabled,
      truncateEnabled: truncateEnabled ?? this.truncateEnabled,
      ispectEnabled: ispectEnabled ?? this.ispectEnabled,
      maxLength: maxLength ?? this.maxLength,
      isHardcoded: isHardcoded ?? this.isHardcoded,
      emoji: emoji ?? this.emoji,
    );
  }
}
