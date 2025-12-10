import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/safe_box/response/visit_date_time_list_response_data.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';

class VisitDateItemWidget extends StatelessWidget {
  const VisitDateItemWidget({
    required this.visitDateTime,
    required this.index,
    required this.returnSelectedFunction,
    super.key,
    this.selectedDate,
  });

  final VisitDateTime visitDateTime;
  final int? selectedDate;
  final int index;
  final Function(int index) returnSelectedFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: index == selectedDate ? context.theme.colorScheme.secondary.withOpacity(0.15) : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: index == selectedDate ? context.theme.colorScheme.secondary : context.theme.dividerColor,
            )),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onTap: () {
            returnSelectedFunction(index);
          },
          child: Center(
            child: Text(
              DateConverterUtil.getDateJalaliWithDayName(
                gregorianDate: visitDateTime.date!,
              ),
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}
