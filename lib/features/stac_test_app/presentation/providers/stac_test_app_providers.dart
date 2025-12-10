import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/entry_point_config.dart';
import '../../data/services/stac_json_file_service.dart';
import '../../data/services/stac_template_binding_service.dart';
import '../../data/utils/stac_error_handler.dart';
import '../../../../core/helpers/logger.dart';
import '../../../../core/api/api_config.dart';
import '../../../../core/api/providers/api_config_provider.dart';
import '../../../../core/api/providers/stac_api_service_provider.dart';

/// Provider for loading entry point configuration
final entryPointConfigProvider = FutureProvider.autoDispose
    .family<EntryPointConfig, String>((ref, entryPointPath) async {
      // Keep the provider alive to prevent automatic retries on error
      ref.keepAlive();

      ref.onDispose(() {
        AppLogger.d('entryPointConfigProvider disposed');
      });

      // Check if Supabase is enabled (use read instead of watch to prevent rebuilds)
      final apiConfig = ref.read(apiConfigProvider);
      if (apiConfig.mode == ApiMode.supabase) {
        AppLogger.i(
          'Fetching entry point config from Supabase: $entryPointPath',
        );
        final apiService = ref.read(stacApiServiceProvider);
        // Remove .json extension but keep the full path structure
        // e.g. "mock/stac_test_app/app_entry_point.json" -> "mock/stac_test_app/app_entry_point"
        final configName = entryPointPath.endsWith('.json')
            ? entryPointPath.substring(0, entryPointPath.length - 5)
            : entryPointPath;
        AppLogger.d('Looking for config with name: $configName');

        try {
          final json = await apiService.fetchConfig(configName);
          AppLogger.d('Supabase fetchConfig returned ${json.length} keys');

          // Guard: ensure we got a non‑empty JSON payload
          if (json.isEmpty) {
            throw EntryPointValidationException(
              'Supabase returned an empty config for "$configName". '
              'Make sure the `config` column in `stac_config` contains valid JSON.',
            );
          }
          final config = EntryPointConfig.fromJson(json);
          AppLogger.i('✅ Entry point config loaded successfully');
          return config;
        } catch (e) {
          AppLogger.e('Error fetching/parsing config from Supabase', e);
          rethrow;
        }
      }

      try {
        AppLogger.i('Loading entry point config: $entryPointPath');

        // Validate path for special characters
        if (StacErrorHandler.hasInvalidPathCharacters(entryPointPath)) {
          throw EntryPointValidationException(
            'Entry point path contains invalid characters: $entryPointPath',
          );
        }

        // Load JSON
        final json = await StacJsonFileService.loadJson(entryPointPath);

        // Validate entry point structure
        StacErrorHandler.validateEntryPoint(json);

        // Parse config
        final config = EntryPointConfig.fromJson(json);
        AppLogger.i('✅ Entry point config loaded: ${config.appName}');
        return config;
      } on EntryPointValidationException catch (e) {
        AppLogger.e('Entry point validation failed: $entryPointPath', e);
        rethrow;
      } catch (e, stackTrace) {
        AppLogger.e('Failed to load entry point config', e, stackTrace);
        rethrow;
      }
    });

/// Provider for loading screen template and data
final screenDataProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, ScreenLoadParams>((ref, params) async {
      // Check if Supabase is enabled
      final apiConfig = ref.watch(apiConfigProvider);
      if (apiConfig.mode == ApiMode.supabase) {
        AppLogger.i('Fetching screen from Supabase: ${params.screenName}');
        final apiService = ref.read(stacApiServiceProvider);
        return apiService.fetchScreen(params.screenName);
      }

      try {
        AppLogger.i('Loading screen from local files: ${params.screenName}');

        // Validate paths for special characters
        if (StacErrorHandler.hasInvalidPathCharacters(params.templatePath)) {
          throw ScreenValidationException(
            'Template path contains invalid characters: ${params.templatePath}',
          );
        }
        if (StacErrorHandler.hasInvalidPathCharacters(params.dataPath)) {
          throw ScreenValidationException(
            'Data path contains invalid characters: ${params.dataPath}',
          );
        }

        // Load template (resolve relative to entry point directory if provided)
        Map<String, dynamic> template;
        try {
          template = await StacJsonFileService.loadJson(
            params.templatePath,
            baseDir: params.entryPointDir,
          );
          StacErrorHandler.validateScreenJson(template, params.screenName);
        } catch (e) {
          throw ScreenValidationException(
            'Failed to load template for screen "${params.screenName}": ${StacErrorHandler.getUserFriendlyMessage(e)}',
          );
        }

        // Load data (resolve relative to entry point directory if provided)
        Map<String, dynamic> data;
        try {
          data = await StacJsonFileService.loadJson(
            params.dataPath,
            baseDir: params.entryPointDir,
          );
          StacErrorHandler.validateScreenJson(data, params.screenName);
        } catch (e) {
          throw ScreenValidationException(
            'Failed to load data for screen "${params.screenName}": ${StacErrorHandler.getUserFriendlyMessage(e)}',
          );
        }

        // Apply data binding
        final resolvedTemplate = StacTemplateBindingService.applyDataToTemplate(
          template,
          data,
        );

        AppLogger.i('✅ Screen loaded and data bound: ${params.screenName}');
        return resolvedTemplate;
      } on ScreenValidationException catch (e) {
        AppLogger.e('Screen validation failed: ${params.screenName}', e);
        rethrow;
      } catch (e, stackTrace) {
        AppLogger.e(
          'Failed to load screen: ${params.screenName}',
          e,
          stackTrace,
        );
        rethrow;
      }
    });

/// Parameters for loading a screen
class ScreenLoadParams {
  final String screenName;
  final String templatePath;
  final String dataPath;
  final String?
  entryPointDir; // Directory of entry point file for relative path resolution

  ScreenLoadParams({
    required this.screenName,
    required this.templatePath,
    required this.dataPath,
    this.entryPointDir,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScreenLoadParams &&
        other.screenName == screenName &&
        other.templatePath == templatePath &&
        other.dataPath == dataPath &&
        other.entryPointDir == entryPointDir;
  }

  @override
  int get hashCode {
    return Object.hash(screenName, templatePath, dataPath, entryPointDir);
  }
}

/// State notifier for current screen name
class CurrentScreenNotifier extends ChangeNotifier {
  String? _screen;

  String? get screen => _screen;

  void setScreen(String screenName) {
    if (_screen != screenName) {
      _screen = screenName;
      notifyListeners();
    }
  }

  void clear() {
    if (_screen != null) {
      _screen = null;
      notifyListeners();
    }
  }
}

/// Provider for current screen name
final currentScreenProvider = Provider<CurrentScreenNotifier>((ref) {
  return CurrentScreenNotifier();
});

/// State notifier for current entry point path
class CurrentEntryPointNotifier extends ChangeNotifier {
  String? _entryPoint;

  String? get entryPoint => _entryPoint;

  void setEntryPoint(String path) {
    if (_entryPoint != path) {
      _entryPoint = path;
      notifyListeners();
    }
  }

  void clear() {
    if (_entryPoint != null) {
      _entryPoint = null;
      notifyListeners();
    }
  }
}

/// Provider for current entry point path
final currentEntryPointProvider = Provider<CurrentEntryPointNotifier>((ref) {
  return CurrentEntryPointNotifier();
});

/// State notifier for hot reload trigger
class HotReloadTriggerNotifier extends ChangeNotifier {
  int _trigger = 0;

  int get trigger => _trigger;

  void triggerReload() {
    _trigger++;
    notifyListeners();
  }
}

/// Provider for hot reload trigger
final hotReloadTriggerProvider = Provider<HotReloadTriggerNotifier>((ref) {
  return HotReloadTriggerNotifier();
});

/// State notifier for restart trigger
class RestartTriggerNotifier extends ChangeNotifier {
  int _trigger = 0;

  int get trigger => _trigger;

  void triggerRestart() {
    _trigger++;
    notifyListeners();
  }
}

/// Provider for restart trigger
final restartTriggerProvider = Provider<RestartTriggerNotifier>((ref) {
  return RestartTriggerNotifier();
});

/// Helper function to resolve relative paths
String resolveRelativePath(String path, String? baseDir) {
  if (path.startsWith('http://') || path.startsWith('https://')) {
    return path; // URL, return as is
  }

  if (baseDir == null) {
    return path; // No base directory, return as is
  }

  // If path is relative, resolve it relative to baseDir
  if (!path.startsWith('/') && !path.contains(':')) {
    // Relative path - resolve relative to entry point directory
    return '$baseDir/$path';
  }

  return path; // Absolute path, return as is
}
