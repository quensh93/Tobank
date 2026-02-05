// ═══════════════════════════════════════════════════════════════════════════════
// LOG CONFIGURATION
// ═══════════════════════════════════════════════════════════════════════════════
//
// This file contains all log category enable/disable settings.
// Edit this file to control which logs appear in the console.
//
// Settings:
//   true  = Always show logs for this category (overrides debug panel)
//   false = Always hide logs for this category (overrides debug panel)
//   null  = Use debug panel setting (user can toggle in app)
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'log_category.dart';

/// Hardcoded log overrides that take precedence over debug panel settings.
/// 
/// Usage:
/// - Set to `true` to force-enable a category
/// - Set to `false` to force-disable a category  
/// - Set to `null` to let debug panel control the setting
class LogConfig {
  // ═══════════════════════════════════════════════════════════════════════════
  // MASTER SWITCH
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Master override - if false, ALL logs are disabled regardless of other settings
  static const bool? masterEnabled = null;

  // ═══════════════════════════════════════════════════════════════════════════
  // GENERAL CATEGORIES
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// General application logs
  static const bool? general = null;
  
  /// Network logs (cURL commands, responses) - RECOMMENDED: true for debugging
  static const bool? network = true;
  
  /// JSON parsing logs
  static const bool? json = null;
  
  /// Registry operations (getValue, setValue)
  static const bool? registry = null;
  
  /// Theme changes
  static const bool? theme = null;
  
  /// String/localization loading
  static const bool? string = null;
  
  /// Generic action logs
  static const bool? action = null;
  
  /// Generic widget logs
  static const bool? widget = null;
  
  /// Generic navigation logs
  static const bool? navigation = null;
  
  /// State management logs
  static const bool? state = null;

  // ═══════════════════════════════════════════════════════════════════════════
  // STAC-SPECIFIC CATEGORIES (Usually noisy - disabled by default)
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// STAC Navigation (CustomNavigateAction logs)
  static const bool? stacNavigation = false;
  
  /// STAC Widget (CustomImageParser and similar widget logs)
  static const bool? stacWidget = false;
  
  /// STAC Registry ("Registry changed, triggering rebuild" logs)
  static const bool? stacRegistry = false;
  
  /// STAC Action (CustomSetValueAction logs)
  /// Set to true for debugging data_payload issues
  static const bool? stacAction = true;  // TEMP: enabled for debugging
  
  /// STAC Theme (ThemeReactiveStacWidget, StacThemeWrapper)
  static const bool? stacTheme = false;
  
  /// STAC Mock interceptor (mock file loading, fallback to real)
  static const bool? stacMock = null;
  
  /// STAC Variable resolution (template substitution)
  static const bool? stacVariable = null;

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER METHOD
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get the hardcoded override for a category (null = use debug panel)
  static bool? getOverride(LogCategory category) {
    switch (category) {
      case LogCategory.general:
        return general;
      case LogCategory.network:
        return network;
      case LogCategory.json:
        return json;
      case LogCategory.registry:
        return registry;
      case LogCategory.theme:
        return theme;
      case LogCategory.string:
        return string;
      case LogCategory.action:
        return action;
      case LogCategory.widget:
        return widget;
      case LogCategory.navigation:
        return navigation;
      case LogCategory.state:
        return state;
      case LogCategory.stacNavigation:
        return stacNavigation;
      case LogCategory.stacWidget:
        return stacWidget;
      case LogCategory.stacRegistry:
        return stacRegistry;
      case LogCategory.stacAction:
        return stacAction;
      case LogCategory.stacTheme:
        return stacTheme;
      case LogCategory.stacMock:
        return stacMock;
      case LogCategory.stacVariable:
        return stacVariable;
    }
  }

  /// Check if a category has a hardcoded override (is locked)
  static bool isHardcoded(LogCategory category) {
    return getOverride(category) != null;
  }
}
