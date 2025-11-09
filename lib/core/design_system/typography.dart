import 'package:flutter/material.dart';

// Typography system
TextTheme buildTextTheme({required Brightness brightness}) {
  final color = brightness == Brightness.light 
      ? const Color(0xFF1C1B1F) 
      : const Color(0xFFE6E1E5);

  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: color,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: color,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: color,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: color,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: color,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: color,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: color,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: color,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: color,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: color,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: color,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: color,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: color,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: color,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: color,
    ),
  );
}
