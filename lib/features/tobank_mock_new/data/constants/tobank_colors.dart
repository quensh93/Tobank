/// Tobank Color Constants
///
/// This file contains all color constants from the real Tobank app theme.
/// Use these constants in STAC Dart files to ensure color consistency.

library;

// Light Theme Colors
class TobankColorsLight {
  TobankColorsLight._();

  // Surface Colors
  static const String surface = '#F9FAFB';
  static const String onSurface = '#101828';
  static const String background = '#F9FAFB';
  static const String surfaceVariant = '#FAFAFC';
  static const String onSurfaceVariant = '#667085';

  // Text Colors
  static const String textTitle = '#101828';
  static const String textSubtitle = '#667085';
  static const String textHint = '#667085';

  // Border Colors
  static const String border = '#DCDCDC';
  static const String inputBorderEnabled = '#D0D5DD';
  static const String inputBorderFocused = '#344054';

  // Other Colors
  static const String homePageBackground = '#DCFDFF';
  static const String shadow = '#26000000'; // 15% opacity black
}

// Dark Theme Colors
class TobankColorsDark {
  TobankColorsDark._();

  // Surface Colors
  static const String surface = '#202633';
  static const String onSurface = '#FFFFFF';
  static const String background = '#202633';
  static const String surfaceVariant = '#202633';
  static const String onSurfaceVariant = '#BFCCE0';

  // Text Colors
  static const String textTitle = '#F9FAFB';
  static const String textSubtitle = '#BFCCE0';
  static const String textHint = '#98A2B3';

  // Border Colors
  static const String inputBorderEnabled = '#77839B';
  static const String inputBorderFocused = '#F9FAFB';
}

// ColorScheme Colors (Light)
class TobankColorsLightColorScheme {
  TobankColorsLightColorScheme._();
  static const String primary = '#37474F';
  static const String onPrimary = '#FFFFFF';
  static const String secondary = '#00BABA';
  static const String onSecondary = '#FFFFFF';
  static const String error = '#D61F2C';
  static const String onError = '#FFFFFF';
  static const String surface = '#FAFAFC';
  static const String onSurface = '#101828';
}

// ColorScheme Colors (Dark)
class TobankColorsDarkColorScheme {
  TobankColorsDarkColorScheme._();
  static const String primary = '#90A4AE';
  static const String onPrimary = '#0F1011';
  static const String secondary = '#00BABA';
  static const String onSecondary = '#F3F3F6';
  static const String error = '#F24A4D';
  static const String onError = '#140C0D';
  static const String surface = '#202633';
  static const String onSurface = '#ECECEC';
}

class TobankColors {
  TobankColors._();

  // Primary Colors
  static const String primary = '#D61F2C';
  static const String secondary = '#00BABA';
  static const String tertiary = '#F7941D';

  // Status Colors (same for both themes)
  static const String success = '#039855';
  static const String errorLight = '#D61F2C';
  static const String errorDark = '#F24A4D';
  static const String warning = '#F9A200';
  static const String fail = '#C95E5E';

  /// Get text title color based on theme mode
  static String textTitleColor(bool isDark) {
    return isDark ? TobankColorsDark.textTitle : TobankColorsLight.textTitle;
  }

  /// Get text subtitle color based on theme mode
  static String textSubtitleColor(bool isDark) {
    return isDark
        ? TobankColorsDark.textSubtitle
        : TobankColorsLight.textSubtitle;
  }

  /// Get text hint color based on theme mode
  static String textHintColor(bool isDark) {
    return isDark ? TobankColorsDark.textHint : TobankColorsLight.textHint;
  }

  /// Get surface color based on theme mode
  static String surfaceColor(bool isDark) {
    return isDark ? TobankColorsDark.surface : TobankColorsLight.surface;
  }

  /// Get onSurface color based on theme mode
  static String onSurfaceColor(bool isDark) {
    return isDark ? TobankColorsDark.onSurface : TobankColorsLight.onSurface;
  }
}
