import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ispect/ispect.dart';
import '../../debug_panel/state/debug_panel_settings_state.dart';

/// ISpect configuration for conditional initialization
/// 
/// ISpect should only be enabled in development/staging builds using
/// dart-define flags. In production, all ISpect code is tree-shaken out.
class ISpectConfig {
  /// Enable ISpect with dart-define flag
  /// 
  /// Usage: flutter run --dart-define=ENABLE_ISPECT=true
  static const bool isEnabled = bool.fromEnvironment(
    'ENABLE_ISPECT',
    defaultValue: false, // Disabled by default for safety
  );

  /// Environment configuration
  /// 
  /// Usage: flutter run --dart-define=ENVIRONMENT=development
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  /// Should initialize ISpect
  /// 
  /// Only enable in development/staging, never in production
  /// 
  /// AUTO-ENABLES IN DEBUG MODE for convenience unless explicitly disabled!
  /// To disable: flutter run --dart-define=ENABLE_ISPECT=false
  static bool get shouldInitialize {
    // Check if the flag was explicitly set in environment
    const bool wasFlagSet = bool.hasEnvironment('ENABLE_ISPECT');
    
    if (kDebugMode) {
      // In debug mode: auto-enable for convenience
      if (!wasFlagSet) {
        // Flag not set: enable by default in debug mode
        return true;
      }
      // Flag was set: use its value
      return isEnabled;
    }
    
    // In release mode, only enable if explicitly set AND not production
    return isEnabled && environment != 'production';
  }

  /// Check if ISpect is enabled and should be initialized
  static bool get enabled => shouldInitialize;
}

/// Provider to share the ISpectNavigatorObserver instance
/// This ensures all parts of the app use the same observer instance
/// that's tracking navigation in MaterialApp.navigatorObservers
final ispectNavigatorObserverProvider = Provider<ISpectNavigatorObserver?>((ref) {
  if (!ISpectConfig.shouldInitialize) {
    return null;
  }
  return ISpectNavigatorObserver(
    isLogModals: true,
    isLogPages: true,
    isLogGestures: false,
    isLogOtherTypes: true,
  );
});

/// Provider for ISpect panel buttons with custom debug panel toggle
final ispectPanelButtonsProvider = Provider<List<DraggablePanelButtonItem>>((ref) {
  // Access debug panel settings
  final settings = ref.watch(debugPanelSettingsProvider);
  final controller = ref.read(debugPanelSettingsProvider.notifier);
  
  return [
    // Custom debug panel toggle button with icon + label
    DraggablePanelButtonItem(
      icon: settings.debugPanelEnabled ? Icons.bug_report : Icons.bug_report_outlined,
      label: settings.debugPanelEnabled ? 'ON' : 'OFF',
      description: settings.debugPanelEnabled ? 'Debug Panel: ON - Tap to hide' : 'Debug Panel: OFF - Tap to show',
      onTap: (_) {
        controller.setDebugPanelEnabled(!settings.debugPanelEnabled);
      },
    ),
  ];
});

