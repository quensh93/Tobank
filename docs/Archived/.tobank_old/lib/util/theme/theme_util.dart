import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../new_structure/core/theme/main_theme.dart';

class ThemeUtil {
  ThemeUtil._();

  static Color shadowColor = const Color(0x26000000);
  static Color homePageBackgroundLightColor = const Color(0xffdcfdff);
  static Color borderColor = const Color(0xffdcdcdc);
  static const Color hintColor = Color(0xff9eacba);

  static Color primaryColor = const Color(0xFFd61f2c);
  static const Color errorLightColor = Color(0xffd61f2c);
  static const Color errorDarkColor = Color(0xfff24a4d);

  static const Color successColor = Color(0xFF039855);
  static const Color failColor = Color(0xffc95e5e);
  static const Color warningColor = Color(0xFFf9a200);

  static BoxShadow getBoxShadow() {
    return BoxShadow(
        color: Get.isDarkMode ? Colors.transparent : ThemeUtil.shadowColor, offset: const Offset(0, 3), blurRadius: 9);
  }

  static ThemeData theme() {
    return FlexThemeData.light(
      textTheme: TextTheme(
        bodyLarge: AppMainTheme.light().textTheme.bodyLarge,
        bodyMedium: AppMainTheme.light().textTheme.bodyMedium,
        titleLarge: AppMainTheme.light().textTheme.titleLarge,
        titleMedium: AppMainTheme.light().textTheme.titleMedium,
        titleSmall: AppMainTheme.light().textTheme.titleSmall,
        labelSmall: AppMainTheme.light().textTheme.labelSmall,
      ),
      scheme: FlexScheme.greyLaw,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff37474f),
        onPrimary: Color(0xffffffff),
        secondary: Color(0xff00baba),
        onSecondary: Color(0xffffffff),
        error: errorLightColor,
        onError: Color(0xffffffff),
        surface: Color(0xfffafafc),
        onSurface: Color(0xff101828),

      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        useM2StyleDividerInM3: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      swapLegacyOnMaterial3: true,
      fontFamily: 'IranYekan',
    ).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFFd0d5dd)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFF344054)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: errorLightColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: errorLightColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFFd0d5dd)),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return FlexThemeData.dark(
      scheme: FlexScheme.greyLaw,
      textTheme: TextTheme(
        bodyLarge: AppMainTheme.dark().textTheme.bodyLarge,
        bodyMedium: AppMainTheme.dark().textTheme.bodyMedium,
        titleLarge: AppMainTheme.dark().textTheme.titleLarge,
        titleMedium:AppMainTheme.dark().textTheme.titleMedium,
        titleSmall: AppMainTheme.dark().textTheme.titleSmall,
        labelSmall: AppMainTheme.dark().textTheme.labelSmall,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xff90a4ae),
        onPrimary: Color(0xff0f1011),
        secondary: Color(0xff00baba),
        onSecondary: Color(0xfff3f3f6),
        error: errorDarkColor,
        onError: Color(0xff140c0d),
        surface: Color(0xff202633),
        onSurface: Color(0xffececec),
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useM2StyleDividerInM3: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      swapLegacyOnMaterial3: true,
      fontFamily: 'IranYekan',
    ).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFF77839b)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFFf9fafb)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: errorDarkColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: errorDarkColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFF77839b)),
        ),
      ),
    );
  }

  static TextStyle get titleStyle => TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: textTitleColor);

  static TextStyle get hintStyle => TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0, color: textHintColor);

  static Color get textTitleColor => Get.isDarkMode ? const Color(0xFFf9fafb) : const Color(0xFF101828);

  static Color get textSubtitleColor => Get.isDarkMode ? const Color(0xFFBFCCE0) : const Color(0xFF667085);

  static Color get textHintColor => Get.isDarkMode ? const Color(0xFF98a2b3) : const Color(0xFF667085);
}
