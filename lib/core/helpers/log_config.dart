// ═══════════════════════════════════════════════════════════════════════════════
// LOG CONFIGURATION
// ═══════════════════════════════════════════════════════════════════════════════
//
// This file contains all log category enable/disable settings.
// Edit this file to control which logs appear in the console.
//
// Settings via LogState:
//   LogState.enabled  = Always show logs (overrides debug panel)
//   LogState.disabled = Always hide logs (overrides debug panel)
//   LogState.sync     = Use debug panel setting (user can toggle in app)
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:logger/logger.dart';
import 'log_category.dart';

/// Master control for log behavior
enum MasterLogControl {
  /// Use individual category settings from this file (mix of enabled/disabled/sync)
  manual,

  /// Ignore this file's overrides, use Debug Panel settings for EVERYTHING
  panel,

  /// Force ALL logs ON (use with caution)
  forceEnabled,

  /// Force ALL logs OFF (emergency silence)
  forceDisabled,
}

/// Hardcoded log overrides that take precedence over debug panel settings.
class LogConfig {
  // ═══════════════════════════════════════════════════════════════════════════
  // MASTER SWITCH
  // ═══════════════════════════════════════════════════════════════════════════

  /// Master log control
  /// - manual: Use logic below (mix of hardcoded + sync)
  /// - panel: Force ALL logs to use debug panel settings
  /// - forceEnabled: Force ALL logs ON (use with caution)
  /// - forceDisabled: Force ALL logs OFF (emergency silence)
  static const MasterLogControl masterLogControl = MasterLogControl.manual;

  /// Default Logging Level for STAC internal framework (stac_logger)
  /// Controls which internal logs (from package:stac_logger) are shown.
  /// Level.error is recommended to see critical failures.
  /// Level.off silences everything.
  /// Level.all shows everything (very noisy).
  static const Level stacLoggerLevel = Level.error;

  // ═══════════════════════════════════════════════════════════════════════════
  // TRUNCATION SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Globally enable/disable log truncation
  static const bool truncateLogs = false;

  /// Max characters per log message before truncation
  static const int maxLogLength = 100000;

  // ═══════════════════════════════════════════════════════════════════════════
  // GENERAL CATEGORIES
  // ═══════════════════════════════════════════════════════════════════════════

  /// 🐛 General application logs (very noisy - disabled by default)
  static const LogState general = LogState.disabled;

  /// 🌐 Network logs (cURL commands, responses)
  static const LogState network = LogState.enabled;

  /// 📄 JSON parsing logs
  static const LogState json = LogState.disabled;

  /// 📦 Registry operations (getValue, setValue)
  static const LogState registry = LogState.disabled;

  /// 🎨 Theme changes
  static const LogState theme = LogState.disabled;

  /// 🌍 String/localization loading
  static const LogState string = LogState.disabled;

  /// ⚡ Generic action logs
  static const LogState action = LogState.disabled;

  /// 🧩 Generic widget logs
  static const LogState widget = LogState.disabled;

  /// 🧭 Generic navigation logs
  static const LogState navigation = LogState.enabled;

  /// 💾 State management logs
  static const LogState state = LogState.disabled;

  /// 🦋 Flutter framework logs (debugPrint forwarded logs)
  static const LogState flutter = LogState.enabled;

  // ═══════════════════════════════════════════════════════════════════════════
  // STAC-SPECIFIC CATEGORIES ( Usually noisy - disabled by default )
  // ═══════════════════════════════════════════════════════════════════════════

  /// 🗺️ STAC Navigation (CustomNavigateAction logs)
  static const LogState stacNavigation = LogState.enabled;

  /// 🏗️ STAC Widget (CustomImageParser and similar widget logs)
  static const LogState stacWidget = LogState.disabled;

  /// ♻️ STAC Registry ("Registry changed, triggering rebuild" logs)
  static const LogState stacRegistry = LogState.disabled;

  /// 🎬 STAC Action (CustomSetValueAction logs)
  /// Set to LogState.disabled to silence "is being overridden" warnings if mapped correctly
  static const LogState stacAction = LogState.disabled;

  /// 🎭 STAC Theme (ThemeReactiveStacWidget, StacThemeWrapper)
  static const LogState stacTheme = LogState.disabled;

  /// 🧪 STAC Mock interceptor (mock file loading, CURL for mock API calls)
  static const LogState stacMock = LogState.disabled;

  /// 💲 STAC Variable resolution (template substitution like {{data.data.name}})
  static const LogState stacVariable = LogState.disabled;

  /// 📦 STAC Data (response structure, data_payload, registry storage)
  static const LogState stacData = LogState.disabled;

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get the hardcoded override for a category (null = use debug panel)
  /// Returns bool? for backward compatibility with AppLogger logic
  static bool? getOverride(LogCategory category) {
    // 1. Check master switch first
    switch (masterLogControl) {
      case MasterLogControl.forceDisabled:
        return false;
      case MasterLogControl.forceEnabled:
        return true;
      case MasterLogControl.panel:
        return null; // Always defer to panel
      case MasterLogControl.manual:
        // Continue to check individual categories
        break;
    }

    // 2. Check individual category
    final state = _getState(category);
    switch (state) {
      case LogState.enabled:
        return true;
      case LogState.disabled:
        return false;
      case LogState.sync:
        return null; // Let debug panel decide
    }
  }

  static LogState _getState(LogCategory category) {
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
      case LogCategory.flutter:
        return flutter;
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
      case LogCategory.stacData:
        return stacData;
    }
  }

  /// Check if a category has a hardcoded override (is locked)
  static bool isHardcoded(LogCategory category) {
    if (masterLogControl == MasterLogControl.forceEnabled ||
        masterLogControl == MasterLogControl.forceDisabled) {
      return true;
    }
    if (masterLogControl == MasterLogControl.panel) {
      return false; // All unlocked/synced in panel mode
    }
    // Manual mode: depends on category setting
    return _getState(category) != LogState.sync;
  }
}

/*
 📚 LOG CATEGORY GUIDE (with Emojis)
 ══════════════════════════════════════════════════════════════════════════════
 
 🔹 GENERAL
    • general:       🐛 Default app lifecycle, unclassified logs.
    • network:       🌐 HTTP requests, cURL commands, API headers/responses.
    • json:          📄 Parsing mock data files.
    • registry:      📦 Startup registration (parsers, actions). 
    • theme:         🎨 Color schema loading & caching.
    • string:        🌍 Localization string loading.
    • action:        ⚡ UI actions like FilePicker, Validation.
    • widget:        🧩 Specific widget logic (Splash timers).
    • navigation:    🧭 Flow logic (FlowNextAction).
    • state:         💾 General state management logs.
    • flutter:       🦋 Flutter framework logs (debugPrint forwarded).

 🔸 STAC SPECIFIC (Framework Internals)
    • stacNavigation: 🗺️ CustomNavigateAction (transitions).
    • stacWidget:     🏗️ Internal widget parsing stats.
    • stacRegistry:   ♻️ Registry rebuild triggers (Noisy!).
    • stacAction:     🎬 Data flow (CustomSetValue, NetworkRequest).
    • stacTheme:      🎭 StacThemeWrapper updates.
    • stacMock:       🧪 Mock file interceptor / Fallbacks.
    • stacVariable:   💲 Template resolution ({{data.data.name}} -> value).
    • stacData:       📦 Response payload handling (data_payload, structure).

  /*
     💡 TIPS:
     - Set `masterLogControl = MasterLogControl.forceDisabled` to silence EVERYTHING.
     - Set `masterLogControl = MasterLogControl.panel` to control EVERYTHING via Debug Panel.
     - Set `masterLogControl = MasterLogControl.manual` to use the settings in this file.
  */
 */
