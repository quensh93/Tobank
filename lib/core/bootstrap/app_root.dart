import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ispect/ispect.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:stac/stac.dart';

import '../../debug_panel/debug_panel_widget.dart';
import '../../debug_panel/state/debug_panel_settings_state.dart';
import '../../dev/screens/pre_launch_screen.dart';
import '../../dev/screens/tobank_stac_dart_screen.dart';
import '../../stac_core/loaders/tobank_assets_loader.dart';
import '../../stac_core/loaders/tobank_colors_loader.dart';
import '../../stac_core/loaders/tobank_theme_loader.dart';
import '../../stac_core/loaders/tobank_version_loader.dart';
import '../../stac_core/parsers/widgets/loader/promissory_real_loader_parser.dart';
import '../../stac_core/config/sdui_config.dart';
import '../../stac_core/services/theme/theme_controller_provider.dart';
import '../config/debug_panel_config.dart';
import '../config/ispect_config.dart';
import '../design_system/app_theme.dart';
import '../helpers/logger.dart';

class AppRoot extends ConsumerStatefulWidget {
  const AppRoot({super.key, this.useDevicePreview});

  final bool? useDevicePreview;

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
      await TobankVersionLoader.loadVersion();

      if (!mounted) return;
      setState(() {
        _lightTheme = lightTheme;
        _darkTheme = darkTheme;
        _themesLoaded = true;
      });
      AppLogger.i('Loaded Tobank STAC themes successfully');
    } catch (e, stackTrace) {
      AppLogger.e(
        'Failed to load Tobank STAC themes, falling back to MaterialApp',
        e,
        stackTrace,
      );
      if (!mounted) return;
      setState(() {
        _themesLoaded = true;
      });
    }
  }

  Widget _wrapWithStableAppBarTheme(BuildContext context, Widget child) {
    final baseTheme = Theme.of(context);
    return Theme(
      data: baseTheme.copyWith(
        appBarTheme: buildStableAppBarTheme(baseTheme.colorScheme),
      ),
      child: child,
    );
  }

  Widget _wrapWithISpect({
    required Widget child,
    required ConsoleLoggingNavigatorObserver? observer,
    required DebugPanelSettingsState settings,
    required List<DraggablePanelItem> panelItems,
    required List<DraggablePanelButtonItem> panelButtons,
  }) {
    if (observer == null) {
      debugPrint('ISpect disabled - observer is null');
      AppLogger.d('ISpect disabled - observer is null');
      return child;
    }

    final isEnabled = settings.ispectDraggablePanelEnabled;

    try {
      // Stable key: do NOT embed isEnabled/debugPanelEnabled. The app renders in
      // two provider scopes (real app + DebugPanel device-frame preview); keying
      // on the toggle value churned the ValueKey, remounting ISpectBuilder every
      // frame and dropping the draggable panel. Stable key = mount once.
      final ispectBuilder = ISpectBuilder(
        key: const ValueKey('ispect_builder'),
        isISpectEnabled: isEnabled,
        options: ISpectOptions(
          observer: observer.ispectObserver,
          locale: const Locale('en'),
          panelItems: panelItems,
          panelButtons: panelButtons,
          actionItems: const [],
          isInspectorEnabled: false,
          isColorPickerEnabled: false,
          isLogPageEnabled: false,
          isPerformanceEnabled: true,
        ),
        child: child,
      );

      return ispectBuilder;
    } catch (e, stackTrace) {
      debugPrint('ISpectBuilder error: $e');
      debugPrint('Stack: $stackTrace');
      AppLogger.e('ISpectBuilder error: $e', stackTrace);
      return child;
    }
  }

  Widget _buildLoadingApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/tobank-stac-dart': (context) => const TobankStacDartScreen(),
      },
      home: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }

  List<LocalizationsDelegate<dynamic>> _localizationDelegates() {
    return [
      ...ISpectLocalization.localizationDelegates,
      PersianMaterialLocalizations.delegate,
      PersianCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }

  List<Locale> _supportedLocales() {
    return [
      ...ISpectLocalization.supportedLocales,
      const Locale('fa', 'IR'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final homeWidget = SduiConfig.startFromApi
        ? const PromissoryRealLoaderScreen()
        : const PreLaunchScreen();

    final observer = ref.watch(ispectNavigatorObserverProvider);
    final settings = ref.watch(debugPanelSettingsProvider);
    final panelItems = ref.watch(ispectPanelItemsProvider);
    final panelButtons = ref.watch(ispectPanelButtonsProvider);
    final themeAsync = ref.watch(themeControllerProvider);
    final themeMode = themeAsync.value ?? ThemeMode.system;

    ref.listen<AsyncValue<ThemeMode>>(themeControllerProvider, (
      previous,
      next,
    ) {
      final mode = next.value;
      if (mode != null) {
        _syncStacThemeAliases(mode);
      }
    });

    if (themeAsync.hasValue) {
      _syncStacThemeAliases(themeMode);
    }

    if (!_themesLoaded) {
      return _buildLoadingApp();
    }

    final navigatorObservers = observer != null
        ? <NavigatorObserver>[observer, observer.ispectObserver]
        : const <NavigatorObserver>[];

    final app = _lightTheme != null && _darkTheme != null
        ? StacApp(
            scrollBehavior: MyScrollBehavior(),
            navigatorKey: AppRoot.mainAppNavigatorKey,
            debugShowCheckedModeBanner: false,
            theme: StacAppTheme.dsl(theme: _lightTheme!),
            darkTheme: StacAppTheme.dsl(theme: _darkTheme!),
            themeMode: themeMode,
            localizationsDelegates: _localizationDelegates(),
            supportedLocales: _supportedLocales(),
            homeBuilder: (context) => homeWidget,
            showPerformanceOverlay: false,
            showSemanticsDebugger: false,
            debugShowMaterialGrid: false,
            navigatorObservers: navigatorObservers,
            routes: {
              '/tobank-stac-dart': (context) => const TobankStacDartScreen(),
            },
            builder: (context, child) => _wrapWithISpect(
              observer: observer,
              settings: settings,
              panelItems: panelItems,
              panelButtons: panelButtons,
              child: _wrapWithStableAppBarTheme(
                context,
                child ?? const SizedBox.shrink(),
              ),
            ),
          )
        : MaterialApp(
            scrollBehavior: MyScrollBehavior(),
            navigatorKey: AppRoot.mainAppNavigatorKey,
            debugShowCheckedModeBanner: false,
            theme: buildTheme(brightness: Brightness.light),
            darkTheme: buildTheme(brightness: Brightness.dark),
            themeMode: themeMode,
            localizationsDelegates: _localizationDelegates(),
            supportedLocales: _supportedLocales(),
            home: homeWidget,
            showPerformanceOverlay: false,
            showSemanticsDebugger: false,
            debugShowMaterialGrid: false,
            navigatorObservers: navigatorObservers,
            routes: {
              '/tobank-stac-dart': (context) => const TobankStacDartScreen(),
            },
            builder: (context, child) => _wrapWithISpect(
              observer: observer,
              settings: settings,
              panelItems: panelItems,
              panelButtons: panelButtons,
              child: _wrapWithStableAppBarTheme(
                context,
                child ?? const SizedBox.shrink(),
              ),
            ),
          );

    final appShell = DebugPanelConfig.shouldInitializeByFlag
        ? DebugPanel(
            // Always mount the widget so the Tools bottom-sheet can toggle
            // debugPanelEnabled back on. Actual visibility is governed by
            // state.debugPanelEnabled inside _DebugPanelState.build().
            enabled: true,
            child: app,
          )
        : app;


    return appShell;
  }

  void _syncStacThemeAliases(ThemeMode mode) {
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
    if (TobankAssetsLoader.isLoaded) {
      TobankAssetsLoader.setCurrentTheme(themeString);
    }
  }
}

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.unknown,
      };
}
