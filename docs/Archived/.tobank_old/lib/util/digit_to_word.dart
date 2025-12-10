import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
enum StrType { numWord, strWord }

class DigitToWord {
  DigitToWord._();

  static String toWord(String? number, StrType type,
      {String separator = ',', bool isMoney = false, String biggerThanCapacity = 'طول عدد باید کمتر از 16 رقم باشد.'}) {
    String words = '';
    String result = '';

    if (number == null || number == '') {
      return '';
    }
    if (number.length >= 15) {
      return biggerThanCapacity;
    }

    ///remove separator ','  symbol of text
    final String numInt = number.replaceAll(separator, '');

    switch (type) {
      case StrType.numWord:
        words = _NumWord.toWord(numInt, isMoney);
        break;
      case StrType.strWord:
        words = _StrWord.toWord(numInt, isMoney);
        break;
    }

    result = words.replaceAll('^\\s+', '').replaceAll('\\b\\s{2,}\\b', ' ');

    return result.trim();
  }
}

class _NumWord {
  _NumWord._();

  static String toWord(String inputNumber, bool isMoney) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    try {
      final int number = int.parse(inputNumber);
      if (number == 0) {
        return locale.zero;
      }
      String fullNumber = inputNumber;
      for (var i = 0; i < 15 - fullNumber.length; i++) {
        inputNumber = '0$inputNumber';
      }
      fullNumber = inputNumber;

      final int trillion = int.parse(fullNumber.substring(0, 3));
      final int billions = int.parse(fullNumber.substring(3, 6));
      final int millions = int.parse(fullNumber.substring(6, 9));
      final int hundredThousands = int.parse(fullNumber.substring(9, 12));
      final int thousands = int.parse(fullNumber.substring(12, 15));

      String checkTrillion;

      switch (trillion) {
        case 0:
          checkTrillion = '';
          break;
        default:
          checkTrillion = '$trillion' + locale.trillion_and;
      }
      String result = checkTrillion;

      String checkBillions;

      switch (billions) {
        case 0:
          checkBillions = '';
          break;
        default:
          checkBillions = '$billions' + locale.billion_and;
      }
      result += checkBillions;

      String checkMillions;

      switch (millions) {
        case 0:
          checkMillions = '';
          break;
        default:
          checkMillions = '$millions' + locale.million_and;
      }
      result = result + checkMillions;

      String checkHundredThousands;
      switch (hundredThousands) {
        case 0:
          checkHundredThousands = '';
          break;
        default:
          checkHundredThousands = '$hundredThousands' + locale.thousand_and;
      }
      result = result + checkHundredThousands;

      if (thousands == 0 && result.endsWith(' و ')) {
        result = result.substring(0, result.length - 2);
      }
      String checkThousand;
      switch (thousands) {
        case 0:
          checkThousand = '';
          break;
        default:
          checkThousand = '$thousands';
      }

      result = result + checkThousand;

      return isMoney ? '$result ${locale.toman}' : result;
    } on FormatException catch (_) {
      return locale.wrong_entry_format;
    }
  }
}

class _StrWord {
  _StrWord._();

  static String toWord(String inputNumber, bool isMoney) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    try {
      final int number = int.parse(inputNumber);
      if (number == 0) {
        return locale.zero;
      }
      String fullNumber = inputNumber;
      for (var i = 0; i < 15 - fullNumber.length; i++) {
        inputNumber = '0$inputNumber';
      }
      fullNumber = inputNumber;

      final int trillion = int.parse(fullNumber.substring(0, 3));
      final int billions = int.parse(fullNumber.substring(3, 6));
      final int millions = int.parse(fullNumber.substring(6, 9));
      final int hundredThousands = int.parse(fullNumber.substring(9, 12));
      final int thousands = int.parse(fullNumber.substring(12, 15));

      String checkTrillion;

      switch (trillion) {
        case 0:
          checkTrillion = '';
          break;
        case 1:
          checkTrillion = '${_convertNum(trillion)} ${locale.trillion} ';
          break;
        default:
          checkTrillion = '${_convertNum(trillion)} ${locale.trillion_and} ';
      }
      String result = checkTrillion;

      String checkBillions;

      switch (billions) {
        case 0:
          checkBillions = '';
          break;
        default:
          checkBillions = '${_convertNum(billions)} ${locale.billion_and} ';
      }
      result += checkBillions;

      String checkMillions;

      switch (millions) {
        case 0:
          checkMillions = '';
          break;
        default:
          checkMillions = '${_convertNum(millions)} ${locale.million_and}';
      }
      result = result + checkMillions;

      String checkHundredThousands;
      switch (hundredThousands) {
        case 0:
          checkHundredThousands = '';
          break;
        case 1:
          checkHundredThousands = locale.thousand_and;
          break;
        default:
          checkHundredThousands = '${_convertNum(hundredThousands)} ${locale.thousand_and}';
      }
      result = result + checkHundredThousands;

      String checkThousand;
      checkThousand = _convertNum(thousands);
      result = result + checkThousand;

      if (result.endsWith(' و ')) {
        result = result.substring(0, result.length - 2);
      }

      return isMoney ? '$result ${locale.toman}' : result;
    } on FormatException catch (_) {
      return locale.wrong_entry_format;
    }
  }

  static String _convertNum(int number) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<String> tensNames = [
      '',
      ' ${locale.ten} و',
      ' ${locale.twenty} و',
      ' ${locale.thirty} و',
      ' ${locale.forty} و',
      ' ${locale.fifty} و',
      ' ${locale.sixty} و',
      ' ${locale.seventy} و',
      ' ${locale.eighty} و',
      ' ${locale.ninety} و'
    ];

    final List<String> numNames = [
      '',
      ' ${locale.one}',
      ' ${locale.two}',
      ' ${locale.three}',
      ' ${locale.four}',
      ' ${locale.five}',
      ' ${locale.six}',
      ' ${locale.seven}',
      ' ${locale.eight}',
      ' ${locale.nine}',
      ' ${locale.ten}',
      ' ${locale.eleven}',
      ' ${locale.twelve}',
      ' ${locale.thirteen}',
      ' ${locale.fourteen}',
      ' ${locale.fifteen}',
      ' ${locale.sixteen}',
      ' ${locale.seventeen}',
      ' ${locale.eighteen}',
      ' ${locale.nineteen}'
    ];

    final List<String> thousandsNames = [
      '',
      ' ${locale.hundred} و',
      ' ${locale.two_hundred} و',
      ' ${locale.three_hundred} و',
      ' ${locale.four_hundred} و',
      ' ${locale.five_hundred} و',
      ' ${locale.six_hundred} و',
      ' ${locale.seven_hundred} و',
      ' ${locale.eight_hundred} و',
      ' ${locale.nine_hundred} و'
    ];
    String soFar;
    if (number % 100 < 20) {
      soFar = numNames[number % 100];
      number = number ~/ 100;
    } else {
      soFar = numNames[number % 10];
      number = number ~/ 10;
      soFar = tensNames[number % 10] + soFar;
      number = number ~/ 10;
    }
    if (number == 0) {
      if (soFar.endsWith(' و ')) {
        soFar = soFar.substring(0, soFar.length - 2);
      }
      return soFar;
    }
    var str = '';
    str = (thousandsNames[number] + soFar);
    if (str.endsWith(' و ') || str.endsWith('و ')) {
      str = str.substring(0, str.length - 2);
    }
    return str;
  }
}
