import 'package:flutter/material.dart';

class AppTextTheme {
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle labelSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;

  AppTextTheme({
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.labelSmall,
    required this.bodyLarge,
    required this.bodyMedium,
  });
}

class AppMainTheme {
  final Color primary;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color onTertiaryContainer;
  final Color surface;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color green;
  final Color white;
  final Color black;
  final Color staticWhite;
  final AppTextTheme textTheme;

  AppMainTheme({
    required this.primary,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.onTertiaryContainer,
    required this.surface,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.green,
    required this.white,
    required this.black,
    required this.textTheme,
    required this.staticWhite,
  });

  // Light theme
  factory AppMainTheme.light() {
    return AppMainTheme(
      primary: const Color(0xffD61F2C),
      onPrimaryContainer: const Color(0xffD61F2C).withAlpha(15),
      secondary: const Color(0xff00BABA),
      onSecondary: const Color(0xff66D6D6),
      secondaryContainer: const Color(0xff00BABA).withAlpha(10),
      tertiary: const Color(0xffF7941D),
      onTertiary: const Color(0xffFCB900),
      onTertiaryContainer: const Color(0xffFFF9EA),
      surface: const Color(0xffF9FAFB),
      onSurface: const Color(0xffEFEFEF),
      onSurfaceVariant: const Color(0xffE2E2E2),
      surfaceContainerLowest: const Color(0xffD9D9D9),
      surfaceContainerLow: const Color(0xff344054).withAlpha(35),
      surfaceContainer: const Color(0xff7D7D7D),
      surfaceContainerHigh: const Color(0xff344054),
      green: const Color(0xff039855),
      white: const Color(0xffFFFFFF),
      staticWhite: const Color(0xffFFFFFF),
      black: const Color(0xff101828),
      textTheme: AppTextTheme(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Color(0xff101828),
          fontSize: 16,
          fontFamily: 'IranYekan',
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Color(0xff101828),
          fontSize: 16,
          fontFamily: 'IranYekan',
        ),
        titleSmall: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xff101828),
          fontSize: 16,
          fontFamily: 'IranYekan',
        ),
        labelSmall: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xff101828),
          fontSize: 10,
          fontFamily: 'IranYekan',
        ),
        bodyLarge: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xff101828),
          fontSize: 14,
          fontFamily: 'IranYekan',
        ),
        bodyMedium: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xff101828),
          fontSize: 12,
          fontFamily: 'IranYekan',

        ),
      ),
    );
  }

  // Dark theme
  factory AppMainTheme.dark() {
    return AppMainTheme(
      primary: const Color(0xffD61F2C),
      onPrimaryContainer: const Color(0xffD61F2C).withAlpha(15),
      secondary: const Color(0xff00BABA),
      onSecondary: const Color(0xff66D6D6),
      secondaryContainer: const Color(0xff00BABA).withAlpha(10),
      tertiary: const Color(0xffF7941D),
      onTertiary: const Color(0xffFCB900),
      onTertiaryContainer: const Color(0xffFFF9EA),
      surface: const Color(0xff202633),
      onSurface: const Color(0xff7D7D7D),
      onSurfaceVariant: const Color(0xff7D7D7D),
      surfaceContainerLowest: const Color(0xff7D7D7D),
      surfaceContainerLow: const Color(0xff344054).withAlpha(35),
      surfaceContainer: const Color(0xffD9D9D9),
      surfaceContainerHigh: const Color(0xffD9D9D9),
      green: const Color(0xff039855),
      white: const Color(0xff101828),
      staticWhite:  const Color(0xffFFFFFF),
      black:  const Color(0xffFFFFFF),
      textTheme: AppTextTheme(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Color(0xffFFFFFF),
          fontSize: 16,
          fontFamily: 'IranYekan',
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Color(0xffFFFFFF),
          fontSize: 16,
          fontFamily: 'IranYekan',
        ),
        titleSmall: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xffFFFFFF),
          fontSize: 16,
          fontFamily: 'IranYekan',
        ),
        labelSmall: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xffFFFFFF),
          fontSize: 10,
          fontFamily: 'IranYekan',
        ),
        bodyLarge: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xffFFFFFF),
          fontSize: 14,
          fontFamily: 'IranYekan',
        ),
        bodyMedium: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xffFFFFFF),
          fontSize: 12,
          fontFamily: 'IranYekan',
        ),
      ),
    );
  }
}

class MainTheme extends InheritedWidget {
  final AppMainTheme theme;

  const MainTheme({
    required this.theme,
    required super.child,
    super.key,
  });

  static AppMainTheme of(BuildContext context) {
    final MainTheme? result = context.dependOnInheritedWidgetOfExactType<MainTheme>();
    assert(result != null, 'No CustomTheme found in context');
    return result!.theme;
  }

  @override
  bool updateShouldNotify(MainTheme oldWidget) {
    return theme != oldWidget.theme;
  }
}
