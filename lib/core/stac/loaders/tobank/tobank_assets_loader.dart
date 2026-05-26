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
  static const Map<String, ({String light, String dark})>
  _serviceIconFallbacks = {
    'icons.cardService': (
      light: 'assets/icons/ic_card_service.svg',
      dark: 'assets/icons/ic_card_service_dark.svg',
    ),
    'icons.cardServicePasswordChange': (
      light: 'assets/icons/ic_card_service_password_change.svg',
      dark: 'assets/icons/ic_card_service_password_change_dark.svg',
    ),
    'icons.cardServiceReissue': (
      light: 'assets/icons/ic_card_service_reissue.svg',
      dark: 'assets/icons/ic_card_service_reissue_dark.svg',
    ),
    'icons.cardServiceBlock': (
      light: 'assets/icons/ic_card_service_block.svg',
      dark: 'assets/icons/ic_card_service_block_dark.svg',
    ),
    'icons.cardBalance': (
      light: 'assets/icons/ic_card_balance.svg',
      dark: 'assets/icons/ic_card_balance_dark.svg',
    ),
    'icons.successCheck': (
      light: 'assets/icons/ic_check_circle.svg',
      dark: 'assets/icons/ic_check_circle.svg',
    ),
    'icons.alert': (
      light: 'assets/icons/ic_alert_light.svg',
      dark: 'assets/icons/ic_alert_dark.svg',
    ),
  };

  /// Load assets from API and store in StacRegistry
  ///
  /// This should be called ONCE at app initialization.
  static Future<void> loadAssets(Dio dio, {bool forceReload = false}) async {
    // Always clear old keys first (in case of hot restart or force reload)
    if (_storedKeys.isNotEmpty) {
      _clearStoredKeys();
    }

    final currentTheme =
        (StacRegistry.instance.getValue('appTheme.current') ?? 'light')
            .toString();
    _storeServiceIconFallbacks(currentTheme);

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

      _createCurrentThemeAliases(assetsData, currentTheme);
      _storeServiceIconFallbacks(currentTheme);

      _loaded = true;
      AppLogger.i('Assets loaded and cached in StacRegistry');
      AppLogger.d('   Total keys stored: ${_storedKeys.length}');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to load assets', e, stackTrace);
      _cachedAssetsData ??= const {};
      _storeServiceIconFallbacks(currentTheme);
      _loaded = true;
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
    _storeServiceIconFallbacks(newTheme);
    AppLogger.i('Synced appAssets current aliases to theme: $newTheme');
  }

  static void _storeServiceIconFallbacks(String currentTheme) {
    final isDark = currentTheme == 'dark';

    _serviceIconFallbacks.forEach((path, pair) {
      final lightKey = '$_prefix.$path';
      final darkKey = '${lightKey}Dark';
      final currentKey = '$_prefix.current.$path';
      final selectedValue = isDark ? pair.dark : pair.light;

      StacRegistry.instance.setValue(lightKey, pair.light);
      StacRegistry.instance.setValue(darkKey, pair.dark);
      StacRegistry.instance.setValue(currentKey, selectedValue);

      for (final key in [lightKey, darkKey, currentKey]) {
        if (!_aliasKeys.contains(key)) {
          _aliasKeys.add(key);
        }
      }
    });

    AppLogger.d('Synced card-management service icon fallbacks');
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
