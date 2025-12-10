import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/bpms/select_promissory_collateral_data.dart';
import '../../../../util/theme/theme_util.dart';

class SelectCollateralPromissoryItemWidget extends StatelessWidget {
  const SelectCollateralPromissoryItemWidget({
    required this.selectPromissoryCollateralData,
    required this.returnDataFunction,
    super.key,
  });

  final SelectPromissoryCollateralData selectPromissoryCollateralData;
  final Function(SelectPromissoryCollateralData selectPromissoryCollateralData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          onTap: () {
            returnDataFunction(selectPromissoryCollateralData);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Text(
              selectPromissoryCollateralData.title,
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
