import 'package:flutter/foundation.dart';

/// Debug Panel configuration for conditional initialization
/// 
/// Debug Panel can be enabled in development/staging builds using
/// dart-define flags, or from persistent settings.
class DebugPanelConfig {
  /// Enable Debug Panel with dart-define flag
  /// 
  /// Usage: flutter run --dart-define=ENABLE_DEBUG_PANEL=true
  static const bool isEnabledByFlag = bool.fromEnvironment(
    'ENABLE_DEBUG_PANEL',
    defaultValue: false, // Disabled by default for safety
  );

  /// Environment configuration
  /// 
  /// Usage: flutter run --dart-define=ENVIRONMENT=development
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  /// Should initialize Debug Panel based on flags
  /// 
  /// Only enable in development/staging, never in production
  /// 
  /// AUTO-ENABLES IN DEBUG MODE for convenience unless explicitly disabled!
  /// To disable: flutter run --dart-define=ENABLE_DEBUG_PANEL=false
  static bool get shouldInitializeByFlag {
    // Check if the flag was explicitly set in environment
    const bool wasFlagSet = bool.hasEnvironment('ENABLE_DEBUG_PANEL');
    
    if (kDebugMode) {
      // In debug mode: auto-enable for convenience
      if (!wasFlagSet) {
        // Flag not set: enable by default in debug mode
        return true;
      }
      // Flag was set: use its value
      return isEnabledByFlag;
    }
    
    // In release mode, only enable if explicitly set AND not production
    return isEnabledByFlag && environment != 'production';
  }

  /// Check if Debug Panel should be enabled based on flags
  /// Final decision is made by combining flags with persistent settings
  static bool get enabledByFlag => shouldInitializeByFlag;
}

