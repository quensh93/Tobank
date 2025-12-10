import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

class ThemeSwitcherButton extends StatelessWidget {
  const ThemeSwitcherButton({
    required this.toggleThemeFunction,
    super.key,
  });

  final Function(String themeCode) toggleThemeFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Tooltip(
      preferBelow: true,
      message: locale.change_app_theme,
      child: IconButton(
        icon: context.isDarkMode ? const Icon(Icons.light_mode_outlined) : const Icon(Icons.dark_mode_outlined),
        onPressed: () => toggleThemeFunction(Get.isDarkMode ? locale.light : locale.dark),
      ),
    );
  }
}
