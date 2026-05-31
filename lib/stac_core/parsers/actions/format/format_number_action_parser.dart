import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import './format_number_action.dart';

class FormatNumberActionParser
    extends StacActionParser<StacFormatNumberAction> {
  const FormatNumberActionParser();

  @override
  String get actionType => 'formatNumber';

  @override
  StacFormatNumberAction getModel(Map<String, dynamic> json) =>
      StacFormatNumberAction.fromJson(json);

  @override
  FutureOr<dynamic> onCall(
    BuildContext context,
    StacFormatNumberAction model, [
    Map<String, dynamic>? arguments,
  ]) {
    final value = StacRegistry.instance.getValue(model.sourceKey);
    final String s = (value?.toString() ?? '').replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    String formattedString = '0';
    if (s.isNotEmpty) {
      final buffer = StringBuffer();
      var count = 0;
      for (var i = s.length - 1; i >= 0; i--) {
        buffer.write(s[i]);
        count++;
        if (i > 0 && count % 3 == 0) {
          buffer.write(',');
        }
      }
      formattedString = buffer.toString().split('').reversed.join();
    }

    StacRegistry.instance.setValue(model.destinationKey, formattedString);
    return null;
  }
}
