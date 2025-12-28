import 'package:dio/dio.dart';
import 'package:stac/stac.dart';
import '../../../helpers/logger.dart';

/// Loads and caches component styles at app startup
///
/// Styles are loaded ONCE and stored in StacRegistry for global access.
/// All screens can then access styles via {{appStyles.button.primary}} syntax.
///
/// **Usage:**
/// ```dart
/// // In main.dart or bootstrap
/// await TobankStylesLoader.loadStyles(dio);
/// ```
///
/// **Access in JSON:**
/// ```json
/// {
///   "type": "elevatedButton",
///   "style": "{{appStyles.button.primary}}"
/// }
/// ```
///
/// **Note**: Styles are stored as JSON strings that can be parsed into
/// StacButtonStyle, StacInputDecoration, etc. using their fromJson methods.
class TobankStylesLoader {
  static bool _loaded = false;
  static final List<String> _storedKeys = []; // Track all keys we stored
  static const String _stylesUrl = 'https://api.tobank.com/styles';
  static const String _prefix = 'appStyles';

  /// Load styles from API and store in StacRegistry
  ///
  /// This should be called ONCE at app initialization.
  /// On app restart, clears old keys and reloads fresh styles.
  ///
  /// Styles are stored with dot notation keys:
  /// - `appStyles.button.primary` → JSON object for primary button style
  /// - `appStyles.input.default` → JSON object for default input style
  static Future<void> loadStyles(Dio dio, {bool forceReload = false}) async {
    // Always clear old keys first (in case of hot restart or force reload)
    if (_storedKeys.isNotEmpty) {
      _clearStoredKeys();
    }

    if (_loaded && !forceReload) {
      AppLogger.d('✅ Styles already loaded, skipping');
      return;
    }

    try {
      AppLogger.i('📥 Loading component styles from $_stylesUrl...');

      final response = await dio.get(_stylesUrl);
      AppLogger.d('   Response received: ${response.statusCode}');
      AppLogger.d('   Response data type: ${response.data.runtimeType}');

      if (response.data == null || response.data['data'] == null) {
        AppLogger.e('❌ Styles response data is null!');
        return;
      }

      final stylesData = response.data['data'] as Map<String, dynamic>;

      // DEBUG: Log a sample of the raw styles data to verify what we're getting
      final sampleStyleKey = 'text.pageTitle.color';
      final sampleStyleValue = _getNestedValue(
        stylesData,
        sampleStyleKey.split('.'),
      );
      AppLogger.i('🔍 RAW STYLES DATA VERIFICATION:');
      AppLogger.i('   Sample key: $sampleStyleKey');
      AppLogger.i('   Sample value: $sampleStyleValue');
      AppLogger.i('   Value type: ${sampleStyleValue.runtimeType}');
      if (sampleStyleValue is String &&
          sampleStyleValue.contains('appColors')) {
        AppLogger.w(
          '   ⚠️ WARNING: Value contains appColors reference: $sampleStyleValue',
        );
        if (sampleStyleValue.contains('light')) {
          AppLogger.e(
            '   ❌ ERROR: Found appColors.light reference! Should be appColors.current!',
          );
        } else if (sampleStyleValue.contains('current')) {
          AppLogger.i('   ✅ Good: Found appColors.current reference');
        }
      }

      // CRITICAL: Verify color aliases are available before resolving
      final currentTheme =
          StacRegistry.instance.getValue('appTheme.current') ?? 'unknown';
      final testColor1 = StacRegistry.instance.getValue(
        'appColors.current.text.title',
      );
      final testColor2 = StacRegistry.instance.getValue(
        'appColors.current.input.hint',
      );
      final testColor3 = StacRegistry.instance.getValue(
        'appColors.current.button.primary.foregroundColor',
      );

      AppLogger.i('🔍 PRE-RESOLUTION VERIFICATION:');
      AppLogger.i('   Current theme: $currentTheme');
      AppLogger.i(
        '   appColors.current.text.title = $testColor1 (expected: ${currentTheme == 'dark' ? '#f9fafb' : '#101828'})',
      );
      AppLogger.i(
        '   appColors.current.input.hint = $testColor2 (expected: ${currentTheme == 'dark' ? '#98a2b3' : '#9eacba'})',
      );
      AppLogger.i(
        '   appColors.current.button.primary.foregroundColor = $testColor3 (expected: ${currentTheme == 'dark' ? '#ffffff' : '#ffffff'})',
      );

      if (testColor1 == null || testColor2 == null || testColor3 == null) {
        AppLogger.e(
          '❌ CRITICAL: Color aliases are missing! Cannot resolve styles correctly.',
        );
        AppLogger.e(
          '   This will cause incorrect theme colors to be stored in styles.',
        );
      }

      // Resolve color variables in styles before storing
      // This ensures styles contain actual color values, not {{appColors.*}} references
      final resolvedStylesData = _resolveColorVariables(stylesData);

      // Store nested structure as JSON strings
      // This allows {{appStyles.button.primary}} to resolve to a JSON object
      _storeStyles(resolvedStylesData, _prefix);

      _loaded = true;
      AppLogger.i('✅ Component styles loaded and cached in StacRegistry');
      AppLogger.d('   Total keys stored: ${_storedKeys.length}');

      // Debug: Verify sample values (check actual properties that exist)
      // Reuse currentTheme from PRE-RESOLUTION VERIFICATION section above
      final sample1 = StacRegistry.instance.getValue(
        'appStyles.button.primary.backgroundColor',
      );
      final sample2 = StacRegistry.instance.getValue(
        'appStyles.input.login.hintStyleColor',
      );
      final sample3 = StacRegistry.instance.getValue(
        'appStyles.text.pageTitle.color',
      );

      // Also check what the source color values are
      final sourceColor1 = StacRegistry.instance.getValue(
        'appColors.current.button.primary.backgroundColor',
      );
      final sourceColor2 = StacRegistry.instance.getValue(
        'appColors.current.input.hint',
      );
      final sourceColor3 = StacRegistry.instance.getValue(
        'appColors.current.text.title',
      );

      AppLogger.d('   📊 Theme: $currentTheme');
      AppLogger.d(
        '   Sample 1: appStyles.button.primary.backgroundColor = $sample1',
      );
      AppLogger.d(
        '      Source: appColors.current.button.primary.backgroundColor = $sourceColor1',
      );
      AppLogger.d(
        '   Sample 2: appStyles.input.login.hintStyleColor = $sample2',
      );
      AppLogger.d('      Source: appColors.current.input.hint = $sourceColor2');
      AppLogger.d('   Sample 3: appStyles.text.pageTitle.color = $sample3');
      AppLogger.d('      Source: appColors.current.text.title = $sourceColor3');

      if (sample1 == null) {
        AppLogger.w(
          '⚠️ WARNING: appStyles.button.primary.backgroundColor is NULL in registry!',
        );
      }
      if (sample2 == null) {
        AppLogger.w(
          '⚠️ WARNING: appStyles.input.login.hintStyleColor is NULL in registry!',
        );
      }
      if (sample3 == null) {
        AppLogger.w(
          '⚠️ WARNING: appStyles.text.pageTitle.color is NULL in registry!',
        );
      }
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to load component styles', e, stackTrace);
      // Don't throw - app can still work with fallback styles
    }
  }

  /// Recursively flatten and store style properties in StacRegistry
  ///
  /// Example:
  /// Input: {"button": {"primary": {"backgroundColor": "#d61f2c", "height": 56.0}}}
  /// Output:
  ///   - StacRegistry.setValue("appStyles.button.primary.backgroundColor", "#d61f2c")
  ///   - StacRegistry.setValue("appStyles.button.primary.height", 56.0)
  ///
  /// This allows {{appStyles.button.primary.backgroundColor}} to work in JSON.
  /// Styles are constructed in JSON by referencing individual properties.
  static void _storeStyles(Map<String, dynamic> data, String prefix) {
    data.forEach((key, value) {
      final fullKey = '$prefix.$key';

      if (value is Map<String, dynamic>) {
        // Recursively flatten nested maps
        _storeStyles(value, fullKey);
      } else {
        // Store leaf values directly with dot notation
        StacRegistry.instance.setValue(fullKey, value);
        _storedKeys.add(fullKey);

        // Debug: Log first few keys to verify storage
        if (_storedKeys.length <= 5) {
          AppLogger.d('   Stored style: $fullKey = "$value"');
        }
      }
    });
  }

  /// Clear all stored style keys from registry
  static void _clearStoredKeys() {
    final count = _storedKeys.length;
    for (final key in _storedKeys) {
      StacRegistry.instance.removeValue(key);
    }
    _storedKeys.clear();
    AppLogger.d('🗑️ Cleared $count style keys from registry');
  }

  /// Clear cached styles (useful for testing or theme switching)
  static void clearCache() {
    _clearStoredKeys();
    _loaded = false;
    AppLogger.i('🗑️ Styles cache cleared');
  }

  /// Check if styles are loaded
  static bool get isLoaded => _loaded;

  /// Get a specific style value (for debugging)
  static String? getStyle(String key) {
    final fullKey = '$_prefix.$key';
    final value = StacRegistry.instance.getValue(fullKey);
    return value?.toString();
  }

  /// Helper to get nested value from map using dot-notation path
  static dynamic _getNestedValue(Map<String, dynamic> map, List<String> path) {
    dynamic current = map;
    for (final key in path) {
      if (current is Map<String, dynamic>) {
        current = current[key];
      } else {
        return null;
      }
    }
    return current;
  }

  /// Resolve {{appColors.*}} variables in styles data
  ///
  /// This ensures that when styles are stored, they contain actual color values
  /// instead of variable references. This makes the system cleaner and avoids
  /// double resolution when screen JSONs are loaded.
  static dynamic _resolveColorVariables(dynamic data) {
    if (data is String) {
      // Check if the entire string is a color variable reference
      final exactMatch = RegExp(
        r'^{{\s*appColors\.([^}]+)\s*}}$',
      ).firstMatch(data);
      if (exactMatch != null) {
        // Entire string is a color variable reference - resolve it
        final extractedPath = exactMatch.group(1)?.trim() ?? '';
        final variableName = 'appColors.$extractedPath';
        final value = StacRegistry.instance.getValue(variableName);

        // Get current theme for validation (logging removed for cleaner output)
        final currentTheme =
            StacRegistry.instance.getValue('appTheme.current') ?? 'unknown';

        // CRITICAL: Check if we're resolving the wrong theme
        if (variableName.contains('.light.') && currentTheme == 'dark') {
          AppLogger.e(
            '   ❌ CRITICAL ERROR: Resolving appColors.light.* in DARK theme mode!',
          );
          AppLogger.e('      Original string was: $data');
          AppLogger.e(
            '      This should be appColors.current.* or appColors.dark.*',
          );
          // Try to get the correct value
          final correctKey = variableName.replaceFirst('.light.', '.current.');
          final correctValue = StacRegistry.instance.getValue(correctKey);
          AppLogger.e('      Correct key would be: $correctKey');
          AppLogger.e('      Correct value: $correctValue');
          // Use the correct value instead
          if (correctValue != null) {
            AppLogger.w(
              '   🔧 FIXING: Using correct value $correctValue instead of $value',
            );
            return correctValue;
          }
        }

        // For key colors, verify they match expected theme
        if (variableName.contains('current.text.title')) {
          final expectedDark = '#f9fafb';
          final expectedLight = '#101828';
          final expected = currentTheme == 'dark'
              ? expectedDark
              : expectedLight;
          if (value.toString() == expected) {
            AppLogger.d('      ✅ Matches expected $currentTheme theme color');
          } else {
            AppLogger.w(
              '      ⚠️ MISMATCH! Expected $expected for $currentTheme, got $value',
            );
            // Also check what the light and dark values are
            final lightValue = StacRegistry.instance.getValue(
              'appColors.light.text.title',
            );
            final darkValue = StacRegistry.instance.getValue(
              'appColors.dark.text.title',
            );
            AppLogger.w('      Light theme value: $lightValue');
            AppLogger.w('      Dark theme value: $darkValue');
          }
        } else if (variableName.contains('current.input.hint')) {
          final expectedDark = '#98a2b3';
          final expectedLight = '#9eacba';
          final expected = currentTheme == 'dark'
              ? expectedDark
              : expectedLight;
          if (value.toString() == expected) {
            AppLogger.d('      ✅ Matches expected $currentTheme theme color');
          } else {
            AppLogger.w(
              '      ⚠️ MISMATCH! Expected $expected for $currentTheme, got $value',
            );
          }
        } else if (variableName.contains(
          'current.button.primary.foregroundColor',
        )) {
          final expectedDark = '#0f1011';
          final expectedLight = '#ffffff';
          final expected = currentTheme == 'dark'
              ? expectedDark
              : expectedLight;
          if (value.toString() == expected) {
            AppLogger.d('      ✅ Matches expected $currentTheme theme color');
          } else {
            AppLogger.w(
              '      ⚠️ MISMATCH! Expected $expected for $currentTheme, got $value',
            );
          }
        }

        if (value != null) {
          return value; // Return the actual color value
        }
        AppLogger.w('⚠️ Color variable not found: $variableName');
        return data; // Variable not found, return original
      }

      // String contains color variable references but has other text - do string replacement
      return data.replaceAllMapped(RegExp(r'{{appColors\.(.*?)}}'), (match) {
        final variableName = 'appColors.${match.group(1)?.trim() ?? ''}';
        final value = StacRegistry.instance.getValue(variableName);
        // Logging removed for cleaner output
        return value != null ? value.toString() : match.group(0) ?? '';
      });
    } else if (data is Map<String, dynamic>) {
      return data.map(
        (key, value) => MapEntry(key, _resolveColorVariables(value)),
      );
    } else if (data is List) {
      return data.map((item) => _resolveColorVariables(item)).toList();
    }
    return data;
  }

  static Map<String, dynamic>? buildStyleObject(String key) {
    final normalized = key.trim();
    final base = normalized.startsWith('$_prefix.')
        ? normalized.substring(_prefix.length + 1)
        : normalized;
    final parts = base.split('.');
    if (parts.isEmpty) return null;
    final category = parts.first;
    final name = parts.length >= 2 ? parts.sublist(1).join('.') : '';

    Map<String, dynamic> textStyleFor(String prefix) {
      dynamic getVal(String prop) =>
          StacRegistry.instance.getValue('$_prefix.$prefix.$prop');
      final color = getVal('color');
      final fontSize = getVal('fontSize');
      final fontWeight = getVal('fontWeight');
      final fontFamily = getVal('fontFamily');
      final height = getVal('height');
      final map = <String, dynamic>{'type': 'custom'};
      if (color != null) map['color'] = color;
      if (fontSize != null) map['fontSize'] = fontSize;
      if (fontWeight != null) map['fontWeight'] = fontWeight;
      if (fontFamily != null) map['fontFamily'] = fontFamily;
      if (height != null) map['height'] = height;
      return map;
    }

    if (category == 'text') {
      if (name.isEmpty) return null;
      return textStyleFor('text.$name');
    }

    if (category == 'button') {
      dynamic getVal(String prop) =>
          StacRegistry.instance.getValue('$_prefix.button.$name.$prop');
      final backgroundColor = getVal('backgroundColor');
      final elevation = getVal('elevation');
      final height = getVal('height');
      final borderRadius = getVal('borderRadius');
      final paddingTop = getVal('paddingTop');
      final paddingBottom = getVal('paddingBottom');
      final textColor = getVal('textStyleColor');
      final textWeight = getVal('textStyleFontWeight');
      final textSize = getVal('textStyleFontSize');

      final map = <String, dynamic>{};
      if (backgroundColor != null) {
        map['backgroundColor'] = backgroundColor;
      }
      if (elevation != null) {
        map['elevation'] = elevation;
      }
      if (height != null) {
        map['fixedSize'] = {'width': 999999.0, 'height': height};
      }
      if (borderRadius != null) {
        map['shape'] = {
          'type': 'roundedRectangleBorder',
          'borderRadius': {
            'topLeft': borderRadius,
            'topRight': borderRadius,
            'bottomLeft': borderRadius,
            'bottomRight': borderRadius,
          },
        };
      }
      if (paddingTop != null || paddingBottom != null) {
        final padding = <String, dynamic>{};
        if (paddingTop != null) padding['top'] = paddingTop;
        if (paddingBottom != null) padding['bottom'] = paddingBottom;
        map['padding'] = padding;
      }
      if (textColor != null || textWeight != null || textSize != null) {
        final ts = <String, dynamic>{'type': 'custom'};
        if (textColor != null) ts['color'] = textColor;
        if (textWeight != null) ts['fontWeight'] = textWeight;
        if (textSize != null) ts['fontSize'] = textSize;
        map['textStyle'] = ts;
      }
      return map;
    }

    if (category == 'input') {
      dynamic getVal(String prop) =>
          StacRegistry.instance.getValue('$_prefix.input.$name.$prop');
      final hintColor = getVal('hintStyleColor');
      final hintWeight = getVal('hintStyleFontWeight');
      final hintSize = getVal('hintStyleFontSize');
      final suffixColor = getVal('suffixIconColor');
      final contentH = getVal('contentPaddingHorizontal');
      final contentV = getVal('contentPaddingVertical');
      final fillColor = getVal('fillColor');

      final map = <String, dynamic>{};
      final hint = <String, dynamic>{'type': 'custom'};
      if (hintColor != null) hint['color'] = hintColor;
      if (hintWeight != null) hint['fontWeight'] = hintWeight;
      if (hintSize != null) hint['fontSize'] = hintSize;
      if (hint.length > 1) map['hintStyle'] = hint;
      if (contentH != null || contentV != null) {
        final cp = <String, dynamic>{};
        if (contentH != null) {
          cp['left'] = contentH;
          cp['right'] = contentH;
        }
        if (contentV != null) {
          cp['top'] = contentV;
          cp['bottom'] = contentV;
        }
        map['contentPadding'] = cp;
      }
      map['filled'] = false;
      if (fillColor != null) map['fillColor'] = fillColor;
      if (suffixColor != null) {
        final sx = <String, dynamic>{};
        sx['type'] = 'icon';
        sx['color'] = suffixColor;
        map['suffixIcon'] = sx;
      }
      return map;
    }

    if (parts.length == 1) {
      dynamic getVal(String prop) =>
          StacRegistry.instance.getValue('$_prefix.$category.$prop');
      final color = getVal('color');
      final fontSize = getVal('fontSize');
      final fontWeight = getVal('fontWeight');
      final fontFamily = getVal('fontFamily');
      final height = getVal('height');
      final map = <String, dynamic>{'type': 'custom'};
      if (color != null) map['color'] = color;
      if (fontSize != null) map['fontSize'] = fontSize;
      if (fontWeight != null) map['fontWeight'] = fontWeight;
      if (fontFamily != null) map['fontFamily'] = fontFamily;
      if (height != null) map['height'] = height;
      return map;
    }

    return null;
  }
}
