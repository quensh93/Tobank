import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ispect/ispect.dart';
import '../bootstrap/app_root.dart';
import '../../debug_panel/state/debug_panel_settings_state.dart';
import '../../features/pre_launch/providers/theme_controller_provider.dart';

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
final ispectNavigatorObserverProvider = Provider<ISpectNavigatorObserver?>((
  ref,
) {
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
final ispectPanelButtonsProvider = Provider<List<DraggablePanelButtonItem>>((
  ref,
) {
  return [];
});

/// Provider for ISpect panel grid items (small icons)
final ispectPanelItemsProvider = Provider<List<DraggablePanelItem>>((ref) {
  // Access debug panel settings
  final settings = ref.watch(debugPanelSettingsProvider);
  final controller = ref.read(debugPanelSettingsProvider.notifier);

  // Watch theme controller for current theme
  final themeAsync = ref.watch(themeControllerProvider);
  final themeMode = themeAsync.maybeWhen(
    data: (mode) => mode,
    orElse: () => ThemeMode.system,
  );
  final themeController = ref.read(themeControllerProvider.notifier);

  return [
    // Back Button
    DraggablePanelItem(
      icon: Icons.arrow_back,
      enableBadge: false,
      description: 'Back',
      onTap: (context) {
        AppRoot.mainAppNavigatorKey.currentState?.maybePop();
      },
    ),

    // Theme Toggle
    DraggablePanelItem(
      icon: themeMode == ThemeMode.dark
          ? Icons.dark_mode
          : themeMode == ThemeMode.light
          ? Icons.light_mode
          : Icons.brightness_auto,
      enableBadge: false,
      description: 'Theme',
      onTap: (context) {
        themeController.toggleMode();
      },
    ),

    // Tools
    DraggablePanelItem(
      icon: Icons.tune,
      enableBadge: false,
      description: 'Tools',
      onTap: (_) {
        debugPrint('🔧 Tools button tapped');
        final context = AppRoot.mainAppNavigatorKey.currentContext;
        if (context == null) {
          debugPrint('❌ Context is null, cannot show bottom sheet');
          return;
        }
        debugPrint('✅ Context found, showing bottom sheet');

        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          useSafeArea: true,
          // Use Consumer to get fresh state every time the bottom sheet opens
          builder: (sheetContext) => Consumer(
            builder: (consumerContext, consumerRef, _) {
              debugPrint('🔧 Bottom sheet Consumer building');
              // Read CURRENT state inside Consumer (not stale closure)
              final currentSettings = consumerRef.watch(
                debugPanelSettingsProvider,
              );
              final currentController = consumerRef.read(
                debugPanelSettingsProvider.notifier,
              );

              debugPrint(
                '🔧 Current debugPanelEnabled: ${currentSettings.debugPanelEnabled}',
              );

              return Container(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Debug Tools',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Debug Panel Toggle (Global)
                    ListTile(
                      leading: Icon(
                        currentSettings.debugPanelEnabled
                            ? Icons.power_settings_new
                            : Icons.power_off,
                        color: currentSettings.debugPanelEnabled
                            ? Colors.green
                            : null,
                      ),
                      title: const Text('Debug System'),
                      subtitle: Text(
                        currentSettings.debugPanelEnabled
                            ? 'Enabled'
                            : 'Disabled',
                      ),
                      trailing: Switch(
                        value: currentSettings.debugPanelEnabled,
                        onChanged: (value) {
                          debugPrint('🔧 Switch onChanged: $value');
                          Navigator.pop(sheetContext);
                          currentController.setDebugPanelEnabled(value);
                        },
                      ),
                      onTap: () {
                        debugPrint(
                          '🔧 ListTile onTap: toggling to ${!currentSettings.debugPanelEnabled}',
                        );
                        Navigator.pop(sheetContext);
                        currentController.setDebugPanelEnabled(
                          !currentSettings.debugPanelEnabled,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ),

    // Tools Visibility Toggle (eye icon) - shows/hides debug tools but KEEPS device frame
    // CRITICAL: Read fresh state INSIDE onTap to avoid stale closures
    DraggablePanelItem(
      icon: settings.areToolsVisible ? Icons.visibility : Icons.visibility_off,
      enableBadge: false,
      description: 'Toggle Tools',
      onTap: (context) {
        // Read FRESH state from ProviderScope - don't use captured 'settings'!
        final container = ProviderScope.containerOf(context);
        final currentSettings = container.read(debugPanelSettingsProvider);
        final currentController = container.read(
          debugPanelSettingsProvider.notifier,
        );

        debugPrint(
          '🔧 Tools toggle tapped - current: ${currentSettings.areToolsVisible}',
        );
        currentController.setAreToolsVisible(!currentSettings.areToolsVisible);
      },
    ),
  ];
});
