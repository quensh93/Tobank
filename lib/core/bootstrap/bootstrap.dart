import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ISpect imports - will be tree-shaken if not used
import 'package:ispect/ispect.dart';
import 'package:flutter_performance_pulse/flutter_performance_pulse.dart' as pulse;

import '../helpers/logger.dart';
import '../config/ispect_config.dart';
import '../config/debug_panel_config.dart';
import 'app_root.dart';
import 'app_wrappers.dart';
import 'initializer/app_config.dart';
import 'initializer/app_initializer.dart';

Future<void> bootstrap() async {
  try {
    // Initialize Flutter bindings FIRST (must be in main zone)
    WidgetsFlutterBinding.ensureInitialized();
    
    // Handle Flutter errors - log to AppLogger and show in console
    // Only suppress battery PlatformException errors on Windows (expected and harmless)
    FlutterError.onError = (FlutterErrorDetails details) {
      final exceptionString = details.exceptionAsString();
      // Log all errors to AppLogger for debugging
      AppLogger.e(
        'Flutter Error: ${details.exception}',
        details.exception,
        details.stack,
      );
      // Suppress battery PlatformException errors (expected on Windows desktop)
      if (exceptionString.contains('GetSystemPowerStatus')) {
        return; // Don't print battery errors - expected on Windows
      }
      // For all other errors (including overflow), print to console
      FlutterError.presentError(details);
    };
    
    // Present Flutter errors - show in console with proper formatting
    FlutterError.presentError = (FlutterErrorDetails details) {
      final exceptionString = details.exceptionAsString();
      // Suppress battery PlatformException errors (expected on Windows desktop)
      if (exceptionString.contains('GetSystemPowerStatus')) {
        return; // Don't show battery errors - expected on Windows
      }
      // Show all other errors (including overflow) in console
      FlutterError.dumpErrorToConsole(details, forceReport: false);
    };
    
    // Handle PlatformDispatcher errors (catches async PlatformExceptions)
    PlatformDispatcher.instance.onError = (error, stack) {
      final errorString = error.toString();
      // Log all platform errors to AppLogger for debugging
      AppLogger.e(
        'Platform Error: $error',
        error,
        stack,
      );
      // Suppress battery PlatformException errors (expected on Windows desktop)
      if (errorString.contains('GetSystemPowerStatus')) {
        return true; // Suppress battery errors - expected on Windows
      }
      // Let other errors propagate (they will be logged above)
      return false;
    };

    await AppInitializer.initialize();
    await AppConfig.initialize(AppInitializer.prefs);

    AppLogger.i('App starting…');

    // Initialize flutter_performance_pulse if Debug Panel is enabled
    if (DebugPanelConfig.shouldInitializeByFlag) {
      AppLogger.i('🚀 Initializing PerformanceMonitor...');
      await pulse.PerformanceMonitor.instance.initialize(
        config: pulse.MonitorConfig(
          // Performance monitoring options
          showMemory: true,
          showLogs: true,
          trackStartup: true,
          interceptNetwork: false, // Don't conflict with our Dio interceptors
          
          // Performance thresholds
          fpsWarningThreshold: 45,
          memoryWarningThreshold: 500 * 1024 * 1024, // 500MB
          diskWarningThreshold: 85.0,
          
          // Feature toggles
          enableNetworkMonitoring: false, // Don't conflict with our network logging
          enableBatteryMonitoring: false, // Disabled on Windows - causes PlatformException
          enableDeviceInfo: true,
          enableDiskMonitoring: true,
          
          // Logging options
          logLevel: pulse.LogLevel.verbose,
          exportLogs: true,
        ),
      );
      AppLogger.i('✅ PerformanceMonitor initialized');
    }

    // Log ISpect configuration status
    AppLogger.i('🔍 ISpect Config - isEnabled: ${ISpectConfig.isEnabled}, shouldInitialize: ${ISpectConfig.shouldInitialize}, environment: ${ISpectConfig.environment}');

    // Initialize and run with ISpect if enabled, otherwise run normally
    if (ISpectConfig.shouldInitialize) {
      AppLogger.i('🚀 Initializing ISpect...');
      await _initializeAndRunWithISpect();
    } else {
      AppLogger.i('ℹ️ ISpect disabled - running without ISpect panel');
      // Normal runApp without ISpect (tree-shaken in production)
      await _runAppNormal();
    }
  } catch (e) {
    AppLogger.e('Bootstrap error: $e');
    // Fallback error handling if bootstrap fails
    runApp(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('App initialization failed. Please restart the app.'),
          ),
        ),
      ),
    );
  }
}

/// Initialize ISpect and run app with ISpect wrapper
/// This code is only executed when ENABLE_ISPECT flag is true
/// ISpect.run() creates its own zone, but ensureInitialized must be called first
Future<void> _initializeAndRunWithISpect() async {
  try {
    // Initialize ISpect logger using ISpectFlutter extension
    // Configure logger to NOT intercept console prints to avoid infinite loop with our logger
    final logger = ISpectFlutter.init(
      options: ISpectLoggerOptions(
        enabled: true,
        useHistory: true,
        useConsoleLogs: false, // CRITICAL: Disable console interception to prevent stack overflow
        maxHistoryItems: 5000,
        logTruncateLength: 4000,
      ),
    );
    
    // Wrap app with ISpect.run() - this provides the ISpect panel
    // ISpect.run() creates its own zone with runZonedGuarded
    // CRITICAL: isFlutterPrintEnabled: false prevents ISpect from intercepting print() calls
    // which would cause infinite loops with our AppLogger
    ISpect.run(
      () {
        // Build the app widget tree inside ISpect's zone
        final app = ProviderScope(
          child: const _Root(),
        );
        
        // Run app - let Flutter handle errors natively
        runApp(app);
      },
      logger: logger,
      isFlutterPrintEnabled: false, // Disable print interception to prevent stack overflow
      isZoneErrorHandlingEnabled: false, // Disable zone error handling to see Flutter's native errors
      isPrintLoggingEnabled: false, // Disable print logging
      options: const ISpectLogOptions(
        isFlutterPresentHandlingEnabled: false,
        isPlatformDispatcherHandlingEnabled: false,
        isFlutterErrorHandlingEnabled: false,
        isUncaughtErrorsHandlingEnabled: false,
        isBlocHandlingEnabled: false,
      ),
      onInitialized: () {
        // Reinstall our error handlers after ISpect initialization
        FlutterError.onError = (FlutterErrorDetails details) {
          final exceptionString = details.exceptionAsString();
          // Log all errors to AppLogger for debugging
          AppLogger.e(
            'Flutter Error: ${details.exception}',
            details.exception,
            details.stack,
          );
          // Suppress battery PlatformException errors (expected on Windows desktop)
          if (exceptionString.contains('GetSystemPowerStatus')) {
            return; // Don't print battery errors - expected on Windows
          }
          // For all other errors (including overflow), print to console
          FlutterError.presentError(details);
        };
        FlutterError.presentError = (FlutterErrorDetails details) {
          final exceptionString = details.exceptionAsString();
          // Suppress battery PlatformException errors (expected on Windows desktop)
          if (exceptionString.contains('GetSystemPowerStatus')) {
            return; // Don't show battery errors - expected on Windows
          }
          // Show all other errors (including overflow) in console
          FlutterError.dumpErrorToConsole(details, forceReport: false);
        };
      },
    );
  } catch (e, stackTrace) {
    AppLogger.e('❌ Failed to initialize ISpect: $e', stackTrace);
    // Fallback to normal runApp if ISpect initialization fails
    await _runAppNormal();
  }
}

/// Run app normally without ISpect
Future<void> _runAppNormal() async {
  // Build the app widget tree
  final app = ProviderScope(
    child: const _Root(),
  );
  
  // Normal runApp without ISpect (tree-shaken in production)
  runApp(app);
}

class _Root extends ConsumerWidget {
  const _Root();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final app = const AppRoot();

    return AppWrappers(
      child: app,
    );
  }
}
