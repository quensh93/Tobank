import 'package:stac/stac.dart';

extension StringExt on int {
  String getMonthName(bool isJalali) {
    if (isJalali) {
      return jalaliMonthName;
    } else {
      return gregorianMonthName;
    }
  }

  String get jalaliMonthName {
    // Get month names from StacRegistry
    final registry = StacRegistry.instance;
    
    switch (this) {
      case 1:
        return registry.getValue('appStrings.months.farvardin')?.toString() ?? 'فروردین';
      case 2:
        return registry.getValue('appStrings.months.ordibehesht')?.toString() ?? 'اردیبهشت';
      case 3:
        return registry.getValue('appStrings.months.khordad')?.toString() ?? 'خرداد';
      case 4:
        return registry.getValue('appStrings.months.tir')?.toString() ?? 'تیر';
      case 5:
        return registry.getValue('appStrings.months.mordad')?.toString() ?? 'مرداد';
      case 6:
        return registry.getValue('appStrings.months.shahrivar')?.toString() ?? 'شهریور';
      case 7:
        return registry.getValue('appStrings.months.mehr')?.toString() ?? 'مهر';
      case 8:
        return registry.getValue('appStrings.months.aban')?.toString() ?? 'آبان';
      case 9:
        return registry.getValue('appStrings.months.azar')?.toString() ?? 'آذر';
      case 10:
        return registry.getValue('appStrings.months.dey')?.toString() ?? 'دی';
      case 11:
        return registry.getValue('appStrings.months.bahman')?.toString() ?? 'بهمن';
      case 12:
        return registry.getValue('appStrings.months.esfand')?.toString() ?? 'اسفند';
      default:
        return '$this';
    }
  }

  String get gregorianMonthName {
    // Get month names from StacRegistry
    final registry = StacRegistry.instance;
    
    switch (this) {
      case 1:
        return registry.getValue('appStrings.months.january')?.toString() ?? 'January';
      case 2:
        return registry.getValue('appStrings.months.february')?.toString() ?? 'February';
      case 3:
        return registry.getValue('appStrings.months.march')?.toString() ?? 'March';
      case 4:
        return registry.getValue('appStrings.months.april')?.toString() ?? 'April';
      case 5:
        return registry.getValue('appStrings.months.may')?.toString() ?? 'May';
      case 6:
        return registry.getValue('appStrings.months.june')?.toString() ?? 'June';
      case 7:
        return registry.getValue('appStrings.months.july')?.toString() ?? 'July';
      case 8:
        return registry.getValue('appStrings.months.august')?.toString() ?? 'August';
      case 9:
        return registry.getValue('appStrings.months.september')?.toString() ?? 'September';
      case 10:
        return registry.getValue('appStrings.months.october')?.toString() ?? 'October';
      case 11:
        return registry.getValue('appStrings.months.november')?.toString() ?? 'November';
      case 12:
        return registry.getValue('appStrings.months.december')?.toString() ?? 'December';
      default:
        return '$this';
    }
  }
}

