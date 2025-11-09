import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  /// Get the current theme
  ThemeData get theme => Theme.of(this);

  /// Get the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get the text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get the media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get the screen size
  Size get screenSize => mediaQuery.size;

  /// Get the screen width
  double get screenWidth => screenSize.width;

  /// Get the screen height
  double get screenHeight => screenSize.height;

  /// Get the status bar height
  double get statusBarHeight => mediaQuery.padding.top;

  /// Get the bottom padding
  double get bottomPadding => mediaQuery.padding.bottom;

  /// Get the device pixel ratio
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Check if the device is in dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Check if the device is in light mode
  bool get isLightMode => theme.brightness == Brightness.light;

  /// Check if the current orientation is landscape
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Check if the current orientation is portrait
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Show a snackbar with a message
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show an error snackbar
  void showError(String message) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.error,
      textColor: colorScheme.onError,
    );
  }

  /// Show a success snackbar
  void showSuccess(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
    );
  }

  /// Pop the current route
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Push a named route
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Push and replace the current route
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.of(this).pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Push and remove all routes
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }
}
