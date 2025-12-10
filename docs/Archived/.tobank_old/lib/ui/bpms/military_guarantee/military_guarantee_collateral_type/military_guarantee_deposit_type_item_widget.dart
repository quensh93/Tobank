import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/bpms/military_guarantee/military_guarantee_deposit_type_data.dart';
import '../../../../../util/theme/theme_util.dart';

class MilitaryGuaranteeDepositTypeItemWidget extends StatelessWidget {
  const MilitaryGuaranteeDepositTypeItemWidget({
    required this.militaryGuaranteeDepositTypeData,
    required this.returnDataFunction,
    super.key,
    this.selectedMilitaryGuaranteeDepositTypeData,
  });

  final MilitaryGuaranteeDepositTypeData militaryGuaranteeDepositTypeData;
  final MilitaryGuaranteeDepositTypeData? selectedMilitaryGuaranteeDepositTypeData;
  final Function(MilitaryGuaranteeDepositTypeData deposit) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selectedMilitaryGuaranteeDepositTypeData != null &&
                      militaryGuaranteeDepositTypeData.id == selectedMilitaryGuaranteeDepositTypeData!.id
                  ? context.theme.colorScheme.secondary
                  : context.theme.dividerColor,
            ),
          ),
          child: InkWell(
            onTap: () {
              returnDataFunction(militaryGuaranteeDepositTypeData);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          militaryGuaranteeDepositTypeData.title,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                            height: 1.4,
                          ),
                        ),
                      ),
                      Radio(
                          activeColor: context.theme.colorScheme.secondary,
                          value: militaryGuaranteeDepositTypeData,
                          groupValue: selectedMilitaryGuaranteeDepositTypeData,
                          onChanged: (MilitaryGuaranteeDepositTypeData? militaryGuaranteeDepositTypeData) {
                            returnDataFunction(militaryGuaranteeDepositTypeData!);
                          }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(thickness: 1),
                  const SizedBox(height: 16),
                  Text(
                    militaryGuaranteeDepositTypeData.description,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
