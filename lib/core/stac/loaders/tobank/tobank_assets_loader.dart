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
  static final List<String> _storedKeys = []; // Track all keys we stored
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
      AppLogger.d('✅ Assets already loaded, skipping');
      return;
    }

    try {
      AppLogger.i('📥 Loading assets from $_assetsUrl...');

      final response = await dio.get(_assetsUrl);
      AppLogger.d('   Response received: ${response.statusCode}');

      if (response.data == null || response.data['data'] == null) {
        AppLogger.e('❌ Assets response data is null!');
        return;
      }

      final assetsData = response.data['data'] as Map<String, dynamic>;

      // Flatten nested structure and store with dot-notation keys
      // This allows {{appAssets.icons.login}} syntax to work
      _flattenAndStore(assetsData, _prefix);

      _loaded = true;
      AppLogger.i('✅ Assets loaded and cached in StacRegistry');
      AppLogger.d('   Total keys stored: ${_storedKeys.length}');
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to load assets', e, stackTrace);
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

  /// Clear all stored asset keys from registry
  static void _clearStoredKeys() {
    for (final key in _storedKeys) {
      StacRegistry.instance.removeValue(key);
    }
    _storedKeys.clear();
  }

  /// Check if assets are loaded
  static bool get isLoaded => _loaded;
}
