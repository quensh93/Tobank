import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/sim_charge/charge_amount_data.dart';
import '../../../util/theme/theme_util.dart';

class SimChargeAmountItemWidget extends StatelessWidget {
  const SimChargeAmountItemWidget({
    required this.chargeAmountData,
    required this.returnDataFunction,
    super.key,
    this.selectedChargeAmountData,
  });

  final ChargeAmountData? selectedChargeAmountData;
  final ChargeAmountData chargeAmountData;
  final Function(ChargeAmountData chargeAmountData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
      onTap: () {
        returnDataFunction(chargeAmountData);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: selectedChargeAmountData != null && chargeAmountData.amountId == selectedChargeAmountData!.amountId
                ? context.theme.colorScheme.secondary
                : context.theme.dividerColor,
          ),
          color: selectedChargeAmountData != null && chargeAmountData.amountId == selectedChargeAmountData!.amountId
              ? context.theme.colorScheme.secondary.withOpacity(0.15)
              : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Center(
            child: Text(
              chargeAmountData.title,
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
