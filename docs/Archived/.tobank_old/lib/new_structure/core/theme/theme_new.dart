import 'package:flutter/material.dart';

// Text theme for custom typography
class CustomTextTheme {
  final TextStyle headline1;
  final TextStyle headline2;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle caption;
  final TextStyle button;

  CustomTextTheme({
    required this.headline1,
    required this.headline2,
    required this.body1,
    required this.body2,
    required this.caption,
    required this.button,
  });
}

// Custom theme class, separate from Material Theme
class CustomAppTheme {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final CustomTextTheme textTheme;

  CustomAppTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.textTheme,
  });

  // Light theme
  factory CustomAppTheme.light() {
    return CustomAppTheme(
      primaryColor: Colors.teal,
      secondaryColor: Colors.pink,
      backgroundColor: Colors.grey[100]!,
      textTheme: CustomTextTheme(
        headline1: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline2: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        body1: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.red,
        ),
        body2: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
        ),
        caption: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
        button: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Dark theme
  factory CustomAppTheme.dark() {
    return CustomAppTheme(
      primaryColor: Colors.tealAccent,
      secondaryColor: Colors.pinkAccent,
      backgroundColor: Colors.grey[900]!,
      textTheme: CustomTextTheme(
        headline1: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline2: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
        ),
        body1: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.green,
        ),
        body2: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white60,
        ),
        caption: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
        button: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

// InheritedWidget for custom theme
class CustomTheme extends InheritedWidget {
  final CustomAppTheme theme;

  const CustomTheme({
    super.key,
    required this.theme,
    required super.child,
  });

  static CustomAppTheme of(BuildContext context) {
    final CustomTheme? result = context.dependOnInheritedWidgetOfExactType<CustomTheme>();
    assert(result != null, 'No CustomTheme found in context');
    return result!.theme;
  }

  @override
  bool updateShouldNotify(CustomTheme oldWidget) => theme != oldWidget.theme;
}