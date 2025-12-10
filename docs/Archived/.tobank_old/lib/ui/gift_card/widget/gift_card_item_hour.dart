import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/gift_card/response/list_delivery_date_data.dart';
import '../../../util/theme/theme_util.dart';

class GiftCardItemHourWidget extends StatelessWidget {
  const GiftCardItemHourWidget({
    required this.deliveryTime,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  final int? groupValue;
  final int value;
  final ValueChanged<int?> onChanged;
  final DeliveryTime? deliveryTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        if (value != groupValue) onChanged(value);
      },
      child: Container(
        decoration: BoxDecoration(
            color: value == groupValue ? context.theme.colorScheme.secondary.withOpacity(0.15) : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: value == groupValue ? context.theme.colorScheme.secondary : context.theme.dividerColor,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Text(
            '${deliveryTime!.fromHour} - ${deliveryTime!.toHour}',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: ThemeUtil.textTitleColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
