import 'package:dio/dio.dart';
import 'package:stac/stac.dart';
import '../../../helpers/logger.dart';

/// Loads and caches localization strings at app startup
///
/// Strings are loaded ONCE and stored in StacRegistry for global access.
/// All screens can then access strings via {{appStrings.login.validationTitle}} syntax.
///
/// **Usage:**
/// ```dart
/// // In main.dart or bootstrap
/// await TobankStringsLoader.loadStrings(dio);
/// ```
///
/// **Access in JSON:**
/// ```json
/// {
///   "type": "text",
///   "data": "{{appStrings.login.validationTitle}}"
/// }
/// ```
class TobankStringsLoader {
  static bool _loaded = false;
  static final List<String> _storedKeys = []; // Track all keys we stored
  static const String _stringsUrl = 'https://api.tobank.com/strings';
  static const String _prefix = 'appStrings';

  /// Load strings from API and store in StacRegistry
  ///
  /// This should be called ONCE at app initialization.
  /// On app restart, clears old keys and reloads fresh strings.
  ///
  /// Strings are flattened with dot notation keys:
  /// - `appStrings.login.validationTitle` → "اعتبار سنجی"
  /// - `appStrings.common.loading` → "در حال بارگذاری..."
  static Future<void> loadStrings(Dio dio, {bool forceReload = false}) async {
    // Always clear old keys first (in case of hot restart or force reload)
    if (_storedKeys.isNotEmpty) {
      _clearStoredKeys();
    }

    if (_loaded && !forceReload) {
      AppLogger.dc(LogCategory.string, '✅ Strings already loaded, skipping');
      return;
    }

    try {
      AppLogger.ic(
        LogCategory.string,
        '📥 Loading localization strings from $_stringsUrl...',
      );

      final response = await dio.get(_stringsUrl);
      AppLogger.dc(
        LogCategory.string,
        '   Response received: ${response.statusCode}',
      );
      AppLogger.dc(
        LogCategory.string,
        '   Response data type: ${response.data.runtimeType}',
      );
      AppLogger.dc(
        LogCategory.string,
        '   Response data keys: ${response.data is Map ? (response.data as Map).keys.toList() : "not a map"}',
      );

      if (response.data == null || response.data['data'] == null) {
        AppLogger.ec(LogCategory.string, '❌ Strings response data is null!');
        return;
      }

      final stringsData = response.data['data'] as Map<String, dynamic>;

      // Flatten nested structure and store with dot-notation keys
      // This allows {{appStrings.login.validationTitle}} syntax to work
      _flattenAndStore(stringsData, _prefix);

      _loaded = true;
      AppLogger.ic(
        LogCategory.string,
        '✅ Localization strings loaded and cached in StacRegistry',
      );
      AppLogger.dc(
        LogCategory.string,
        '   Total keys stored: ${_storedKeys.length}',
      );

      // Debug: Verify several sample values to ensure they're stored correctly
      final sample1 = StacRegistry.instance.getValue(
        'appStrings.login.validationTitle',
      );
      final sample2 = StacRegistry.instance.getValue(
        'appStrings.menu.appBarTitle',
      );
      final sample3 = StacRegistry.instance.getValue(
        'appStrings.common.loading',
      );
      AppLogger.dc(
        LogCategory.string,
        '   Sample 1: appStrings.login.validationTitle = "$sample1"',
      );
      AppLogger.dc(
        LogCategory.string,
        '   Sample 2: appStrings.menu.appBarTitle = "$sample2"',
      );
      AppLogger.dc(
        LogCategory.string,
        '   Sample 3: appStrings.common.loading = "$sample3"',
      );

      // Verify registry has the keys
      if (sample1 == null) {
        AppLogger.wc(
          LogCategory.string,
          '⚠️ WARNING: appStrings.login.validationTitle is NULL in registry!',
        );
      }
      if (sample2 == null) {
        AppLogger.wc(
          LogCategory.string,
          '⚠️ WARNING: appStrings.menu.appBarTitle is NULL in registry!',
        );
      }
    } catch (e, stackTrace) {
      AppLogger.ec(
        LogCategory.string,
        '❌ Failed to load localization strings',
        e,
        stackTrace,
      );
      // Don't throw - app can still work with fallback strings
      // Or you could set default/fallback strings here
    }
  }

  /// Recursively flatten nested Map structure and store in StacRegistry
  ///
  /// Example:
  /// Input: {"login": {"validationTitle": "اعتبار سنجی"}}
  /// Output: StacRegistry.setValue("appStrings.login.validationTitle", "اعتبار سنجی")
  static void _flattenAndStore(Map<String, dynamic> data, String prefix) {
    data.forEach((key, value) {
      final fullKey = '$prefix.$key';

      if (value is Map<String, dynamic>) {
        // Recursively flatten nested maps
        _flattenAndStore(value, fullKey);
      } else {
        // Store leaf values directly with dot notation
        StacRegistry.instance.setValue(fullKey, value);
        _storedKeys.add(fullKey);

        // Debug: Log first few keys to verify storage
        if (_storedKeys.length <= 5) {
          AppLogger.dc(LogCategory.string, '   Stored: $fullKey = "$value"');
        }
      }
    });
  }

  /// Clear all stored string keys from registry
  static void _clearStoredKeys() {
    final count = _storedKeys.length;
    for (final key in _storedKeys) {
      StacRegistry.instance.removeValue(key);
    }
    _storedKeys.clear();
    AppLogger.dc(
      LogCategory.string,
      '🗑️ Cleared $count string keys from registry',
    );
  }

  /// Clear cached strings (useful for testing or language switching)
  static void clearCache() {
    _clearStoredKeys();
    _loaded = false;
    AppLogger.ic(LogCategory.string, '🗑️ Strings cache cleared');
  }

  /// Check if strings are loaded
  static bool get isLoaded => _loaded;

  /// Get a specific string value (for debugging)
  static String? getString(String key) {
    if (key.startsWith(_prefix)) {
      final value = StacRegistry.instance.getValue(key);
      return value?.toString();
    }
    final fullKey = '$_prefix.$key';
    final value = StacRegistry.instance.getValue(fullKey);
    return value?.toString();
  }
}
