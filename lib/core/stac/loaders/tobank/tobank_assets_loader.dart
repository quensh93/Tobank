import 'package:dio/dio.dart';
import 'package:stac/stac.dart';
import '../../../helpers/logger.dart';

/// Loads and caches assets paths at app startup
///
/// Assets are loaded ONCE and stored in StacRegistry for global access.
/// All screens can then access assets via {{appAssets.icons.login}} syntax.
///
/// **Usage:**
/// ```dart
/// // In main.dart or bootstrap
/// await TobankAssetsLoader.loadAssets(dio);
/// ```
class TobankAssetsLoader {
  static bool _loaded = false;
  static Map<String, dynamic>? _cachedAssetsData;
  static final List<String> _storedKeys = []; // Track all keys we stored
  static final List<String> _aliasKeys = []; // Track theme-aware aliases
  static const String _assetsUrl = 'https://api.tobank.com/assets';
  static const String _prefix = 'appAssets';

  /// Load assets from API and store in StacRegistry
  ///
  /// This should be called ONCE at app initialization.
  static Future<void> loadAssets(Dio dio, {bool forceReload = false}) async {
    // Always clear old keys first (in case of hot restart or force reload)
    if (_storedKeys.isNotEmpty) {
      _clearStoredKeys();
    }

    if (_loaded && !forceReload) {
      AppLogger.d('Assets already loaded, skipping');
      return;
    }

    try {
      AppLogger.i('Loading assets from $_assetsUrl...');

      final response = await dio.get(_assetsUrl);
      AppLogger.d('   Response received: ${response.statusCode}');

      if (response.data == null || response.data['data'] == null) {
        AppLogger.e('Assets response data is null!');
        return;
      }

      final assetsData = response.data['data'] as Map<String, dynamic>;
      _cachedAssetsData = assetsData;

      // Flatten nested structure and store with dot-notation keys
      // This allows {{appAssets.icons.login}} syntax to work
      _flattenAndStore(assetsData, _prefix);

      final currentTheme =
          (StacRegistry.instance.getValue('appTheme.current') ?? 'light')
              .toString();
      _createCurrentThemeAliases(assetsData, currentTheme);

      _loaded = true;
      AppLogger.i('Assets loaded and cached in StacRegistry');
      AppLogger.d('   Total keys stored: ${_storedKeys.length}');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to load assets', e, stackTrace);
    }
  }

  /// Recursively flatten nested Map structure and store in StacRegistry
  static void _flattenAndStore(Map<String, dynamic> data, String prefix) {
    data.forEach((key, value) {
      final fullKey = '$prefix.$key';

      if (value is Map<String, dynamic>) {
        // Recursively flatten nested maps
        _flattenAndStore(value, fullKey);
      } else {
        // Store leaf values directly
        StacRegistry.instance.setValue(fullKey, value);
        _storedKeys.add(fullKey); // Track for cleanup

        // Debug: Log first few keys to verify storage
        if (_storedKeys.length <= 5) {
          AppLogger.d('   Stored: $fullKey = "$value"');
        }
      }
    });
  }

  static void _createCurrentThemeAliases(
    Map<String, dynamic> data,
    String currentTheme,
  ) {
    void walk(Map<String, dynamic> node, String prefix) {
      node.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          walk(value, '$prefix.$key');
          return;
        }

        if (key.endsWith('Dark')) {
          return;
        }

        String? aliasName;
        dynamic lightValue = value;
        dynamic darkValue;

        if (key.endsWith('Light')) {
          aliasName = key.substring(0, key.length - 'Light'.length);
          darkValue = node['${aliasName}Dark'];
        } else {
          aliasName = key;
          darkValue = node['${key}Dark'];
        }

        if (darkValue == null) {
          return;
        }

        final selectedValue = currentTheme == 'dark' ? darkValue : lightValue;

        final currentKey = '$prefix.${aliasName}Current';
        StacRegistry.instance.setValue(currentKey, selectedValue);
        _aliasKeys.add(currentKey);

        final namespacedCurrentKey =
            '$_prefix.current.${prefix.substring(_prefix.length + 1)}.$aliasName';
        StacRegistry.instance.setValue(namespacedCurrentKey, selectedValue);
        _aliasKeys.add(namespacedCurrentKey);
      });
    }

    walk(data, _prefix);
    AppLogger.d(
      'Created ${_aliasKeys.length} asset aliases for current theme ($currentTheme)',
    );
  }

  static void setCurrentTheme(String newTheme) {
    if (!_loaded || _cachedAssetsData == null) {
      AppLogger.w('Assets not loaded; cannot update current theme aliases');
      return;
    }

    for (final key in _aliasKeys) {
      StacRegistry.instance.removeValue(key);
    }
    _aliasKeys.clear();

    _createCurrentThemeAliases(_cachedAssetsData!, newTheme);
    AppLogger.i('Synced appAssets current aliases to theme: $newTheme');
  }

  /// Clear all stored asset keys from registry
  static void _clearStoredKeys() {
    for (final key in _storedKeys) {
      StacRegistry.instance.removeValue(key);
    }
    for (final key in _aliasKeys) {
      StacRegistry.instance.removeValue(key);
    }
    _storedKeys.clear();
    _aliasKeys.clear();
  }

  /// Check if assets are loaded
  static bool get isLoaded => _loaded;
}
