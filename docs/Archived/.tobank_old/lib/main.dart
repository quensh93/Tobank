import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:universal_html/html.dart' show window;
import 'package:universal_io/io.dart';
import 'package:http/http.dart' as http;

import 'package:device_preview/device_preview.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:protected_data_available_check/protected_data_available_check.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'flutter_gen/gen_l10n/app_localizations.dart';

// Custom imports from your project
import 'controller/dashboard/binding/dashboard_controller_binding.dart';
import 'controller/main/main_controller.dart';
import 'new_structure/core/injection/injection.dart';
import 'new_structure/core/services/developer_panel/developer_panel.dart'
    show developerPanelWrap;
import 'new_structure/core/theme/main_theme.dart';
import 'ui/intro/intro_screen.dart';
import 'ui/launcher/launcher_screen.dart';
import 'util/app_util.dart';
import 'util/application_info_util.dart';
import 'new_structure/core/services/developer_panel/debug_page.dart';
import 'util/constants.dart';
import 'util/file_util.dart';
import 'util/log_util.dart';
import 'util/shared_preferences_util.dart';
import 'util/storage_util.dart';
import 'util/theme/theme_util.dart';
import 'util/web_only_utils/url_listener_service.dart';

/// todo: add later to pwa
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AppUtil.printResponse('Handling a background message: ${message.messageId}');
}

Future<MainController> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Remove '#' from URLs by using PathUrlStrategy
  usePathUrlStrategy();
  // Check and save URL before the app starts
  UrlService.checkAndSaveToken();
  //
  //disableRightClick();
  //
  await configureInjection();
  await _checkProtectedData();
  await _initSharedPreferencesManager();
  await Future.wait([
    _initFlutterDownloader(),
    _initFirebase(),
    _initGetStorage(),
    _initStorageUtil(),
    _initFastCachedImageConfig(),
    _initApplicationInfoManager(),
    _initFileManager(),
  ]);
  Get.put(ApiLogService(), permanent: true);
  return _initMainController();
}

void main() async {
  //final result = await runApiCallInIsolate(mobile: '09162363723');
  //print('Status: ${result['statusCode']}');
  //print('Body: ${result['body']}');

  //sendOtp();

  //
  runZonedGuarded<Future<void>>(() async {
    // Initialize Flutter bindings inside the zone
    await WidgetsFlutterBinding.ensureInitialized();
    await _initializeApp();

    final mainController = await _initMainController();

    // Set path strategy for web
    //setPathUrlStrategy();

    // Configure error display
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An error occurred'),
        ),
        body: Center(
          child: Text(details.toString()),
        ),
      );
    };

    const bool isEnabledDevicePreview = false;
    const String optionsDSN = kIsWeb
        ? 'https://0dadf3dbde15d9db8c1b24613bdbfcb7@sentry.tobank.ir/4'
        : (kReleaseMode
            ? 'https://1867796f5d19d9e894aecbbdc40f8690@sentry.tobank.ir/2'
            : 'https://2cff9b186743894762638b93f581da93@sentry.tobank.ir/3');

    await SentryFlutter.init(
      (options) {
        /*options.anrEnabled = true;
        options.attachScreenshot = true;
        options.autoAppStart = true;
        options.enableAppHangTracking = true;
        options.profilesSampleRate = 1;
        options.screenshotQuality = SentryScreenshotQuality.low;
        options.captureFailedRequests = true;
        options.compressPayload = true;
        options.sampleRate = 1;
        options.sendDefaultPii = true;
        options.tracesSampleRate = 1.0;
        options.recordHttpBreadcrumbs = true;
        options.enableUserInteractionBreadcrumbs = false;
        options.enableBrightnessChangeBreadcrumbs = false;
        options.enableAutoNativeBreadcrumbs = false;
        options.reportPackages = false;
        options.debug = false;
        options.enableAutoPerformanceTracing = true;
        options.profilesSampleRate = 1;*/
        options.dsn = optionsDSN;
      },
      /*appRunner: () => runApp(
        SentryScreenshotWidget(
          child: DevicePreview(
            enabled: !kReleaseMode,
            builder: (context) => MyApp(
              mainController: mainController,
            ),
          ),
        ),
      ),*/
    );

    runApp(
      SentryScreenshotWidget(
        child: DevicePreview(
          enabled: false,
          builder: (context) => MyApp(
            mainController: mainController,
          ),
        ),
      ),
    );

    _setSentryScope(mainController);
  }, (Object error, StackTrace stack) {
    debugPrint(error.toString());
    Sentry.captureException(error, stackTrace: stack);
  });
}

void _setSentryScope(MainController mainController) {
  Timer(Constants.duration300, () {
    mainController.setSentryScope();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({required this.mainController, super.key});

  final MainController mainController;

  Widget _getInitialScreen({
    required bool isDebugPageActive,
    MainController? mainController,
  }) {
    // Normal logic from your code:
    return Directionality(
      textDirection: TextDirection.rtl,
      child: (mainController?.isIntroSeen != null ||
              mainController?.authInfoData != null)
          ? const LauncherScreen()
          : const IntroScreen(),
    );
  }

  // Select custom theme based on StorageUtil or system brightness
  AppMainTheme _getAppTheme(BuildContext context) {
    final themeCode = StorageUtil.getThemeCode();
    if (themeCode == 'dark') {
      return AppMainTheme.dark();
    } else if (themeCode == 'light') {
      return AppMainTheme.light();
    } else {
      // System mode
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark
          ? AppMainTheme.dark()
          : AppMainTheme.light();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    /**
     * this need to dismiss keyboard on ios when tape outside of it
     */

    return MainTheme(
      theme: _getAppTheme(context),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          AppUtil.hideKeyboard(context);
        },
        child: OverlaySupport.global(
          child: GetMaterialApp(
            initialBinding: DashboardBinding(),
            builder: (context, Widget? child) {
              final MediaQueryData data = MediaQuery.of(context);
              return developerPanelWrap(
                child: MediaQuery(
                  data: data.copyWith(textScaler: const TextScaler.linear(1)),
                  child: child!,
                ),
              );
            },
            initialRoute: '/',
            title: 'TOBANK',
            theme: ThemeUtil.theme(),
            darkTheme: ThemeUtil.darkTheme(),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode: StorageUtil.getThemeCode() == null ||
                    StorageUtil.getThemeCode() == 'system'
                ? ThemeMode.system
                : StorageUtil.getThemeCode() == 'dark'
                    ? ThemeMode.dark
                    : ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: _getInitialScreen(
                  mainController: mainController,
                  isDebugPageActive: kDebugMode),
            ),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

Future<void> _checkProtectedData() async {
  if (Platform.isIOS && !kIsWeb) {
    await ProtectedDataAvailableCheck.checkProtectedDataReady;
  }
}

Future<void> _initSharedPreferencesManager() async {
  await SharedPreferencesUtil().init();
}

Future<void> _initFlutterDownloader() async {
  /// todo: add later to pwa (flutter downloader)
  if (!kIsWeb) {
    await FlutterDownloader.initialize(debug: true);
    FlutterDownloader.cancelAll();
  }
}

/// todo: add later to pwa
Future<void> _initFirebase() async {
  if (kIsWeb) return;
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _initGetStorage() async {
  await GetStorage.init();
}

Future<void> _initStorageUtil() async {
  await StorageUtil.initSecureStorage();
}

Future<void> _initFastCachedImageConfig() async {
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 30));
}

Future<void> _initApplicationInfoManager() async {
  await ApplicationInfoUtil().init();
}

Future<void> _initFileManager() async {
  await FileUtil().init();
}

void disableRightClick() {
  if(kReleaseMode){
    window.document.onContextMenu.listen((event) => event.preventDefault());
  }
}

Future<MainController> _initMainController() async {
  final mainController = Get.put(MainController());
  await mainController.init();
  return mainController;
}

class HideUrlPathObserver extends NavigatorObserver {
  void _hideUrlPath() {
    if (kIsWeb) {
      // Only run on web!
      // Replace the URL to root
      window.history.replaceState(null, '', '/');
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _hideUrlPath();
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _hideUrlPath();
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _hideUrlPath();
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
