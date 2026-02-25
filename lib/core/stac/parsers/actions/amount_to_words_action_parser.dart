import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../builders/amount_to_words_action.dart';
import '../../utils/registry_notifier.dart';

class AmountToWordsActionParser
    extends StacActionParser<StacAmountToWordsAction> {
  const AmountToWordsActionParser();

  @override
  String get actionType => 'amountToWords';

  @override
  StacAmountToWordsAction getModel(Map<String, dynamic> json) =>
      StacAmountToWordsAction.fromJson(json);

  @override
  FutureOr<dynamic> onCall(
    BuildContext context,
    StacAmountToWordsAction model, [
    Map<String, dynamic>? arguments,
  ]) {
    final rawValue = StacRegistry.instance.getValue(model.sourceKey)?.toString() ?? '';
    final digits = rawValue.replaceAll(RegExp(r'[^0-9]'), '');

    var output = '';
    if (digits.length >= model.minDigits) {
      final amountRial = BigInt.tryParse(digits);
      if (amountRial != null) {
        final divisor = BigInt.from(model.divideBy <= 0 ? 10 : model.divideBy);
        final amountInTargetUnit = amountRial ~/ divisor;
        if (amountInTargetUnit > BigInt.zero) {
          final words = _numberToPersianWords(amountInTargetUnit);
          output = words.isEmpty ? '' : '$words ${model.suffix}'.trim();
        }
      }
    }

    StacRegistry.instance.setValue(model.destinationKey, output);
    RegistryNotifier.instance.notify();
    return null;
  }

  String _numberToPersianWords(BigInt number) {
    if (number == BigInt.zero) return 'صفر';

    const scales = <String>[
      '',
      'هزار',
      'میلیون',
      'میلیارد',
      'تریلیون',
      'کوادریلیون',
    ];

    final parts = <String>[];
    var groupIndex = 0;
    var remaining = number;

    while (remaining > BigInt.zero) {
      final groupValue = (remaining % BigInt.from(1000)).toInt();
      if (groupValue > 0) {
        var groupWords = _threeDigitsToWords(groupValue);
        if (groupIndex < scales.length && scales[groupIndex].isNotEmpty) {
          groupWords = '$groupWords ${scales[groupIndex]}';
        }
        parts.insert(0, groupWords);
      }
      remaining = remaining ~/ BigInt.from(1000);
      groupIndex++;
    }

    return parts.join(' و ');
  }

  String _threeDigitsToWords(int number) {
    const ones = <String>[
      '',
      'یک',
      'دو',
      'سه',
      'چهار',
      'پنج',
      'شش',
      'هفت',
      'هشت',
      'نه',
    ];
    const teens = <String>[
      'ده',
      'یازده',
      'دوازده',
      'سیزده',
      'چهارده',
      'پانزده',
      'شانزده',
      'هفده',
      'هجده',
      'نوزده',
    ];
    const tens = <String>[
      '',
      '',
      'بیست',
      'سی',
      'چهل',
      'پنجاه',
      'شصت',
      'هفتاد',
      'هشتاد',
      'نود',
    ];
    const hundreds = <String>[
      '',
      'صد',
      'دویست',
      'سیصد',
      'چهارصد',
      'پانصد',
      'ششصد',
      'هفتصد',
      'هشتصد',
      'نهصد',
    ];

    final segments = <String>[];
    final h = number ~/ 100;
    final rest = number % 100;

    if (h > 0) {
      segments.add(hundreds[h]);
    }

    if (rest >= 20) {
      final t = rest ~/ 10;
      final o = rest % 10;
      segments.add(tens[t]);
      if (o > 0) {
        segments.add(ones[o]);
      }
    } else if (rest >= 10) {
      segments.add(teens[rest - 10]);
    } else if (rest > 0) {
      segments.add(ones[rest]);
    }

    return segments.join(' و ');
  }
}
