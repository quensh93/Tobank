import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/bpms/parsa_loan/averaging_period_filter_data.dart';
import '../../../../../util/theme/theme_util.dart';

class AveragingPeriodFilterItemWidget extends StatelessWidget {
  const AveragingPeriodFilterItemWidget({
    required this.averagingPeriodFilterData,
    required this.selectedAveragingPeriodFilterData,
    required this.returnDataFunction,
    required this.isEnable,
    super.key,
  });

  final AveragingPeriodFilterData averagingPeriodFilterData;
  final AveragingPeriodFilterData? selectedAveragingPeriodFilterData;
  final Function(AveragingPeriodFilterData averagingPeriodFilterData) returnDataFunction;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selectedAveragingPeriodFilterData == averagingPeriodFilterData
            ? context.theme.colorScheme.secondary.withOpacity(0.3)
            : Colors.transparent,
        border: Border.all(
          color: selectedAveragingPeriodFilterData == averagingPeriodFilterData
              ? context.theme.colorScheme.secondary
              : isEnable
                  ? context.theme.dividerColor
                  : context.theme.disabledColor,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          if (isEnable) {
            returnDataFunction(averagingPeriodFilterData);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Center(
            child: Text(
              averagingPeriodFilterData.title!,
              style: TextStyle(
                color: isEnable ? ThemeUtil.textTitleColor : context.theme.disabledColor,
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
