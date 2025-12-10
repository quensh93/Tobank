/// Build configuration and utilities
///
/// This file provides utilities for accessing build configuration
/// and environment information at runtime.
library;

import 'package:flutter/foundation.dart';
import 'environment_config.dart';
import 'feature_flags.dart';

/// Build configuration class
class BuildConfig {
  /// Private constructor to prevent instantiation
  BuildConfig._();

  /// Get current environment configuration
  static EnvironmentConfig get environment => EnvironmentConfig.current;

  /// Get current feature flags
  static FeatureFlags get features => FeatureFlags.currentWithOverrides();

  /// Get app name
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'ToBank SDUI',
  );

  /// Get app bundle ID
  static const String bundleId = String.fromEnvironment(
    'BUNDLE_ID',
    defaultValue: 'com.tobank.sdui',
  );

  /// Print build configuration (for debugging)
  static void printConfig() {
    // Use debugPrint instead of print for better performance in release builds
    debugPrint('=== Build Configuration ===');
    debugPrint('App Name: $appName');
    debugPrint('Bundle ID: $bundleId');
    debugPrint('Environment: ${environment.environment.name}');
    debugPrint('API Base URL: ${environment.apiBaseUrl}');
    debugPrint('Supabase URL: ${environment.supabaseUrl ?? "N/A"}');
    debugPrint('Debug Features: ${environment.enableDebugFeatures}');
    debugPrint('Log Level: ${environment.logLevel}');
    debugPrint('');
    debugPrint('=== Feature Flags ===');
    debugPrint('Debug Panel: ${features.isDebugPanelEnabled}');
    debugPrint('Playground: ${features.isPlaygroundEnabled}');
    debugPrint('Visual Editor: ${features.isVisualEditorEnabled}');
    debugPrint('STAC Logs: ${features.isStacLogsEnabled}');
    debugPrint('Mock API: ${features.isMockApiEnabled}');
    debugPrint('Supabase API: ${features.isSupabaseApiEnabled}');
    debugPrint('Custom API: ${features.isCustomApiEnabled}');
    debugPrint('Analytics: ${features.isAnalyticsEnabled}');
    debugPrint('Crash Reporting: ${features.isCrashReportingEnabled}');
    debugPrint('===========================');
  }
}
