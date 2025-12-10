import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/gift_card/response/list_delivery_date_data.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/theme/theme_util.dart';

class GiftCardItemDateWidget extends StatelessWidget {
  const GiftCardItemDateWidget({
    required this.deliveryDate,
    required this.index,
    required this.returnSelectedFunction,
    super.key,
    this.selectedDate,
  });

  final DeliveryDate deliveryDate;
  final int? selectedDate;
  final int index;
  final Function(int index) returnSelectedFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: index == selectedDate ? context.theme.colorScheme.secondary.withOpacity(0.15) : Colors.transparent,
          border: Border.all(
              color: index == selectedDate ? context.theme.colorScheme.secondary : context.theme.dividerColor),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            returnSelectedFunction(index);
          },
          child: Center(
            child: Text(
              DateConverterUtil.getDateJalaliWithDayName(
                gregorianDate: deliveryDate.deliveryDate!,
              ),
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}
