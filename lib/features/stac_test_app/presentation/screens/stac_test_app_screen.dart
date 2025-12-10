import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stac/stac.dart';
import '../../../../core/helpers/logger.dart';
import '../providers/stac_test_app_providers.dart';
import '../actions/stac_login_action_parser.dart';
import '../../data/utils/stac_error_handler.dart';
import 'dart:io';

/// STAC Test App Screen
/// 
/// This is the main screen for the STAC test app. It loads the entry point JSON,
/// renders screens based on STAC JSON templates, and handles navigation.
class StacTestAppScreen extends ConsumerStatefulWidget {
  const StacTestAppScreen({super.key});

  @override
  ConsumerState<StacTestAppScreen> createState() => _StacTestAppScreenState();
}

class _StacTestAppScreenState extends ConsumerState<StacTestAppScreen> {
  String? _currentEntryPointPath;
  String? _entryPointDir;

  @override
  void initState() {
    super.initState();
    // Set default entry point path
    _currentEntryPointPath = 'mock/stac_test_app/app_entry_point.json';
    _entryPointDir = 'mock/stac_test_app';
    
    // Register login action parser
    registerLoginActionParser();
    
    // Set up navigation handler for login action
    LoginNavigationHandler.setHandler((screenName) {
      if (mounted) {
        ref.read(currentScreenProvider).setScreen(screenName);
        // Don't invalidate here - let the ListenableBuilder handle the rebuild
        AppLogger.i('🔄 Navigation to screen: $screenName');
      }
    });
  }
  
  @override
  void dispose() {
    // Clear navigation handler
    LoginNavigationHandler.clearHandler();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set entry point in provider after ref is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(currentEntryPointProvider).setEntryPoint(_currentEntryPointPath ?? '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch for entry point changes - use ListenableBuilder to listen to ChangeNotifier
    return ListenableBuilder(
      listenable: Listenable.merge([
        ref.read(currentEntryPointProvider),
        ref.read(currentScreenProvider),
        ref.read(restartTriggerProvider),
        ref.read(hotReloadTriggerProvider),
      ]),
      builder: (context, _) {
        return _buildContent();
      },
    );
  }

  Widget _buildContent() {
    // Get entry point path
    final entryPointNotifier = ref.read(currentEntryPointProvider);
    final entryPointPath = entryPointNotifier.entryPoint ?? _currentEntryPointPath;
    
    // Check for restart trigger
    final restartNotifier = ref.read(restartTriggerProvider);
    if (restartNotifier.trigger > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleRestart();
      });
    }

    // Check for hot reload trigger
    final hotReloadNotifier = ref.read(hotReloadTriggerProvider);
    if (hotReloadNotifier.trigger > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleHotReload();
      });
    }

    // Load entry point config
    final entryPointAsync = ref.watch(
      entryPointConfigProvider(entryPointPath ?? 'mock/stac_test_app/app_entry_point.json'),
    );

    return entryPointAsync.when(
      data: (config) {
        // Get current screen name (use initial screen if not set)
        final screenNotifier = ref.read(currentScreenProvider);
        final currentScreen = screenNotifier.screen ?? config.initialScreen;
        
        // Set initial screen if not already set
        if (screenNotifier.screen == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              screenNotifier.setScreen(config.initialScreen);
            }
          });
        }
        
        // Get screen config
        final screenConfig = config.screens[currentScreen];
        
        if (screenConfig == null) {
          return _buildErrorWidget(
            'Screen "$currentScreen" is not defined in entry point.\n\n'
            'Available screens: ${config.screens.keys.join(", ")}',
          );
        }

        // Get entry point directory for relative path resolution
        // Don't resolve paths here - let StacJsonFileService do it with baseDir
        final entryPointDir = _getEntryPointDirectory(entryPointPath ?? '');

        // Load screen template and data
        // Pass raw paths and let StacJsonFileService resolve them relative to entryPointDir
        return _buildScreenContent(
          screenName: currentScreen,
          templatePath: screenConfig.template,
          dataPath: screenConfig.data,
          entryPointDir: entryPointDir,
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) {
        AppLogger.e('Failed to load entry point', error, stackTrace);
        final userMessage = StacErrorHandler.getUserFriendlyMessage(error);
        return _buildErrorWidget(userMessage);
      },
    );
  }

  /// Build screen content from template and data
  Widget _buildScreenContent({
    required String screenName,
    required String templatePath,
    required String dataPath,
    String? entryPointDir,
  }) {
    final screenAsync = ref.watch(
      screenDataProvider(
        ScreenLoadParams(
          screenName: screenName,
          templatePath: templatePath,
          dataPath: dataPath,
          entryPointDir: entryPointDir ?? _entryPointDir,
        ),
      ),
    );

    return screenAsync.when(
      data: (resolvedTemplate) {
        // Register navigation action handler
        _registerNavigationHandler();

        // Render with STAC
        try {
          final widget = Stac.fromJson(resolvedTemplate, context);
          if (widget == null) {
            return _buildErrorWidget(
              'Failed to render screen "$screenName": STAC returned null widget.\n\n'
              'This usually means the JSON structure is invalid or missing required fields.',
            );
          }
          return widget;
        } catch (e, stackTrace) {
          AppLogger.e('STAC parsing error for screen: $screenName', e, stackTrace);
          final userMessage = StacErrorHandler.getUserFriendlyMessage(e);
          return _buildErrorWidget(
            'STAC parsing error for screen "$screenName":\n\n$userMessage',
          );
        }
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) {
        AppLogger.e('Failed to load screen: $screenName', error, stackTrace);
        final userMessage = StacErrorHandler.getUserFriendlyMessage(error);
        return _buildErrorWidget('Failed to load screen "$screenName":\n\n$userMessage');
      },
    );
  }

  /// Register navigation action handler
  void _registerNavigationHandler() {
    // Note: STAC navigation actions are handled by the framework
    // We may need to intercept them to update our state
    // For now, we'll rely on STAC's built-in navigation
    // TODO: Implement custom navigation handler if needed
  }

  /// Handle hot reload
  void _handleHotReload() {
    final screenNotifier = ref.read(currentScreenProvider);
    final currentScreen = screenNotifier.screen;
    if (currentScreen != null) {
      // Trigger rebuild by notifying the screen notifier
      // The ListenableBuilder will rebuild and reload the screen
      screenNotifier.setScreen(currentScreen);
      AppLogger.i('🔄 Hot reload triggered for screen: $currentScreen');
    }
  }

  /// Handle restart
  void _handleRestart() {
    // Reset to initial screen
    final entryPointNotifier = ref.read(currentEntryPointProvider);
    final entryPointPath = entryPointNotifier.entryPoint ?? _currentEntryPointPath;
    final entryPointAsync = ref.read(entryPointConfigProvider(entryPointPath ?? '').future);
    
    entryPointAsync.then((config) {
      ref.read(currentScreenProvider).setScreen(config.initialScreen);
      // Don't invalidate here - let the ListenableBuilder handle the rebuild
      AppLogger.i('🔄 Restart triggered - reset to initial screen: ${config.initialScreen}');
    });
  }

  /// Build error widget
  Widget _buildErrorWidget(String message) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Retry by invalidating providers
                  ref.invalidate(entryPointConfigProvider);
                  ref.invalidate(screenDataProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get entry point directory from path
  String? _getEntryPointDirectory(String entryPointPath) {
    if (entryPointPath.isEmpty) {
      return null;
    }

    final file = File(entryPointPath);
    return file.parent.path;
  }
}

