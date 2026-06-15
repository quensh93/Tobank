import 'package:flutter/material.dart';

import 'package:stac_core/stac_core.dart';

/// Service for handling navigation operations.
///
/// Follows Single Responsibility Principle - only responsible for navigation logic.
class StacNavigationService {
  StacNavigationService._();

  /// Performs navigation based on the provided navigation style.
  static Future<dynamic>? navigate<T extends Object?>({
    required BuildContext context,
    required NavigationStyle navigationStyle,
    Widget? widget,
    String? routeName,
    T? result,
    T? arguments,
  }) {
    switch (navigationStyle) {
      case NavigationStyle.push:
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => widget ?? const SizedBox()),
        );

      case NavigationStyle.pop:
        Navigator.pop(context, result);
        break;

      case NavigationStyle.pushReplacement:
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => widget ?? const SizedBox()),
          result: result,
        );

      case NavigationStyle.pushAndRemoveAll:
        return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => widget ?? const SizedBox()),
          ModalRoute.withName('/'),
        );

      case NavigationStyle.popAll:
        Navigator.popUntil(context, ModalRoute.withName('/'));
        break;

      case NavigationStyle.pushNamed:
        return Navigator.pushNamed(context, routeName!, arguments: arguments);

      case NavigationStyle.pushNamedAndRemoveAll:
        return Navigator.pushNamedAndRemoveUntil(
          context,
          routeName!,
          ModalRoute.withName('/'),
          arguments: arguments,
        );

      case NavigationStyle.pushReplacementNamed:
        return Navigator.pushReplacementNamed(
          context,
          routeName!,
          result: result,
          arguments: arguments,
        );
    }

    return null;
  }
}
