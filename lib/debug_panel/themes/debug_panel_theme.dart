import 'package:flutter/material.dart';

/// Debug panel theme modes
enum DebugPanelThemeMode {
  light,
  dark,
  system,
}

/// Debug panel theme with Material 3 design
class DebugPanelTheme {
  final DebugPanelThemeMode themeMode;
  final ColorScheme lightColorScheme;
  final ColorScheme darkColorScheme;

  DebugPanelTheme({
    this.themeMode = DebugPanelThemeMode.system,
    ColorScheme? lightColorScheme,
    ColorScheme? darkColorScheme,
  })  : lightColorScheme = lightColorScheme ??
        ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Indigo
          brightness: Brightness.light,
        ),
        darkColorScheme = darkColorScheme ??
        ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Indigo
          brightness: Brightness.dark,
        );

  /// Create Material 3 theme data for light mode
  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightColorScheme.surface,
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: lightColorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          color: lightColorScheme.surface,
        ),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: SegmentedButton.styleFrom(
            backgroundColor: lightColorScheme.surface,
            foregroundColor: lightColorScheme.onSurface,
            selectedForegroundColor: Colors.white,
            selectedBackgroundColor: lightColorScheme.primary,
            side: BorderSide(
              color: lightColorScheme.outline.withValues(alpha: 0.2),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            minimumSize: const Size(80, 40),
            iconSize: 20,
          ),
        ),
        sliderTheme: SliderThemeData(
          thumbColor: lightColorScheme.primary,
          activeTrackColor: lightColorScheme.primary,
          inactiveTrackColor:
              lightColorScheme.primaryContainer.withValues(alpha: 0.3),
          overlayColor: lightColorScheme.primary.withValues(alpha: 0.1),
          valueIndicatorColor: lightColorScheme.primary,
          valueIndicatorTextStyle: const TextStyle(color: Colors.white),
          tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 6),
          activeTickMarkColor: lightColorScheme.primary,
          inactiveTickMarkColor:
              lightColorScheme.primaryContainer.withValues(alpha: 0.3),
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: lightColorScheme.primary,
          unselectedLabelColor: lightColorScheme.onSurface.withValues(alpha: 0.6),
          indicatorColor: lightColorScheme.primary,
          dividerColor: lightColorScheme.outline.withValues(alpha: 0.2),
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: lightColorScheme.surface,
          deleteIconColor: lightColorScheme.onSurface.withValues(alpha: 0.6),
          labelStyle: TextStyle(color: lightColorScheme.onSurface),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightColorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: lightColorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: lightColorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: lightColorScheme.primary,
              width: 2,
            ),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: lightColorScheme.outline.withValues(alpha: 0.2),
          thickness: 1,
          space: 1,
        ),
      );

  /// Create Material 3 theme data for dark mode
  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: darkColorScheme.surface,
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: darkColorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          color: darkColorScheme.surface,
        ),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: SegmentedButton.styleFrom(
            backgroundColor: darkColorScheme.surface,
            foregroundColor: darkColorScheme.onSurface,
            selectedForegroundColor: Colors.white,
            selectedBackgroundColor: darkColorScheme.primary,
            side: BorderSide(
              color: darkColorScheme.outline.withValues(alpha: 0.2),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            minimumSize: const Size(80, 40),
            iconSize: 20,
          ),
        ),
        sliderTheme: SliderThemeData(
          thumbColor: darkColorScheme.primary,
          activeTrackColor: darkColorScheme.primary,
          inactiveTrackColor:
              darkColorScheme.primaryContainer.withValues(alpha: 0.3),
          overlayColor: darkColorScheme.primary.withValues(alpha: 0.1),
          valueIndicatorColor: darkColorScheme.primary,
          valueIndicatorTextStyle: const TextStyle(color: Colors.white),
          tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 6),
          activeTickMarkColor: darkColorScheme.primary,
          inactiveTickMarkColor:
              darkColorScheme.primaryContainer.withValues(alpha: 0.3),
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: darkColorScheme.primary,
          unselectedLabelColor: darkColorScheme.onSurface.withValues(alpha: 0.6),
          indicatorColor: darkColorScheme.primary,
          dividerColor: darkColorScheme.outline.withValues(alpha: 0.2),
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: darkColorScheme.surface,
          deleteIconColor: darkColorScheme.onSurface.withValues(alpha: 0.6),
          labelStyle: TextStyle(color: darkColorScheme.onSurface),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkColorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: darkColorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: darkColorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: darkColorScheme.primary,
              width: 2,
            ),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: darkColorScheme.outline.withValues(alpha: 0.2),
          thickness: 1,
          space: 1,
        ),
      );

  /// Get the appropriate theme based on mode and system brightness
  ThemeData themeForBrightness(Brightness brightness) {
    if (themeMode == DebugPanelThemeMode.light) {
      return lightTheme;
    } else if (themeMode == DebugPanelThemeMode.dark) {
      return darkTheme;
    } else {
      // System mode - use system brightness
      return brightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }

  /// Create copy with updated theme mode
  DebugPanelTheme copyWith({
    DebugPanelThemeMode? themeMode,
    ColorScheme? lightColorScheme,
    ColorScheme? darkColorScheme,
  }) {
    return DebugPanelTheme(
      themeMode: themeMode ?? this.themeMode,
      lightColorScheme: lightColorScheme ?? this.lightColorScheme,
      darkColorScheme: darkColorScheme ?? this.darkColorScheme,
    );
  }
}

