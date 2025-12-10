import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/safe_box/response/refer_date_time_list_response_data.dart';
import '../../../../../util/theme/theme_util.dart';

class ReferTimeItemWidget extends StatelessWidget {
  const ReferTimeItemWidget({
    required this.referTime,
    required this.value,
    required this.selectedTime,
    required this.onChanged,
    super.key,
  });

  final int? selectedTime;
  final int value;
  final ValueChanged<int?> onChanged;
  final Time? referTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: selectedTime == referTime!.id
              ? context.theme.colorScheme.secondary.withOpacity(0.15)
              : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedTime == referTime!.id ? context.theme.colorScheme.secondary : context.theme.dividerColor,
          )),
      child: InkWell(
        onTap: () {
          onChanged(value);
        },
        borderRadius: BorderRadius.circular(80.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Text(
            '${referTime!.fromHour} - ${referTime!.toHour}',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: ThemeUtil.textTitleColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
