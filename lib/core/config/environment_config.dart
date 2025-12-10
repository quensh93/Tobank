/// Environment configuration for the STAC Hybrid App Framework
///
/// This file defines environment-specific configurations for development,
/// staging, and production environments. Use dart-define to select the
/// environment at build time.
library;
///
/// Example:
/// ```bash
/// flutter run --dart-define=ENVIRONMENT=development
/// flutter build apk --dart-define=ENVIRONMENT=production
/// ```

import 'package:flutter/foundation.dart';

/// Environment types
enum Environment {
  development,
  staging,
  production;

  /// Get environment from string
  static Environment fromString(String value) {
    return Environment.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => Environment.development,
    );
  }
}

/// Environment configuration class
class EnvironmentConfig {
  /// Current environment
  final Environment environment;

  /// API base URL
  final String apiBaseUrl;

  /// Supabase project URL
  final String? supabaseUrl;

  /// Supabase anonymous key
  final String? supabaseAnonKey;

  /// Enable debug features
  final bool enableDebugFeatures;

  /// Enable logging
  final bool enableLogging;

  /// Log level (verbose, debug, info, warning, error)
  final String logLevel;

  /// API timeout duration in seconds
  final int apiTimeoutSeconds;

  /// Cache expiry duration in minutes
  final int cacheExpiryMinutes;

  /// Enable analytics
  final bool enableAnalytics;

  /// Enable crash reporting
  final bool enableCrashReporting;

  /// App version
  final String appVersion;

  /// Build number
  final String buildNumber;

  const EnvironmentConfig({
    required this.environment,
    required this.apiBaseUrl,
    this.supabaseUrl,
    this.supabaseAnonKey,
    required this.enableDebugFeatures,
    required this.enableLogging,
    required this.logLevel,
    required this.apiTimeoutSeconds,
    required this.cacheExpiryMinutes,
    required this.enableAnalytics,
    required this.enableCrashReporting,
    required this.appVersion,
    required this.buildNumber,
  });

  /// Development configuration
  factory EnvironmentConfig.development() {
    return const EnvironmentConfig(
      environment: Environment.development,
      apiBaseUrl: 'http://localhost:8080',
      supabaseUrl: 'https://tobank-dev.supabase.co',
      supabaseAnonKey: 'dev-anon-key',
      enableDebugFeatures: true,
      enableLogging: true,
      logLevel: 'debug',
      apiTimeoutSeconds: 30,
      cacheExpiryMinutes: 5,
      enableAnalytics: false,
      enableCrashReporting: false,
      appVersion: '1.0.0',
      buildNumber: 'dev',
    );
  }

  /// Staging configuration
  factory EnvironmentConfig.staging() {
    return const EnvironmentConfig(
      environment: Environment.staging,
      apiBaseUrl: 'https://staging-api.tobank.com',
      supabaseUrl: 'https://tobank-staging.supabase.co',
      supabaseAnonKey: 'staging-anon-key',
      enableDebugFeatures: true,
      enableLogging: true,
      logLevel: 'info',
      apiTimeoutSeconds: 30,
      cacheExpiryMinutes: 10,
      enableAnalytics: true,
      enableCrashReporting: true,
      appVersion: '1.0.0',
      buildNumber: 'staging',
    );
  }

  /// Production configuration
  factory EnvironmentConfig.production() {
    return const EnvironmentConfig(
      environment: Environment.production,
      apiBaseUrl: 'https://api.tobank.com',
      supabaseUrl: 'https://tobank-prod.supabase.co',
      supabaseAnonKey: 'prod-anon-key',
      enableDebugFeatures: false,
      enableLogging: true,
      logLevel: 'error',
      apiTimeoutSeconds: 30,
      cacheExpiryMinutes: 30,
      enableAnalytics: true,
      enableCrashReporting: true,
      appVersion: '1.0.0',
      buildNumber: 'prod',
    );
  }

  /// Get current environment configuration based on dart-define
  static EnvironmentConfig get current {
    const environmentString = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: 'development',
    );

    final environment = Environment.fromString(environmentString);

    switch (environment) {
      case Environment.development:
        return EnvironmentConfig.development();
      case Environment.staging:
        return EnvironmentConfig.staging();
      case Environment.production:
        return EnvironmentConfig.production();
    }
  }

  /// Check if current environment is development
  bool get isDevelopment => environment == Environment.development;

  /// Check if current environment is staging
  bool get isStaging => environment == Environment.staging;

  /// Check if current environment is production
  bool get isProduction => environment == Environment.production;

  /// Check if debug mode is enabled (Flutter debug mode OR debug features enabled)
  bool get isDebugMode => kDebugMode || enableDebugFeatures;

  /// Get cache expiry duration
  Duration get cacheExpiryDuration => Duration(minutes: cacheExpiryMinutes);

  /// Get API timeout duration
  Duration get apiTimeout => Duration(seconds: apiTimeoutSeconds);

  @override
  String toString() {
    return 'EnvironmentConfig('
        'environment: ${environment.name}, '
        'apiBaseUrl: $apiBaseUrl, '
        'enableDebugFeatures: $enableDebugFeatures, '
        'logLevel: $logLevel'
        ')';
  }

  /// Copy with method for creating modified configurations
  EnvironmentConfig copyWith({
    Environment? environment,
    String? apiBaseUrl,
    String? supabaseUrl,
    String? supabaseAnonKey,
    bool? enableDebugFeatures,
    bool? enableLogging,
    String? logLevel,
    int? apiTimeoutSeconds,
    int? cacheExpiryMinutes,
    bool? enableAnalytics,
    bool? enableCrashReporting,
    String? appVersion,
    String? buildNumber,
  }) {
    return EnvironmentConfig(
      environment: environment ?? this.environment,
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      supabaseUrl: supabaseUrl ?? this.supabaseUrl,
      supabaseAnonKey: supabaseAnonKey ?? this.supabaseAnonKey,
      enableDebugFeatures: enableDebugFeatures ?? this.enableDebugFeatures,
      enableLogging: enableLogging ?? this.enableLogging,
      logLevel: logLevel ?? this.logLevel,
      apiTimeoutSeconds: apiTimeoutSeconds ?? this.apiTimeoutSeconds,
      cacheExpiryMinutes: cacheExpiryMinutes ?? this.cacheExpiryMinutes,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      enableCrashReporting: enableCrashReporting ?? this.enableCrashReporting,
      appVersion: appVersion ?? this.appVersion,
      buildNumber: buildNumber ?? this.buildNumber,
    );
  }
}
