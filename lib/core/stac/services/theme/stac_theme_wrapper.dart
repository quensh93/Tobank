import 'package:flutter/material.dart';

/// Service for creating and applying themes to widgets.
///
/// Follows Single Responsibility Principle - only responsible for theme creation
/// and widget wrapping.
///
/// Follows Open/Closed Principle - theme configuration can be extended
/// without modifying this class.
class StacThemeWrapper {
  StacThemeWrapper._();

  /// Creates a theme with orange input borders and purple buttons.
  ///
  /// This is a default theme configuration. Can be extended to support
  /// different theme configurations based on requirements.
  static ThemeData createNavigationTheme(BuildContext context) {
    final baseTheme = Theme.of(context); // Orange color for borders
    const borderWidth = 0.5;
    final borderColor = baseTheme.dividerColor; 
    final borderRadius =BorderRadius.circular(12);

    return baseTheme.copyWith(
      // Override colorScheme.primary so buttons without explicit style use purple
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: Colors.purple,
        onPrimary: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Set orange border for all states
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWidth),
          borderRadius:borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWidth + 0.5),
          borderRadius:borderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: baseTheme.colorScheme.error, width: borderWidth),
          borderRadius:borderRadius,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWidth),
          borderRadius:borderRadius,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWidth),
          borderRadius:borderRadius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: baseTheme.colorScheme.error, width: borderWidth),
          borderRadius:borderRadius,
        ),
      ),
    );
  }

  /// Wraps a widget with the navigation theme.
  static Widget wrapWithTheme(BuildContext context, Widget child) {
    return Theme(data: createNavigationTheme(context), child: child);
  }
}
