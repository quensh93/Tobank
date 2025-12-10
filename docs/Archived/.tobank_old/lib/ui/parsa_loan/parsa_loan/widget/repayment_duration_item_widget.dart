import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/micro_lending/loan_detail.dart';
import '../../../../../util/theme/theme_util.dart';

class RepaymentDurationItemWidget extends StatelessWidget {
  const RepaymentDurationItemWidget({
    required this.duration,
    required this.selectedDuration,
    required this.returnSelectedFunction,
    super.key,
  });

  final MicroLendingDurationOption duration;
  final MicroLendingDurationOption? selectedDuration;
  final Function(MicroLendingDurationOption) returnSelectedFunction;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = duration == selectedDuration;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          returnSelectedFunction(duration);
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: isSelected ? context.theme.colorScheme.secondary.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? context.theme.colorScheme.secondary : context.theme.disabledColor,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
          child: Center(
            child: Text(
              duration.faTitle!,
              style: TextStyle(
                color: isSelected ? context.theme.colorScheme.secondary : ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
