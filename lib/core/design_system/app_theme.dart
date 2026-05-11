import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'tokens.dart' as ds;
import 'typography.dart';
import 'semantic_colors.dart';

AppBarTheme buildStableAppBarTheme(ColorScheme scheme) {
  return AppBarTheme(
    backgroundColor: scheme.surface,
    foregroundColor: scheme.onSurface,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
  );
}

ThemeData buildTheme({required Brightness brightness}) {
  final scheme = brightness == Brightness.dark ? darkScheme : lightScheme;
  final textTheme = buildTextTheme(brightness: brightness);
  final semantics = brightness == Brightness.dark
      ? darkSemanticColors
      : lightSemanticColors;

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: textTheme,
    appBarTheme: buildStableAppBarTheme(scheme),
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    tabBarTheme: const TabBarThemeData(
      overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: const StadiumBorder(),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
    ),

    // Attach tokens + semantic colors
    extensions: <ThemeExtension<dynamic>>[
      const ds.Spacing(),
      const ds.Radii(),
      const ds.Durations(),
      semantics,
    ],
  );
}
