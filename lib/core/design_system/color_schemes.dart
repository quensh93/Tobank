import 'package:flutter/material.dart';

// Light color scheme - Material 3 complete specification
const lightScheme = ColorScheme(
  brightness: Brightness.light,
  
  // Primary colors
  primary: Color(0xFF6750A4),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFEADDFF),
  onPrimaryContainer: Color(0xFF21005D),
  primaryFixed: Color(0xFFEADDFF),
  primaryFixedDim: Color(0xFFD0BCFF),
  onPrimaryFixed: Color(0xFF21005D),
  onPrimaryFixedVariant: Color(0xFF4F378B),
  
  // Secondary colors
  secondary: Color(0xFF625B71),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8DEF8),
  onSecondaryContainer: Color(0xFF1D192B),
  secondaryFixed: Color(0xFFE8DEF8),
  secondaryFixedDim: Color(0xFFCCC2DC),
  onSecondaryFixed: Color(0xFF1D192B),
  onSecondaryFixedVariant: Color(0xFF4A4458),
  
  // Tertiary colors
  tertiary: Color(0xFF7D5260),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD8E4),
  onTertiaryContainer: Color(0xFF31111D),
  tertiaryFixed: Color(0xFFFFD8E4),
  tertiaryFixedDim: Color(0xFFEFB8C8),
  onTertiaryFixed: Color(0xFF31111D),
  onTertiaryFixedVariant: Color(0xFF633B48),
  
  // Error colors
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  
  // Surface colors - Material 3 surface container hierarchy
  surface: Color(0xFFFFFBFE),
  onSurface: Color(0xFF1C1B1F),
  surfaceDim: Color(0xFFDDD8DD),
  surfaceBright: Color(0xFFFFFBFE),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFF7F2F7),
  surfaceContainer: Color(0xFFF1ECF1),
  surfaceContainerHigh: Color(0xFFEBE6EB),
  surfaceContainerHighest: Color(0xFFE6E1E5),
  
  // Surface variant (replaced by surfaceContainerHighest in Material 3)
  onSurfaceVariant: Color(0xFF49454F),
  
  // Outline colors
  outline: Color(0xFF79747E),
  outlineVariant: Color(0xFFCAC4D0),
  
  // Inverse colors
  inverseSurface: Color(0xFF313033),
  onInverseSurface: Color(0xFFF4EFF4),
  inversePrimary: Color(0xFFD0BCFF),
  
  // Shadow and overlay
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  surfaceTint: Color(0xFF6750A4),
);

// Dark color scheme - Material 3 complete specification
const darkScheme = ColorScheme(
  brightness: Brightness.dark,
  
  // Primary colors
  primary: Color(0xFFD0BCFF),
  onPrimary: Color(0xFF381E72),
  primaryContainer: Color(0xFF4F378B),
  onPrimaryContainer: Color(0xFFEADDFF),
  primaryFixed: Color(0xFFEADDFF),
  primaryFixedDim: Color(0xFFD0BCFF),
  onPrimaryFixed: Color(0xFF21005D),
  onPrimaryFixedVariant: Color(0xFF6750A4),
  
  // Secondary colors
  secondary: Color(0xFFCCC2DC),
  onSecondary: Color(0xFF332D41),
  secondaryContainer: Color(0xFF4A4458),
  onSecondaryContainer: Color(0xFFE8DEF8),
  secondaryFixed: Color(0xFFE8DEF8),
  secondaryFixedDim: Color(0xFFCCC2DC),
  onSecondaryFixed: Color(0xFF1D192B),
  onSecondaryFixedVariant: Color(0xFF625B71),
  
  // Tertiary colors
  tertiary: Color(0xFFEFB8C8),
  onTertiary: Color(0xFF492532),
  tertiaryContainer: Color(0xFF633B48),
  onTertiaryContainer: Color(0xFFFFD8E4),
  tertiaryFixed: Color(0xFFFFD8E4),
  tertiaryFixedDim: Color(0xFFEFB8C8),
  onTertiaryFixed: Color(0xFF31111D),
  onTertiaryFixedVariant: Color(0xFF7D5260),
  
  // Error colors
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  
  // Surface colors - Material 3 surface container hierarchy
  surface: Color(0xFF1C1B1F),
  onSurface: Color(0xFFE6E1E5),
  surfaceDim: Color(0xFF141218),
  surfaceBright: Color(0xFF36333A),
  surfaceContainerLowest: Color(0xFF0F0D13),
  surfaceContainerLow: Color(0xFF1C1B1F),
  surfaceContainer: Color(0xFF211F26),
  surfaceContainerHigh: Color(0xFF2B2930),
  surfaceContainerHighest: Color(0xFF36333A),
  
  // Surface variant (replaced by surfaceContainerHighest in Material 3)
  onSurfaceVariant: Color(0xFFCAC4D0),
  
  // Outline colors
  outline: Color(0xFF938F99),
  outlineVariant: Color(0xFF49454F),
  
  // Inverse colors
  inverseSurface: Color(0xFFE6E1E5),
  onInverseSurface: Color(0xFF313033),
  inversePrimary: Color(0xFF6750A4),
  
  // Shadow and overlay
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  surfaceTint: Color(0xFFD0BCFF),
);
