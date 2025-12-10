/// Feature flags for controlling feature visibility and availability
///
/// This file defines feature flags that can be toggled based on environment
/// or runtime configuration. Feature flags allow for gradual rollout of
/// features and A/B testing.
library;
///
/// Example usage:
/// ```dart
/// if (FeatureFlags.current.isDebugPanelEnabled) {
///   // Show debug panel
/// }
/// ```

import 'environment_config.dart';

/// Feature flags configuration
class FeatureFlags {
  /// Enable debug panel
  final bool isDebugPanelEnabled;

  /// Enable JSON playground
  final bool isPlaygroundEnabled;

  /// Enable visual JSON editor
  final bool isVisualEditorEnabled;

  /// Enable STAC logs tab in debug panel
  final bool isStacLogsEnabled;

  /// Enable performance monitoring
  final bool isPerformanceMonitoringEnabled;

  /// Enable mock API mode
  final bool isMockApiEnabled;

  /// Enable Supabase API mode
  final bool isSupabaseApiEnabled;

  /// Enable custom API mode
  final bool isCustomApiEnabled;

  /// Enable hot reload for mock data
  final bool isHotReloadEnabled;

  /// Enable JSON validation
  final bool isJsonValidationEnabled;

  /// Enable caching
  final bool isCachingEnabled;

  /// Enable offline mode
  final bool isOfflineModeEnabled;

  /// Enable analytics
  final bool isAnalyticsEnabled;

  /// Enable crash reporting
  final bool isCrashReportingEnabled;

  /// Enable experimental features
  final bool isExperimentalFeaturesEnabled;

  /// Enable verbose logging
  final bool isVerboseLoggingEnabled;

  /// Enable network simulation (slow network, offline, etc.)
  final bool isNetworkSimulationEnabled;

  /// Enable Supabase CLI tools
  final bool isSupabaseCliEnabled;

  /// Enable Supabase CRUD interface
  final bool isSupabaseCrudEnabled;

  const FeatureFlags({
    required this.isDebugPanelEnabled,
    required this.isPlaygroundEnabled,
    required this.isVisualEditorEnabled,
    required this.isStacLogsEnabled,
    required this.isPerformanceMonitoringEnabled,
    required this.isMockApiEnabled,
    required this.isSupabaseApiEnabled,
    required this.isCustomApiEnabled,
    required this.isHotReloadEnabled,
    required this.isJsonValidationEnabled,
    required this.isCachingEnabled,
    required this.isOfflineModeEnabled,
    required this.isAnalyticsEnabled,
    required this.isCrashReportingEnabled,
    required this.isExperimentalFeaturesEnabled,
    required this.isVerboseLoggingEnabled,
    required this.isNetworkSimulationEnabled,
    required this.isSupabaseCliEnabled,
    required this.isSupabaseCrudEnabled,
  });

  /// Development feature flags (all features enabled)
  factory FeatureFlags.development() {
    return const FeatureFlags(
      isDebugPanelEnabled: true,
      isPlaygroundEnabled: true,
      isVisualEditorEnabled: true,
      isStacLogsEnabled: true,
      isPerformanceMonitoringEnabled: true,
      isMockApiEnabled: true,
      isSupabaseApiEnabled: true,
      isCustomApiEnabled: true,
      isHotReloadEnabled: true,
      isJsonValidationEnabled: true,
      isCachingEnabled: true,
      isOfflineModeEnabled: true,
      isAnalyticsEnabled: false,
      isCrashReportingEnabled: false,
      isExperimentalFeaturesEnabled: true,
      isVerboseLoggingEnabled: true,
      isNetworkSimulationEnabled: true,
      isSupabaseCliEnabled: true,
      isSupabaseCrudEnabled: true,
    );
  }

  /// Staging feature flags (debug features enabled, production features enabled)
  factory FeatureFlags.staging() {
    return const FeatureFlags(
      isDebugPanelEnabled: true,
      isPlaygroundEnabled: true,
      isVisualEditorEnabled: false,
      isStacLogsEnabled: true,
      isPerformanceMonitoringEnabled: true,
      isMockApiEnabled: false,
      isSupabaseApiEnabled: true,
      isCustomApiEnabled: true,
      isHotReloadEnabled: false,
      isJsonValidationEnabled: true,
      isCachingEnabled: true,
      isOfflineModeEnabled: true,
      isAnalyticsEnabled: true,
      isCrashReportingEnabled: true,
      isExperimentalFeaturesEnabled: false,
      isVerboseLoggingEnabled: false,
      isNetworkSimulationEnabled: false,
      isSupabaseCliEnabled: true,
      isSupabaseCrudEnabled: true,
    );
  }

  /// Production feature flags (only production features enabled)
  factory FeatureFlags.production() {
    return const FeatureFlags(
      isDebugPanelEnabled: false,
      isPlaygroundEnabled: false,
      isVisualEditorEnabled: false,
      isStacLogsEnabled: false,
      isPerformanceMonitoringEnabled: false,
      isMockApiEnabled: false,
      isSupabaseApiEnabled: false,
      isCustomApiEnabled: true,
      isHotReloadEnabled: false,
      isJsonValidationEnabled: true,
      isCachingEnabled: true,
      isOfflineModeEnabled: true,
      isAnalyticsEnabled: true,
      isCrashReportingEnabled: true,
      isExperimentalFeaturesEnabled: false,
      isVerboseLoggingEnabled: false,
      isNetworkSimulationEnabled: false,
      isSupabaseCliEnabled: false,
      isSupabaseCrudEnabled: false,
    );
  }

  /// Get current feature flags based on environment
  static FeatureFlags get current {
    final environment = EnvironmentConfig.current.environment;

    switch (environment) {
      case Environment.development:
        return FeatureFlags.development();
      case Environment.staging:
        return FeatureFlags.staging();
      case Environment.production:
        return FeatureFlags.production();
    }
  }

  /// Get feature flags from dart-define overrides
  ///
  /// This allows individual feature flags to be overridden at build time:
  /// ```bash
  /// flutter run --dart-define=DEBUG_PANEL=true --dart-define=PLAYGROUND=false
  /// ```
  static FeatureFlags currentWithOverrides() {
    final baseFlags = current;

    return FeatureFlags(
      isDebugPanelEnabled: _getBoolFromEnvironment(
        'DEBUG_PANEL',
        baseFlags.isDebugPanelEnabled,
      ),
      isPlaygroundEnabled: _getBoolFromEnvironment(
        'PLAYGROUND',
        baseFlags.isPlaygroundEnabled,
      ),
      isVisualEditorEnabled: _getBoolFromEnvironment(
        'VISUAL_EDITOR',
        baseFlags.isVisualEditorEnabled,
      ),
      isStacLogsEnabled: _getBoolFromEnvironment(
        'STAC_LOGS',
        baseFlags.isStacLogsEnabled,
      ),
      isPerformanceMonitoringEnabled: _getBoolFromEnvironment(
        'PERFORMANCE_MONITORING',
        baseFlags.isPerformanceMonitoringEnabled,
      ),
      isMockApiEnabled: _getBoolFromEnvironment(
        'MOCK_API',
        baseFlags.isMockApiEnabled,
      ),
      isSupabaseApiEnabled: _getBoolFromEnvironment(
        'FIREBASE_API',
        baseFlags.isSupabaseApiEnabled,
      ),
      isCustomApiEnabled: _getBoolFromEnvironment(
        'CUSTOM_API',
        baseFlags.isCustomApiEnabled,
      ),
      isHotReloadEnabled: _getBoolFromEnvironment(
        'HOT_RELOAD',
        baseFlags.isHotReloadEnabled,
      ),
      isJsonValidationEnabled: _getBoolFromEnvironment(
        'JSON_VALIDATION',
        baseFlags.isJsonValidationEnabled,
      ),
      isCachingEnabled: _getBoolFromEnvironment(
        'CACHING',
        baseFlags.isCachingEnabled,
      ),
      isOfflineModeEnabled: _getBoolFromEnvironment(
        'OFFLINE_MODE',
        baseFlags.isOfflineModeEnabled,
      ),
      isAnalyticsEnabled: _getBoolFromEnvironment(
        'ANALYTICS',
        baseFlags.isAnalyticsEnabled,
      ),
      isCrashReportingEnabled: _getBoolFromEnvironment(
        'CRASH_REPORTING',
        baseFlags.isCrashReportingEnabled,
      ),
      isExperimentalFeaturesEnabled: _getBoolFromEnvironment(
        'EXPERIMENTAL_FEATURES',
        baseFlags.isExperimentalFeaturesEnabled,
      ),
      isVerboseLoggingEnabled: _getBoolFromEnvironment(
        'VERBOSE_LOGGING',
        baseFlags.isVerboseLoggingEnabled,
      ),
      isNetworkSimulationEnabled: _getBoolFromEnvironment(
        'NETWORK_SIMULATION',
        baseFlags.isNetworkSimulationEnabled,
      ),
      isSupabaseCliEnabled: _getBoolFromEnvironment(
        'FIREBASE_CLI',
        baseFlags.isSupabaseCliEnabled,
      ),
      isSupabaseCrudEnabled: _getBoolFromEnvironment(
        'FIREBASE_CRUD',
        baseFlags.isSupabaseCrudEnabled,
      ),
    );
  }

  /// Helper method to get boolean from environment with default value
  static bool _getBoolFromEnvironment(String key, bool defaultValue) {
    final actualValue = _getStringFromEnvironment(key);
    if (actualValue.isEmpty) return defaultValue;
    return actualValue.toLowerCase() == 'true';
  }

  /// Helper method to get string from environment
  static String _getStringFromEnvironment(String key) {
    // This will be replaced at compile time with the actual value
    switch (key) {
      case 'DEBUG_PANEL':
        return const String.fromEnvironment('DEBUG_PANEL');
      case 'PLAYGROUND':
        return const String.fromEnvironment('PLAYGROUND');
      case 'VISUAL_EDITOR':
        return const String.fromEnvironment('VISUAL_EDITOR');
      case 'STAC_LOGS':
        return const String.fromEnvironment('STAC_LOGS');
      case 'PERFORMANCE_MONITORING':
        return const String.fromEnvironment('PERFORMANCE_MONITORING');
      case 'MOCK_API':
        return const String.fromEnvironment('MOCK_API');
      case 'FIREBASE_API':
        return const String.fromEnvironment('FIREBASE_API');
      case 'CUSTOM_API':
        return const String.fromEnvironment('CUSTOM_API');
      case 'HOT_RELOAD':
        return const String.fromEnvironment('HOT_RELOAD');
      case 'JSON_VALIDATION':
        return const String.fromEnvironment('JSON_VALIDATION');
      case 'CACHING':
        return const String.fromEnvironment('CACHING');
      case 'OFFLINE_MODE':
        return const String.fromEnvironment('OFFLINE_MODE');
      case 'ANALYTICS':
        return const String.fromEnvironment('ANALYTICS');
      case 'CRASH_REPORTING':
        return const String.fromEnvironment('CRASH_REPORTING');
      case 'EXPERIMENTAL_FEATURES':
        return const String.fromEnvironment('EXPERIMENTAL_FEATURES');
      case 'VERBOSE_LOGGING':
        return const String.fromEnvironment('VERBOSE_LOGGING');
      case 'NETWORK_SIMULATION':
        return const String.fromEnvironment('NETWORK_SIMULATION');
      case 'FIREBASE_CLI':
        return const String.fromEnvironment('FIREBASE_CLI');
      case 'FIREBASE_CRUD':
        return const String.fromEnvironment('FIREBASE_CRUD');
      default:
        return '';
    }
  }

  /// Check if any debug features are enabled
  bool get hasDebugFeaturesEnabled {
    return isDebugPanelEnabled ||
        isPlaygroundEnabled ||
        isVisualEditorEnabled ||
        isStacLogsEnabled ||
        isNetworkSimulationEnabled;
  }

  /// Check if any API modes are enabled
  bool get hasApiModesEnabled {
    return isMockApiEnabled || isSupabaseApiEnabled || isCustomApiEnabled;
  }

  @override
  String toString() {
    return 'FeatureFlags('
        'debugPanel: $isDebugPanelEnabled, '
        'playground: $isPlaygroundEnabled, '
        'visualEditor: $isVisualEditorEnabled, '
        'stacLogs: $isStacLogsEnabled'
        ')';
  }

  /// Copy with method for creating modified feature flags
  FeatureFlags copyWith({
    bool? isDebugPanelEnabled,
    bool? isPlaygroundEnabled,
    bool? isVisualEditorEnabled,
    bool? isStacLogsEnabled,
    bool? isPerformanceMonitoringEnabled,
    bool? isMockApiEnabled,
    bool? isSupabaseApiEnabled,
    bool? isCustomApiEnabled,
    bool? isHotReloadEnabled,
    bool? isJsonValidationEnabled,
    bool? isCachingEnabled,
    bool? isOfflineModeEnabled,
    bool? isAnalyticsEnabled,
    bool? isCrashReportingEnabled,
    bool? isExperimentalFeaturesEnabled,
    bool? isVerboseLoggingEnabled,
    bool? isNetworkSimulationEnabled,
    bool? isSupabaseCliEnabled,
    bool? isSupabaseCrudEnabled,
  }) {
    return FeatureFlags(
      isDebugPanelEnabled: isDebugPanelEnabled ?? this.isDebugPanelEnabled,
      isPlaygroundEnabled: isPlaygroundEnabled ?? this.isPlaygroundEnabled,
      isVisualEditorEnabled:
          isVisualEditorEnabled ?? this.isVisualEditorEnabled,
      isStacLogsEnabled: isStacLogsEnabled ?? this.isStacLogsEnabled,
      isPerformanceMonitoringEnabled: isPerformanceMonitoringEnabled ??
          this.isPerformanceMonitoringEnabled,
      isMockApiEnabled: isMockApiEnabled ?? this.isMockApiEnabled,
      isSupabaseApiEnabled: isSupabaseApiEnabled ?? this.isSupabaseApiEnabled,
      isCustomApiEnabled: isCustomApiEnabled ?? this.isCustomApiEnabled,
      isHotReloadEnabled: isHotReloadEnabled ?? this.isHotReloadEnabled,
      isJsonValidationEnabled:
          isJsonValidationEnabled ?? this.isJsonValidationEnabled,
      isCachingEnabled: isCachingEnabled ?? this.isCachingEnabled,
      isOfflineModeEnabled: isOfflineModeEnabled ?? this.isOfflineModeEnabled,
      isAnalyticsEnabled: isAnalyticsEnabled ?? this.isAnalyticsEnabled,
      isCrashReportingEnabled:
          isCrashReportingEnabled ?? this.isCrashReportingEnabled,
      isExperimentalFeaturesEnabled:
          isExperimentalFeaturesEnabled ?? this.isExperimentalFeaturesEnabled,
      isVerboseLoggingEnabled:
          isVerboseLoggingEnabled ?? this.isVerboseLoggingEnabled,
      isNetworkSimulationEnabled:
          isNetworkSimulationEnabled ?? this.isNetworkSimulationEnabled,
      isSupabaseCliEnabled: isSupabaseCliEnabled ?? this.isSupabaseCliEnabled,
      isSupabaseCrudEnabled:
          isSupabaseCrudEnabled ?? this.isSupabaseCrudEnabled,
    );
  }
}
