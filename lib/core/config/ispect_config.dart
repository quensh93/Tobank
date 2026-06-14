import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ispect/ispect.dart';
import '../bootstrap/app_root.dart';
import '../helpers/logger.dart';
import '../../debug_panel/state/debug_panel_settings_state.dart';
import '../../debug_panel/state/device_preview_state.dart';
import '../../debug_panel/widgets/custom_logs/screens/logs_screen.dart';
import '../../stac_core/services/theme/theme_controller_provider.dart';

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
final ispectNavigatorObserverProvider =
    Provider<ConsoleLoggingNavigatorObserver?>((ref) {
      if (!ISpectConfig.shouldInitialize) {
        return null;
      }
      // Wrap ISpect's observer with our console-logging observer
      final ispectObserver = ISpectNavigatorObserver(
        isLogModals: true,
        isLogPages: true,
        isLogGestures: false,
        isLogOtherTypes: true,
      );
      return ConsoleLoggingNavigatorObserver(ispectObserver);
    });

/// A NavigatorObserver that logs navigation events to console.
/// ISpect's observer is added separately to navigatorObservers list.
class ConsoleLoggingNavigatorObserver extends NavigatorObserver {
  final ISpectNavigatorObserver _ispectObserver;

  ConsoleLoggingNavigatorObserver(this._ispectObserver);

  // Expose ISpect observer so it can be added to navigatorObservers
  ISpectNavigatorObserver get ispectObserver => _ispectObserver;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}
}

/// Provider for ISpect panel buttons with custom debug panel toggle
final ispectPanelButtonsProvider = Provider<List<DraggablePanelButtonItem>>((
  ref,
) {
  return [];
});

/// Provider for ISpect panel grid items (small icons)
final ispectPanelItemsProvider = Provider<List<DraggablePanelItem>>((ref) {
  // Watch theme controller for current theme
  final themeAsync = ref.watch(themeControllerProvider);
  final themeMode = themeAsync.maybeWhen(
    data: (mode) => mode,
    orElse: () => ThemeMode.system,
  );
  final themeController = ref.read(themeControllerProvider.notifier);

  return [
    // Custom Logs Screen - Opens our custom LogsScreen with all Debug Panel settings
    DraggablePanelItem(
      icon: Icons.bug_report,
      enableBadge: false,
      description: 'Logs',
      onTap: (context) {
        final observer = ref.read(ispectNavigatorObserverProvider);
        // Use main app navigator key since draggable panel context has no Navigator
        AppRoot.mainAppNavigatorKey.currentState?.push(
          MaterialPageRoute(
            settings: const RouteSettings(name: 'Custom Logs Screen'),
            builder: (ctx) => _CustomLogsPage(observer: observer),
          ),
        );
      },
    ),

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

              final deviceState = consumerRef.watch(devicePreviewProvider);
              final deviceController = consumerRef.read(
                devicePreviewProvider.notifier,
              );

              return Container(
                padding: const EdgeInsets.only(bottom: 16),
                child: SingleChildScrollView(
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
                      // Device Preview Toggle
                      ListTile(
                        leading: Icon(
                          deviceState.isPreviewEnabled
                              ? Icons.phone_android
                              : Icons.phone_android_outlined,
                          color: deviceState.isPreviewEnabled
                              ? Colors.blue
                              : null,
                        ),
                        title: const Text('Device Preview'),
                        subtitle: Text(
                          deviceState.isPreviewEnabled ? 'On' : 'Off',
                        ),
                        trailing: Switch(
                          value: deviceState.isPreviewEnabled,
                          onChanged: (value) {
                            deviceController.setPreviewEnabled(value);
                            if (value && !currentSettings.debugPanelEnabled) {
                              currentController.setDebugPanelEnabled(true);
                              currentController.setAreToolsVisible(false);
                            }
                          },
                        ),
                      ),

                      // Draggable Panel (Bottom Sheet) Toggle
                      ListTile(
                        leading: Icon(
                          currentSettings.areToolsVisible
                              ? Icons.vertical_align_bottom
                              : Icons.vertical_align_bottom_sharp, // Variant
                          color: currentSettings.areToolsVisible
                              ? Colors.orange
                              : null,
                        ),
                        title: const Text('Draggable Panel'),
                        subtitle: Text(
                          currentSettings.areToolsVisible
                              ? 'Visible'
                              : 'Hidden',
                        ),
                        trailing: Switch(
                          value: currentSettings.areToolsVisible,
                          onChanged: (value) {
                            currentController.setAreToolsVisible(value);
                            if (value && !currentSettings.debugPanelEnabled) {
                              currentController.setDebugPanelEnabled(true);
                            }
                          },
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
                            currentController.setDebugPanelEnabled(value);
                            if (value) {
                              currentController.setAreToolsVisible(true);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    ),
  ];
});

/// Custom Logs Page that wraps our LogsScreen with ISpect context
/// This is opened from the ISpect draggable panel's "Logs" button
class _CustomLogsPage extends StatelessWidget {
  const _CustomLogsPage({required this.observer});

  final ConsoleLoggingNavigatorObserver? observer;

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('en'),
      delegates: ISpectLocalizations.delegates(),
      child: ISpectBuilder(
        isISpectEnabled: false, // No nested draggable panel
        options: ISpectOptions(
          observer: observer?.ispectObserver,
          locale: const Locale('en'),
        ),
        child: ScaffoldMessenger(
          child: Builder(
            builder: (builderContext) {
              try {
                final ispectScope = ISpect.read(builderContext);
                return LogsScreen(
                  options: ispectScope.options,
                  appBarTitle: 'Custom Logs',
                );
              } catch (e) {
                // Fallback if ISpect context not available
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Logs Error'),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  body: Center(child: Text('Error loading logs: $e')),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
