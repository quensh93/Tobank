import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
extension StringExt on int {
  String getMonthName(bool isJalali) {
    if (isJalali) {
      return jalaliMonthName;
    } else {
      return gregorianMonthName;
    }
  }

  String get jalaliMonthName {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    switch (this) {
      case 1:
        return locale.farvardin;
      case 2:
        return locale.ordibehesht;

      case 3:
        return locale.khordad;

      case 4:
        return locale.tir;

      case 5:
        return locale.mordad;

      case 6:
        return locale.shahrivar;

      case 7:
        return locale.mehr;

      case 8:
        return locale.aban;
      case 9:
        return locale.azar;

      case 10:
        return locale.dey;
      case 11:
        return locale.bahman;
      case 12:
        return locale.esfand;
      default:
        return '$this';
    }
  }

  String get gregorianMonthName {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    switch (this) {
      case 1:
        return locale.january;
      case 2:
        return locale.february;
      case 3:
        return locale.march;

      case 4:
        return locale.april;

      case 5:
        return locale.may;

      case 6:
        return locale.june;

      case 7:
        return locale.july;

      case 8:
        return locale.august;

      case 9:
        return locale.september;

      case 10:
        return locale.october;

      case 11:
        return locale.november;

      case 12:
        return locale.december;

      default:
        return '$this';
    }
  }
}
