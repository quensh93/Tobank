import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'tokens.dart' as ds;
import 'typography.dart';
import 'semantic_colors.dart';

ThemeData buildTheme({required Brightness brightness}) {
  final scheme = brightness == Brightness.dark ? darkScheme : lightScheme;
  final textTheme = buildTextTheme(brightness: brightness);
  final semantics = brightness == Brightness.dark ? darkSemanticColors : lightSemanticColors;

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: textTheme,

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
