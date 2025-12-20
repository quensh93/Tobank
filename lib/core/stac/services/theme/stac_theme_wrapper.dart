import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';

/// Service for creating and applying themes to widgets.
///
/// Follows Single Responsibility Principle - only responsible for theme creation
/// and widget wrapping.
///
/// Follows Open/Closed Principle - theme configuration can be extended
/// without modifying this class.
class StacThemeWrapper {
  StacThemeWrapper._();

  /// Creates a theme with server-driven input borders and colors.
  ///
  /// Reads color configuration from [StacRegistry] via {{appColors.current.*}}
  /// to ensure the theme matches the server-provided configuration.
  static ThemeData createNavigationTheme(BuildContext context) {
    final baseTheme = Theme.of(context);

    // Read border colors from registry (SERVER-DRIVEN!)
    // These values come from GET_colors.json loaded into the registry
    final borderEnabled = StacRegistry.instance.getValue(
      'appColors.current.input.borderEnabled',
    );
    final borderFocused = StacRegistry.instance.getValue(
      'appColors.current.input.borderFocused',
    );
    final errorColor = StacRegistry.instance.getValue(
      'appColors.current.error.color',
    );

    AppLogger.d(
      '🎨 StacThemeWrapper: Creating theme with borderEnabled=$borderEnabled, borderFocused=$borderFocused',
    );

    // Convert to Color with fallbacks to base theme
    final borderEnabledColor =
        _hexToColor(borderEnabled) ?? baseTheme.dividerColor;
    final borderFocusedColor =
        _hexToColor(borderFocused) ?? baseTheme.colorScheme.primary;
    final errorBorderColor =
        _hexToColor(errorColor) ?? baseTheme.colorScheme.error;

    const borderWidth = 0.5;
    final borderRadius = BorderRadius.circular(12);

    return baseTheme.copyWith(
      // Override colorScheme.primary so buttons without explicit style use purple if not consistent
      // But ideally we should respect the incoming theme
      colorScheme: baseTheme.colorScheme.copyWith(
        primary:
            baseTheme.colorScheme.primary, // Keep primary from StacApp theme
        onPrimary: baseTheme.colorScheme.onPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Set borders based on server configuration
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderEnabledColor, width: borderWidth),
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderFocusedColor,
            width: borderWidth + 0.5,
          ),
          borderRadius: borderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor, width: borderWidth),
          borderRadius: borderRadius,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderEnabledColor.withOpacity(0.5),
            width: borderWidth,
          ),
          borderRadius: borderRadius,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderEnabledColor, width: borderWidth),
          borderRadius: borderRadius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor, width: borderWidth),
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  /// Wraps a widget with the navigation theme.
  static Widget wrapWithTheme(BuildContext context, Widget child) {
    return Theme(data: createNavigationTheme(context), child: child);
  }

  /// Helper to convert hex string to Color
  /// Supports both #RRGGBB and #AARRGGBB formats
  static Color? _hexToColor(dynamic value) {
    if (value == null) return null;
    final String hex = value.toString().replaceFirst('#', '');
    try {
      if (hex.length == 6) {
        return Color(int.parse('FF$hex', radix: 16));
      } else if (hex.length == 8) {
        return Color(int.parse(hex, radix: 16));
      }
    } catch (e) {
      AppLogger.e('🎨 StacThemeWrapper: Failed to parse color $value', e);
    }
    return null;
  }
}
