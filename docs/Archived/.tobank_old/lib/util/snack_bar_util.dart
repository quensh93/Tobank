import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../widget/svg/svg_icon.dart';
import 'string_constants.dart';
import 'theme/theme_util.dart';

class SnackBarUtil {
  SnackBarUtil._();

  static void showSnackBar({
    required String title,
    required String message,
  }) {
    showSnackBarWidget(
      title: title,
      message: message,
      textColor: ThemeUtil.textSubtitleColor,
    );
  }

  static void showTimeOutSnackBar() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    showSnackBarWidget(
      title: locale.show_error(408),
      message: StringConstants.timeoutMessage,
      icon: SvgIcons.errorBoldCircle,
      textColor: const Color(0xfff63e50),
      subtitleColor: const Color(0xfff65b6a),
      borderColor: const Color(0xfff63e50).withOpacity(0.7),
    );
  }

  static void showNoInternetSnackBar() {
    showErrorSnackBar(StringConstants.noInternetMessage);
  }

  static void showExceptionErrorSnackBar(int? statusCode) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    showSnackBarWidget(
      title: locale.show_error(statusCode.toString() as int),
      message: StringConstants.exceptionMessage,
      textColor: ThemeUtil.textSubtitleColor,
    );
  }

  static void showNotEnoughWalletMoneySnackBar() {
    showWarningSnackBar(StringConstants.enoughMoneyMessage);
  }

  static void showRawSnackBar({
    required String message,
    SvgIcons icon = SvgIcons.infoBold,
    Color textColor = Colors.white,
    bool iconColorFilter = true,
    Color? borderColor,
  }) {
    Get.rawSnackbar(
        message: message,
        messageText: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              SvgIcon(
                icon,
                colorFilter: iconColorFilter ? ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn) : null,
              ),
              const SizedBox(width: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                    width: 1,
                    height: 24,
                    decoration: BoxDecoration(
                      color: borderColor ??
                          (Get.isDarkMode ? const Color(0xffd0d7dd) : const Color(0xff475467).withOpacity(0.4)),
                    )),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text(
                  message,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        borderRadius: 8.0,
        borderColor:
            borderColor ?? (Get.isDarkMode ? const Color(0xffd0d7dd) : const Color(0xff475467).withOpacity(0.4)),
        // Get.isDarkMode ? const Color(0xff344054) : const Color(0xffeaecf0),
        // borderWidth: 2.0,
        barBlur: Get.isDarkMode ? 4 : 12.0,
        margin: const EdgeInsets.only(bottom: 16, left: 16.0, right: 16.0),
        backgroundColor: Get.isDarkMode ? const Color(0xe11d2939) : const Color(0xa6ffffff));
  }

  static void showInfoSnackBar(String message) {
    showRawSnackBar(
      message: message,
      textColor: ThemeUtil.textSubtitleColor,
    );
  }

  static void showErrorSnackBar(String message) {
    showRawSnackBar(
      message: message,
      icon: SvgIcons.errorBoldCircle,
      textColor: const Color(0xfff63e50),
      iconColorFilter: false,
      borderColor: const Color(0xfff63e50).withOpacity(0.7),
    );
  }

  static void showWarningSnackBar(String message) {
    showRawSnackBar(
      message: message,
      icon: SvgIcons.warningBoldTriangle,
      textColor: Get.isDarkMode ? const Color(0xffeea12f) : const Color(0xffef8d32),
      iconColorFilter: false,
      borderColor: Get.isDarkMode ? const Color(0xffeea12f).withOpacity(0.7) : const Color(0xffef8d32).withOpacity(0.9),
    );
  }

  static void showSuccessSnackBar(String message) {
    showRawSnackBar(
      message: message,
      icon: SvgIcons.tickCircleGreen,
      textColor: const Color(0xff0cc28b),
      iconColorFilter: false,
      borderColor: const Color(0xff0cc28b).withOpacity(0.7),
    );
  }

  static void showSnackBarWidget({
    required String title,
    required String message,
    SvgIcons icon = SvgIcons.nullIcon,
    Color textColor = Colors.white,
    Color? subtitleColor,
    Color? borderColor,
  }) {
    Get.rawSnackbar(
        message: message,
        messageText: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              SvgIcon(
                icon == SvgIcons.nullIcon ? SvgIcons.infoBold : icon,
                colorFilter:
                    icon == SvgIcons.nullIcon ? ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn) : null,
              ),
              const SizedBox(width: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                    width: 1,
                    height: 32,
                    decoration: BoxDecoration(
                      color: borderColor ??
                          (Get.isDarkMode ? const Color(0xffd0d7dd) : const Color(0xff475467).withOpacity(0.4)),
                    )),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        message,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: subtitleColor ?? textColor.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        borderRadius: 8.0,
        borderColor:
            borderColor ?? (Get.isDarkMode ? const Color(0xffd0d7dd) : const Color(0xff475467).withOpacity(0.4)),
        barBlur: Get.isDarkMode ? 4 : 12.0,
        margin: const EdgeInsets.only(bottom: 16, left: 16.0, right: 16.0),
        backgroundColor: Get.isDarkMode ? const Color(0xe11d2939) : const Color(0xa6ffffff));
  }

  static void showErrorSnackBarWithTitle({
    required String title,
    required String message,
  }) {
    showSnackBarWidget(
      title: title,
      message: message,
      icon: SvgIcons.errorBoldCircle,
      textColor: const Color(0xfff63e50),
    );
  }
}
