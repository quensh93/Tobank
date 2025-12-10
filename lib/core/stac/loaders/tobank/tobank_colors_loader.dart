import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stac/stac.dart';
import '../../../helpers/logger.dart';

/// Loads and caches color schema at app startup
/// 
/// Colors are loaded ONCE and stored in StacRegistry for global access.
/// All screens can then access colors via {{appColors.button.primary.backgroundColor}} syntax.
/// 
/// **Usage:**
/// ```dart
/// // In main.dart or bootstrap
/// await TobankColorsLoader.loadColors(dio);
/// ```
/// 
/// **Access in JSON:**
/// ```json
/// {
///   "type": "elevatedButton",
///   "style": {
///     "backgroundColor": "{{appColors.button.primary.backgroundColor}}"
///   }
/// }
/// ```
class TobankColorsLoader {
  static bool _loaded = false;
  static Map<String, dynamic>? _cachedColorsData;
  static final List<String> _storedKeys = []; // Track all keys we stored
  static final List<String> _aliasKeys = []; // Track all alias keys (appColors.current.*)
  static const String _colorsUrl = 'https://api.tobank.com/colors';
  static const String _prefix = 'appColors';

  /// Load colors from API and store in StacRegistry
  /// 
  /// This should be called ONCE at app initialization.
  /// On app restart, clears old keys and reloads fresh colors.
  /// 
  /// Colors are stored with dot notation keys:
  /// - `appColors.button.primary.backgroundColor` → "#d61f2c"
  /// - `appColors.text.title` → "#101828"
  static Future<void> loadColors(Dio dio, {bool forceReload = false}) async {
    // Always clear old keys first (in case of hot restart or force reload)
    if (_storedKeys.isNotEmpty) {
      _clearStoredKeys();
    }

    if (_loaded && !forceReload) {
      AppLogger.d('✅ Colors already loaded, skipping');
      return;
    }

    try {
      AppLogger.i('📥 Loading color schema from $_colorsUrl...');
      
      final response = await dio.get(_colorsUrl);
      AppLogger.d('   Response received: ${response.statusCode}');
      AppLogger.d('   Response data type: ${response.data.runtimeType}');
      
      if (response.data == null || response.data['data'] == null) {
        AppLogger.e('❌ Colors response data is null!');
        return;
      }
      
      final colorsData = response.data['data'] as Map<String, dynamic>;
      _cachedColorsData = colorsData;
      
      
      // Store nested structure with dot notation for both light and dark
      // This allows {{appColors.light.button.primary.backgroundColor}} and {{appColors.dark.button.primary.backgroundColor}}
      _storeColors(colorsData, _prefix);
      
      // Detect current theme and create appColors.current.* aliases
      final currentTheme = await _detectCurrentTheme();
      _createCurrentThemeAliases(colorsData, currentTheme);
      
      // Store current theme in registry for reference
      StacRegistry.instance.setValue('appTheme.current', currentTheme);
      
      _loaded = true;
      AppLogger.i('✅ Color schema loaded and cached in StacRegistry');
      AppLogger.d('   Total keys stored: ${_storedKeys.length}');
      AppLogger.d('   Current theme: $currentTheme');
      
      // Debug: Verify sample values
      final detectedTheme = StacRegistry.instance.getValue('appTheme.current') ?? 'light';
      final sample1 = StacRegistry.instance.getValue('appColors.current.button.primary.backgroundColor');
      final sample2 = StacRegistry.instance.getValue('appColors.current.text.title');
      final sample3Light = StacRegistry.instance.getValue('appColors.light.button.primary.backgroundColor');
      final sample3Dark = StacRegistry.instance.getValue('appColors.dark.button.primary.backgroundColor');
      
      AppLogger.d('   Detected theme: $detectedTheme');
      AppLogger.d('   Sample 1 (current): appColors.current.button.primary.backgroundColor = $sample1');
      AppLogger.d('   Sample 2 (current): appColors.current.text.title = $sample2');
      AppLogger.d('   Sample 3 (light): appColors.light.button.primary.backgroundColor = $sample3Light');
      AppLogger.d('   Sample 4 (dark): appColors.dark.button.primary.backgroundColor = $sample3Dark');
      
      // Additional theme verification
      final currentTextTitle = StacRegistry.instance.getValue('appColors.current.text.title');
      final currentBackgroundSurface = StacRegistry.instance.getValue('appColors.current.background.surface');
      final currentInputHint = StacRegistry.instance.getValue('appColors.current.input.hint');
      
      AppLogger.i('🎨 THEME SUMMARY:');
      AppLogger.i('   Current Theme: $detectedTheme');
      AppLogger.i('   Text Title Color: $currentTextTitle (should be #f9fafb for dark, #101828 for light)');
      AppLogger.i('   Background Surface: $currentBackgroundSurface (should be #202633 for dark, #fafafc for light)');
      AppLogger.i('   Input Hint Color: $currentInputHint (should be #98a2b3 for dark, #9eacba for light)');
      
      // Verify theme correctness
      if (detectedTheme == 'dark') {
        if (currentTextTitle == '#f9fafb' && currentBackgroundSurface == '#202633') {
          AppLogger.i('   ✅ Dark theme colors verified correctly');
        } else {
          AppLogger.w('   ⚠️ WARNING: Dark theme colors do not match expected values!');
          AppLogger.w('      Expected text.title: #f9fafb, got: $currentTextTitle');
          AppLogger.w('      Expected background.surface: #202633, got: $currentBackgroundSurface');
        }
      } else if (detectedTheme == 'light') {
        if (currentTextTitle == '#101828' && currentBackgroundSurface == '#fafafc') {
          AppLogger.i('   ✅ Light theme colors verified correctly');
        } else {
          AppLogger.w('   ⚠️ WARNING: Light theme colors do not match expected values!');
          AppLogger.w('      Expected text.title: #101828, got: $currentTextTitle');
          AppLogger.w('      Expected background.surface: #fafafc, got: $currentBackgroundSurface');
        }
      }
      
      if (sample1 == null) {
        AppLogger.w('⚠️ WARNING: appColors.current.button.primary.backgroundColor is NULL in registry!');
      }
      if (sample2 == null) {
        AppLogger.w('⚠️ WARNING: appColors.current.text.title is NULL in registry!');
      }
      if (sample3Light == null) {
        AppLogger.w('⚠️ WARNING: appColors.light.button.primary.backgroundColor is NULL in registry!');
      }
      if (sample3Dark == null) {
        AppLogger.w('⚠️ WARNING: appColors.dark.button.primary.backgroundColor is NULL in registry!');
      }
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to load color schema', e, stackTrace);
      // Don't throw - app can still work with fallback colors
    }
  }

  /// Recursively flatten and store color properties in StacRegistry
  /// 
  /// Example:
  /// Input: {"button": {"primary": {"backgroundColor": "#d61f2c"}}}
  /// Output: 
  ///   - StacRegistry.setValue("appColors.button.primary.backgroundColor", "#d61f2c")
  /// 
  /// This allows {{appColors.button.primary.backgroundColor}} to work in JSON.
  static void _storeColors(Map<String, dynamic> data, String prefix) {
    data.forEach((key, value) {
      final fullKey = '$prefix.$key';
      
      if (value is Map<String, dynamic>) {
        // Recursively flatten nested maps
        _storeColors(value, fullKey);
      } else {
        // Store leaf values directly with dot notation
        StacRegistry.instance.setValue(fullKey, value);
        _storedKeys.add(fullKey);
        
        // Debug: Log first few keys to verify storage
        if (_storedKeys.length <= 5) {
          AppLogger.d('   Stored color: $fullKey = "$value"');
        }
      }
    });
  }

  /// Clear all stored color keys from registry
  static void _clearStoredKeys() {
    final count = _storedKeys.length;
    for (final key in _storedKeys) {
      StacRegistry.instance.removeValue(key);
    }
    _storedKeys.clear();
    
    // Also clear alias keys
    final aliasCount = _aliasKeys.length;
    for (final key in _aliasKeys) {
      StacRegistry.instance.removeValue(key);
    }
    _aliasKeys.clear();
    
    AppLogger.d('🗑️ Cleared $count color keys and $aliasCount alias keys from registry');
  }

  /// Clear cached colors (useful for testing or theme switching)
  static void clearCache() {
    _clearStoredKeys();
    _cachedColorsData = null;
    _loaded = false;
    AppLogger.i('🗑️ Colors cache cleared');
  }

  /// Update current theme aliases when theme changes
  /// 
  /// Call this method when the app theme changes (e.g., user toggles dark mode).
  /// This will update all `appColors.current.*` aliases to point to the new theme.
  /// 
  /// **Note**: This requires colors to be already loaded. If colors aren't loaded,
  /// this method will do nothing.
  /// 
  /// **Usage:**
  /// ```dart
  /// // When theme changes
  /// await TobankColorsLoader.updateCurrentTheme('dark', dio);
  /// ```
  static Future<void> updateCurrentTheme(String newTheme, Dio dio) async {
    if (!_loaded) {
      AppLogger.w('⚠️ Colors not loaded yet, cannot update theme. Load colors first.');
      return;
    }

    try {
      // Reload colors to get fresh data
      final response = await dio.get(_colorsUrl);
      if (response.data == null || response.data['data'] == null) {
        AppLogger.e('❌ Colors response data is null!');
        return;
      }

      final colorsData = response.data['data'] as Map<String, dynamic>;
      
      // Remove old current.* aliases
      for (final key in _aliasKeys) {
        StacRegistry.instance.removeValue(key);
      }
      _aliasKeys.clear();
      
      // Create new aliases for the new theme
      _createCurrentThemeAliases(colorsData, newTheme);
      
      // Update stored current theme
      StacRegistry.instance.setValue('appTheme.current', newTheme);
      
      AppLogger.i('✅ Updated current theme to: $newTheme');
      AppLogger.d('   All {{appColors.current.*}} references now point to $newTheme theme');
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to update current theme', e, stackTrace);
    }
  }

  /// Check if colors are loaded
  static bool get isLoaded => _loaded;

  /// Get a specific color value (for debugging)
  static String? getColor(String key) {
    final fullKey = '$_prefix.$key';
    final value = StacRegistry.instance.getValue(fullKey);
    return value?.toString();
  }

  /// Detect current theme from system brightness
  /// Returns 'light' or 'dark' based on system preference
  static Future<String> _detectCurrentTheme() async {
    try {
      // Respect user preference saved by ThemeController when available
      const storage = FlutterSecureStorage();
      const themeModeKey = 'theme_mode';
      final savedMode = await storage.read(key: themeModeKey);
      final storedTheme =
          savedMode == 'light' || savedMode == 'dark' ? savedMode : null;

      if (storedTheme != null) {
        AppLogger.d('   Detected stored theme preference: $storedTheme');
        return storedTheme;
      }

      // Fallback to system brightness when no explicit preference is saved
      final brightness = ui.PlatformDispatcher.instance.platformBrightness;
      final theme = brightness == ui.Brightness.dark ? 'dark' : 'light';
      AppLogger.d('   Detected system theme: $theme (brightness: $brightness)');
      return theme;
    } catch (e) {
      AppLogger.w('⚠️ Could not detect theme, defaulting to light: $e');
      return 'light'; // Default to light if detection fails
    }
  }

  /// Create aliases for appColors.current.* that point to the current theme
  /// 
  /// Example:
  /// If current theme is 'light', then:
  ///   appColors.current.button.primary.backgroundColor → appColors.light.button.primary.backgroundColor
  /// 
  /// This allows using {{appColors.current.*}} in JSON which automatically resolves
  /// to the correct theme without needing conditionals everywhere.
  static void _createCurrentThemeAliases(Map<String, dynamic> colorsData, String currentTheme) {
    if (!colorsData.containsKey(currentTheme)) {
      AppLogger.w('⚠️ Theme "$currentTheme" not found in colors data, skipping alias creation');
      return;
    }

    final currentThemeData = colorsData[currentTheme] as Map<String, dynamic>;
    int aliasCount = 0;

    // Recursively create aliases for all color properties
    void createAliases(Map<String, dynamic> data, String path) {
      data.forEach((key, value) {
        final currentPath = path.isEmpty ? key : '$path.$key';
        
        if (value is Map<String, dynamic>) {
          // Recursively process nested maps
          createAliases(value, currentPath);
        } else {
          // Create alias: appColors.current.* → appColors.{currentTheme}.*
          final sourceKey = 'appColors.$currentTheme.$currentPath';
          final aliasKey = 'appColors.current.$currentPath';
          
          // Get the value from the source key (already stored by _storeColors)
          final sourceValue = StacRegistry.instance.getValue(sourceKey);
          if (sourceValue != null) {
            // Store as alias (pointing to current theme)
            StacRegistry.instance.setValue(aliasKey, sourceValue);
            _aliasKeys.add(aliasKey); // Track alias key for cleanup
            aliasCount++;
            
            // Debug: Log first few aliases
            if (aliasCount <= 5) {
              AppLogger.d('   Created alias: $aliasKey → $sourceKey = $sourceValue');
            }
          } else {
            AppLogger.w('⚠️ Source key not found: $sourceKey');
          }
        }
      });
    }

    // Start creating aliases from the current theme data
    createAliases(currentThemeData, '');
    
    AppLogger.i('✅ Created $aliasCount color aliases for current theme ($currentTheme)');
    AppLogger.d('   Use {{appColors.current.*}} in JSON to automatically use current theme');
  }

  /// Update current theme aliases without refetching colors.
  /// Requires colors to have been loaded already.
  static void setCurrentTheme(String newTheme) {
    if (!_loaded || _cachedColorsData == null) {
      AppLogger.w('⚠️ Colors not loaded; cannot update current theme aliases to $newTheme');
      return;
    }

    // Clear previous aliases
    for (final key in _aliasKeys) {
      StacRegistry.instance.removeValue(key);
    }
    _aliasKeys.clear();

    _createCurrentThemeAliases(_cachedColorsData!, newTheme);
    StacRegistry.instance.setValue('appTheme.current', newTheme);
    AppLogger.i('✅ Synced appColors.current.* aliases to theme: $newTheme');
  }
}
