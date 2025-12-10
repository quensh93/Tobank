import 'package:flutter/material.dart';

import '../../../model/sim_charge/response/charge_static_data.dart';
import '../../../util/theme/theme_util.dart';

class SimChargeTypeItemWidget extends StatelessWidget {
  const SimChargeTypeItemWidget({
    required this.chargeTypeData,
    required this.returnDataFunction,
    super.key,
    this.chargeTypeDataSelected,
  });

  final PlanDatum? chargeTypeDataSelected;
  final PlanDatum chargeTypeData;
  final Function(PlanDatum chargeTypeData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        returnDataFunction(chargeTypeData);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(chargeTypeData.title!,
            style: TextStyle(
              color: chargeTypeDataSelected != null && chargeTypeDataSelected!.value == chargeTypeData.value
                  ? ThemeUtil.textTitleColor
                  : ThemeUtil.textSubtitleColor,
              fontWeight: chargeTypeDataSelected != null && chargeTypeDataSelected!.value == chargeTypeData.value
                  ? FontWeight.w900
                  : FontWeight.w500,
              fontSize: 16.0,
            )),
      ),
    );
  }
}
