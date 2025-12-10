import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:stac/stac.dart';
import '../../../../core/helpers/logger.dart';

/// Loader for Tobank STAC themes
/// 
/// Loads theme JSON from assets and converts to StacTheme objects.
/// Supports both light and dark themes.
class TobankThemeLoader {
  TobankThemeLoader._();

  /// Load light theme from assets
  static Future<StacTheme> loadLightTheme() async {
    try {
      const themePath = 'lib/stac/design_system/tobank_theme_light.json';
      AppLogger.i('Loading Tobank light theme from: $themePath');
      
      final jsonStr = await rootBundle.loadString(themePath);
      final Map<String, dynamic> themeMap = json.decode(jsonStr) as Map<String, dynamic>;
      
      final theme = StacTheme.fromJson(themeMap);
      AppLogger.i('✅ Successfully loaded Tobank light theme');
      return theme;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to load Tobank light theme', e, stackTrace);
      rethrow;
    }
  }

  /// Load dark theme from assets
  static Future<StacTheme> loadDarkTheme() async {
    try {
      const themePath = 'lib/stac/design_system/tobank_theme_dark.json';
      AppLogger.i('Loading Tobank dark theme from: $themePath');
      
      final jsonStr = await rootBundle.loadString(themePath);
      final Map<String, dynamic> themeMap = json.decode(jsonStr) as Map<String, dynamic>;
      
      final theme = StacTheme.fromJson(themeMap);
      AppLogger.i('✅ Successfully loaded Tobank dark theme');
      return theme;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to load Tobank dark theme', e, stackTrace);
      rethrow;
    }
  }

  /// Load theme based on brightness
  static Future<StacTheme> loadTheme({required bool isDark}) async {
    return isDark ? loadDarkTheme() : loadLightTheme();
  }
}
