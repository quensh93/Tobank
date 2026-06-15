import 'package:dio/dio.dart';
import '../../core/api/config_api/config_api_service.dart';
import '../../core/helpers/logger.dart';
import '../config/sdui_config.dart';
import 'package:stac/stac.dart';

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
  static final String _stringsUrl = SduiConfig.mockUrl('strings');
  static const String _prefix = 'appStrings';
  static const Map<String, String> _fallbackStrings = {
    'appStrings.cardsManagement.services.topUp':
        '\u0627\u0641\u0632\u0627\u06cc\u0634 \u0645\u0648\u062c\u0648\u062f\u06cc',
    'appStrings.cardsManagement.services.transfer':
        '\u0627\u0646\u062a\u0642\u0627\u0644 \u0648\u062c\u0647',
    'appStrings.cardsManagement.services.firstPin':
        '\u0631\u0645\u0632 \u0627\u0648\u0644',
    'appStrings.cardsManagement.services.secondPin':
        '\u0631\u0645\u0632 \u062f\u0648\u0645',
    'appStrings.cardsManagement.services.reissue':
        '\u06a9\u0627\u0631\u062a \u0627\u0644\u0645\u062b\u0646\u06cc',
    'appStrings.cardsManagement.services.block':
        '\u0645\u0633\u062f\u0648\u062f\u0633\u0627\u0632\u06cc',
    'appStrings.cardsManagement.services.balance':
        '\u0645\u0648\u062c\u0648\u062f\u06cc',
    'appStrings.cardsManagement.services.placeholder':
        '\u0627\u06cc\u0646 \u0628\u062e\u0634 \u0628\u0647 \u0632\u0648\u062f\u06cc \u0641\u0639\u0627\u0644 \u0645\u06cc\u200c\u0634\u0648\u062f.',
  };

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

    _storeFallbackStrings();

    if (_loaded && !forceReload) {
      AppLogger.dc(LogCategory.string, 'Strings already loaded, skipping');
      return;
    }

    try {
      AppLogger.ic(
        LogCategory.string,
        'Loading localization strings from $_stringsUrl...',
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
        AppLogger.ec(LogCategory.string, 'Strings response data is null!');
        return;
      }

      final stringsData = response.data['data'] as Map<String, dynamic>;

      // Flatten nested structure and store with dot-notation keys
      // This allows {{appStrings.login.validationTitle}} syntax to work
      _flattenAndStore(stringsData, _prefix);
      _storeFallbackStrings(overwrite: false);

      _loaded = true;
      AppLogger.ic(
        LogCategory.string,
        'Localization strings loaded and cached in StacRegistry',
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
          'WARNING: appStrings.login.validationTitle is NULL in registry!',
        );
      }
      if (sample2 == null) {
        AppLogger.wc(
          LogCategory.string,
          'WARNING: appStrings.menu.appBarTitle is NULL in registry!',
        );
      }
    } catch (e, stackTrace) {
      AppLogger.ec(
        LogCategory.string,
        'Failed to load localization strings',
        e,
        stackTrace,
      );
      _storeFallbackStrings(overwrite: false);
      // Don't throw - app can still work with fallback strings
      // Or you could set default/fallback strings here
    }
  }

  /// Load strings from the REAL backend config server (API mode only).
  ///
  /// Unlike [loadStrings], failures are RETHROWN so the caller can block + retry.
  static Future<void> loadStringsFromBackend(
    ConfigApiService service, {
    bool forceReload = false,
  }) async {
    if (_storedKeys.isNotEmpty) {
      _clearStoredKeys();
    }

    _storeFallbackStrings();

    if (_loaded && !forceReload) {
      AppLogger.dc(LogCategory.string, 'Strings already loaded, skipping');
      return;
    }

    AppLogger.ic(
      LogCategory.string,
      'Loading strings from backend (${SduiConfig.strings})...',
    );

    final stringsData = await service.fetchSduiConfig(
      pathKey: SduiConfig.strings,
      build: SduiConfig.configBuild,
    );

    _flattenAndStore(stringsData, _prefix);
    _storeFallbackStrings(overwrite: false);

    _loaded = true;
    AppLogger.ic(
      LogCategory.string,
      'Strings loaded from backend (${_storedKeys.length} keys)',
    );
  }

  static void _storeFallbackStrings({bool overwrite = true}) {
    _fallbackStrings.forEach((key, value) {
      if (!overwrite && StacRegistry.instance.getValue(key) != null) {
        return;
      }
      StacRegistry.instance.setValue(key, value);
      if (!_storedKeys.contains(key)) {
        _storedKeys.add(key);
      }
    });
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
      'Cleared $count string keys from registry',
    );
  }

  /// Clear cached strings (useful for testing or language switching)
  static void clearCache() {
    _clearStoredKeys();
    _loaded = false;
    AppLogger.ic(LogCategory.string, 'Strings cache cleared');
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
