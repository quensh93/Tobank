import 'package:intl/intl.dart';

import 'data_constants.dart';
import 'persian_datepicker/persian_datetime.dart';

class DateConverterUtil {
  DateConverterUtil._();

  static String getStartOfYearJalali({String? gregorianDate}) {
    final PersianDateTime persianTime = PersianDateTime.fromGregorian(gregorianDateTime: gregorianDate);
    return '${persianTime.toJalaali(format: 'YYYY')}/01/01';
  }

  static String getEndOfYearJalali({String? gregorianDate}) {
    final PersianDateTime persianTime = PersianDateTime.fromGregorian(gregorianDateTime: gregorianDate);
    return '${persianTime.toJalaali(format: 'YYYY')}/12/30';
  }

  static String getDateJalali({String? gregorianDate}) {
    final PersianDateTime persianTime = PersianDateTime.fromGregorian(gregorianDateTime: gregorianDate);
    return persianTime.toJalaali();
  }

  static String getDateJalaliWithDayName({required String gregorianDate}) {
    final DateTime dateTime = DateTime.parse(gregorianDate);
    final PersianDateTime persianTime = PersianDateTime.fromGregorian(gregorianDateTime: gregorianDate);
    return '${DataConstants.weekDay[dateTime.weekday - 1]} ${persianTime.toJalaali()}';
  }

  static String getDateGregorian({String? jalaliDate}) {
    final PersianDateTime persianTime = PersianDateTime(jalaaliDateTime: jalaliDate);
    return persianTime.toGregorian();
  }

  static String getDateGregorianTransactionFilter({String? jalaliDate}) {
    final PersianDateTime persianTime = PersianDateTime(jalaaliDateTime: jalaliDate);
    final DateTime dateTime = persianTime.datetime;
    final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  static int getTimestampFromJalali({required String date, required Duration? extendDuration}) {
    final PersianDateTime persianDateTime = PersianDateTime(jalaaliDateTime: date);
    DateTime dateTime = persianDateTime.datetime;
    if (extendDuration != null) {
      // this is becuase Iran timezone offset
      dateTime = dateTime.add(extendDuration);
    }
    return dateTime.millisecondsSinceEpoch;
  }

  static String getJalaliFromTimestamp(int timestampDate) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampDate);
    final PersianDateTime persianDateTime =
        PersianDateTime.fromGregorian(gregorianDateTime: dateTime.toIso8601String().split('T')[0]);
    return '${persianDateTime.jalaaliDay} ${persianDateTime.jalaaliMonthName} ${persianDateTime.jalaaliYear}';
  }

  static String? getJalaliFromTimestampNano(int timestampDate) {
    final int timestampMilliSecond = timestampDate ~/ 1000000;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampMilliSecond);
    final PersianDateTime persianDateTime =
        PersianDateTime.fromGregorian(gregorianDateTime: dateTime.toIso8601String().split('T')[0]);
    return persianDateTime.toJalaali();
  }

  static String getPersianDateFromTimestampNano(int timestampDate) {
    final int timestampMilliSecond = timestampDate ~/ 1000000;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampMilliSecond);
    return DateFormat('HH:mm').format(dateTime);
  }

  static String getJalaliFromTimestampNanoMonthName(int timestampDate) {
    final int timestampMilliSecond = timestampDate ~/ 1000000;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampMilliSecond);
    final PersianDateTime persianDateTime =
        PersianDateTime.fromGregorian(gregorianDateTime: dateTime.toIso8601String().split('T')[0]);
    return '${persianDateTime.jalaaliDay} ${persianDateTime.jalaaliMonthName} ${persianDateTime.jalaaliYear}';
  }

  static String getJalaliFromTimestampCode(int timestampDate) {
    final int timestampMilliSecond = timestampDate ~/ 1000;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampMilliSecond);
    final PersianDateTime persianDateTime =
        PersianDateTime.fromGregorian(gregorianDateTime: dateTime.toIso8601String().split('T')[0]);
    return persianDateTime.toJalaali();
  }

  static String getExpireDateFromTimestamp(String timestampDate) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestampDate));
    final PersianDateTime persianDateTime =
        PersianDateTime.fromGregorian(gregorianDateTime: dateTime.toIso8601String().split('T')[0]);
    return persianDateTime.toJalaali(format: 'YYMM');
  }

  static String getJalaliDateTimeFromTimestamp(int timestampDate) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampDate);
    final PersianDateTime persianDateTime =
        PersianDateTime.fromGregorian(gregorianDateTime: dateTime.toIso8601String().split('T')[0]);
    return '${DateFormat('HH:mm').format(dateTime)} - ${persianDateTime.toJalaali()}';
  }

  static String getDibaliteDateFromMilisecondsTimestamp(int timestampDate) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampDate);
    final PersianDateTime persianDateTime =
        PersianDateTime.fromGregorian(gregorianDateTime: dateTime.toIso8601String().split('T')[0]);
    return persianDateTime.toJalaali(format: 'YYYY-MM-DD');
  }
}
