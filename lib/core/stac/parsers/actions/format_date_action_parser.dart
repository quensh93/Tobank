import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../builders/format_date_action.dart';

class FormatDateActionParser extends StacActionParser<StacFormatDateAction> {
  const FormatDateActionParser();

  @override
  String get actionType => 'formatDate';

  @override
  StacFormatDateAction getModel(Map<String, dynamic> json) =>
      StacFormatDateAction.fromJson(json);

  @override
  FutureOr<dynamic> onCall(
    BuildContext context,
    StacFormatDateAction model, [
    Map<String, dynamic>? arguments,
  ]) {
    final value = StacRegistry.instance.getValue(model.sourceKey);
    final String s = value?.toString() ?? '';

    String formattedString = s;
    if (s.isNotEmpty) {
      try {
        final parsedDate = DateTime.parse(s);
        final jalaliDate = Jalali.fromDateTime(parsedDate);

        final String y = jalaliDate.year.toString();
        final String m = jalaliDate.month.toString().padLeft(2, '0');
        final String d = jalaliDate.day.toString().padLeft(2, '0');
        final String h = jalaliDate.hour.toString().padLeft(2, '0');
        final String min = jalaliDate.minute.toString().padLeft(2, '0');

        formattedString = '$y/$m/$d $h:$min';
      } catch (_) {
        // Fallback to original string if parsing fails
      }
    }

    StacRegistry.instance.setValue(model.destinationKey, formattedString);
    return null;
  }
}
