import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ISpect imports - will be tree-shaken if not used
import 'package:ispect/ispect.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:stac/stac.dart';

import '../design_system/app_theme.dart';
import '../helpers/logger.dart';
import '../config/ispect_config.dart';
import '../config/debug_panel_config.dart';
import '../../debug_panel/debug_panel_widget.dart';
import '../../debug_panel/state/debug_panel_settings_state.dart';
import '../../features/pre_launch/presentation/screens/pre_launch_screen.dart';
import '../../features/pre_launch/providers/theme_controller_provider.dart';
import '../../features/tobank_mock_new/data/theme/tobank_theme_loader.dart';
import '../stac/loaders/tobank/tobank_colors_loader.dart';
import '../stac/loaders/tobank/tobank_version_loader.dart';

// Test Pages for Routing
import '../../dummy/stac_test_page.dart';
import '../../dummy/simple_api_test_page.dart';
import '../../dummy/news_api_test_page.dart';
import '../../features/tobank_mock_new/presentation/screens/tobank_stac_dart_screen.dart';

class AppRoot extends ConsumerStatefulWidget {
  const AppRoot({super.key, this.useDevicePreview});

  final bool? useDevicePreview; // if null, auto from kDebugMode

  // Global key for the main app's Navigator - allows debug panel to navigate the main app
  static final GlobalKey<NavigatorState> mainAppNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  ConsumerState<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends ConsumerState<AppRoot> {
  StacTheme? _lightTheme;
  StacTheme? _darkTheme;
  bool _themesLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadThemes();
  }

  Future<void> _loadThemes() async {
    try {
      AppLogger.i('Loading Tobank STAC themes...');
      final lightTheme = await TobankThemeLoader.loadLightTheme();
      final darkTheme = await TobankThemeLoader.loadDarkTheme();

      // Load app version for splash screen
      await TobankVersionLoader.loadVersion();

      if (mounted) {
        setState(() {
          _lightTheme = lightTheme;
          _darkTheme = darkTheme;
          _themesLoaded = true;
        });
        AppLogger.i('✅ Tobank STAC themes loaded successfully');
      }
    } catch (e, stackTrace) {
      AppLogger.e(
        'Failed to load Tobank STAC themes, falling back to MaterialApp',
        e,
        stackTrace,
      );
      if (mounted) {
        setState(() {
          _themesLoaded = true; // Still set to true to show fallback
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeWidget = const PreLaunchScreen();

    // Get the shared observer instance from provider
    // This observer is created once and shared across the app
    final observer = ref.watch(ispectNavigatorObserverProvider);

    // Get debug panel enabled state from settings
    final settings = ref.watch(debugPanelSettingsProvider);

    // Get custom panel buttons for ISpect draggable panel
    final panelButtons = ref.watch(ispectPanelButtonsProvider);

    // Watch theme controller for theme mode changes
    final themeAsync = ref.watch(themeControllerProvider);
    final themeMode = themeAsync.value ?? ThemeMode.system;

    // Keep STAC color aliases in sync with the active theme mode
    ref.listen<AsyncValue<ThemeMode>>(themeControllerProvider, (
      previous,
      next,
    ) {
      final mode = next.value;
      if (mode != null) {
        _syncColorsWithTheme(mode);
      }
    });

    // Ensure appColors.current.* matches the active theme when initial value resolves
    if (themeAsync.hasValue) {
      _syncColorsWithTheme(themeMode);
    }

    // Show loading indicator while themes are loading
    if (!_themesLoaded) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    // Use StacApp if themes loaded successfully, otherwise fallback to MaterialApp
    final app = _lightTheme != null && _darkTheme != null
        ? StacApp(
            navigatorKey: AppRoot.mainAppNavigatorKey,
            debugShowCheckedModeBanner: false,
            theme: _lightTheme!,
            darkTheme: _darkTheme!,
            themeMode: themeMode,
            localizationsDelegates: [
              ...ISpectLocalization.localizationDelegates,
              // Persian date picker localizations
              PersianMaterialLocalizations.delegate,
              PersianCupertinoLocalizations.delegate,
              // Flutter default localizations
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              ...ISpectLocalization.supportedLocales,
              const Locale('fa', 'IR'), // Persian (Farsi) - for date picker
            ],
            // Don't set default locale to fa_IR - let ISpect use its default
            // Persian localization will be used by the date picker when needed
            homeBuilder: (context) => homeWidget,
            showPerformanceOverlay: false,
            showSemanticsDebugger: false,
            debugShowMaterialGrid: false,
            navigatorObservers: observer != null ? [observer] : [],
            routes: {
              '/stac-test': (context) => const StacTestPage(),
              '/simple-api-test': (context) => const SimpleApiTestPage(),
              '/network-layer-test': (context) => const NetworkLayerTestPage(),
              '/tobank-stac-dart': (context) => const TobankStacDartScreen(),
            },
            builder: (context, child) {
              // ISpect should work independently of debug panel
              // It wraps the actual app content, not the debug panel
              if (observer != null) {
                try {
                  // CRITICAL: Use the SAME observer instance created above
                  // According to ISpect docs, observer must be in ISpectOptions
                  // and the same instance used in navigatorObservers for navigation to work
                  final isEnabled = settings.ispectDraggablePanelEnabled;

                  // Log the current state to verify changes are being detected
                  debugPrint(
                    '🔧 ISpectBuilder building - isISpectEnabled: $isEnabled',
                  );
                  AppLogger.d(
                    '🔧 ISpectBuilder building - isISpectEnabled: $isEnabled',
                  );

                  final ispectBuilder = ISpectBuilder(
                    // Use a key based on enabled state to force rebuild when setting changes
                    key: ValueKey('ispect_builder_$isEnabled'),
                    isISpectEnabled:
                        isEnabled, // Control ISpect panel visibility via settings
                    options: ISpectOptions(
                      observer: observer, // Must match navigatorObservers above
                      locale: const Locale('en'),
                      panelButtons:
                          panelButtons, // Add custom debug panel toggle button with ON/OFF label
                    ),
                    child: child ?? const SizedBox.shrink(),
                  );

                  // Debug: Log ISpectBuilder creation
                  debugPrint(
                    '✅ ISpectBuilder created with isISpectEnabled: $isEnabled',
                  );
                  AppLogger.d(
                    '✅ ISpectBuilder created with isISpectEnabled: $isEnabled',
                  );

                  return ispectBuilder;
                } catch (e, stackTrace) {
                  // Log error and fallback
                  debugPrint('❌ ISpectBuilder error: $e');
                  debugPrint('Stack: $stackTrace');
                  AppLogger.e('❌ ISpectBuilder error: $e', stackTrace);
                  return child ?? const SizedBox.shrink();
                }
              }
              debugPrint('ℹ️ ISpect disabled in builder - panel will not show');
              AppLogger.d('ℹ️ ISpect disabled in builder - observer is null');
              return child ?? const SizedBox.shrink();
            },
          )
        : MaterialApp(
            navigatorKey: AppRoot.mainAppNavigatorKey,
            debugShowCheckedModeBanner: false,
            theme: buildTheme(brightness: Brightness.light),
            darkTheme: buildTheme(brightness: Brightness.dark),
            themeMode: themeMode,
            localizationsDelegates: [
              ...ISpectLocalization.localizationDelegates,
              // Persian date picker localizations
              PersianMaterialLocalizations.delegate,
              PersianCupertinoLocalizations.delegate,
              // Flutter default localizations
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              ...ISpectLocalization.supportedLocales,
              const Locale('fa', 'IR'), // Persian (Farsi) - for date picker
            ],
            // Don't set default locale to fa_IR - let ISpect use its default
            // Persian localization will be used by the date picker when needed
            home: homeWidget,
            showPerformanceOverlay: false,
            showSemanticsDebugger: false,
            debugShowMaterialGrid: false,
            navigatorObservers: observer != null ? [observer] : [],
            routes: {
              '/stac-test': (context) => const StacTestPage(),
              '/simple-api-test': (context) => const SimpleApiTestPage(),
              '/network-layer-test': (context) => const NetworkLayerTestPage(),
              '/tobank-stac-dart': (context) => const TobankStacDartScreen(),
            },
            builder: (context, child) {
              // ISpect should work independently of debug panel
              // It wraps the actual app content, not the debug panel
              if (observer != null) {
                try {
                  // CRITICAL: Use the SAME observer instance created above
                  // According to ISpect docs, observer must be in ISpectOptions
                  // and the same instance used in navigatorObservers for navigation to work
                  final isEnabled = settings.ispectDraggablePanelEnabled;

                  // Log the current state to verify changes are being detected
                  debugPrint(
                    '🔧 ISpectBuilder building - isISpectEnabled: $isEnabled',
                  );
                  AppLogger.d(
                    '🔧 ISpectBuilder building - isISpectEnabled: $isEnabled',
                  );

                  final ispectBuilder = ISpectBuilder(
                    // Use a key based on enabled state to force rebuild when setting changes
                    key: ValueKey('ispect_builder_$isEnabled'),
                    isISpectEnabled:
                        isEnabled, // Control ISpect panel visibility via settings
                    options: ISpectOptions(
                      observer: observer, // Must match navigatorObservers above
                      locale: const Locale('en'),
                      panelButtons:
                          panelButtons, // Add custom debug panel toggle button with ON/OFF label
                    ),
                    child: child ?? const SizedBox.shrink(),
                  );

                  // Debug: Log ISpectBuilder creation
                  debugPrint(
                    '✅ ISpectBuilder created with isISpectEnabled: $isEnabled',
                  );
                  AppLogger.d(
                    '✅ ISpectBuilder created with isISpectEnabled: $isEnabled',
                  );

                  return ispectBuilder;
                } catch (e, stackTrace) {
                  // Log error and fallback
                  debugPrint('❌ ISpectBuilder error: $e');
                  debugPrint('Stack: $stackTrace');
                  AppLogger.e('❌ ISpectBuilder error: $e', stackTrace);
                  return child ?? const SizedBox.shrink();
                }
              }
              debugPrint('ℹ️ ISpect disabled in builder - panel will not show');
              AppLogger.d('ℹ️ ISpect disabled in builder - observer is null');
              return child ?? const SizedBox.shrink();
            },
          );

    // Wrap app with DebugPanel if flag-based initialization is enabled
    // DebugPanel wraps ISpect, which wraps the app content
    // Hierarchy: DebugPanel > StacApp/MaterialApp (with ISpectBuilder) > App Content
    // Note: DebugPanel.enabled controls visibility, which is managed by persistent settings
    if (DebugPanelConfig.shouldInitializeByFlag) {
      return DebugPanel(
        enabled:
            settings.debugPanelEnabled, // Use persistent setting for visibility
        child: app,
      );
    }

    // If not initialized by flag, return app directly (no DebugPanel wrapper)
    return app;
  }

  void _syncColorsWithTheme(ThemeMode mode) {
    String themeString;
    if (mode == ThemeMode.system) {
      final brightness = MediaQuery.of(context).platformBrightness;
      themeString = brightness == Brightness.dark ? 'dark' : 'light';
    } else {
      themeString = mode == ThemeMode.dark ? 'dark' : 'light';
    }

    if (TobankColorsLoader.isLoaded) {
      TobankColorsLoader.setCurrentTheme(themeString);
    }
  }
}
