import 'package:flutter/material.dart';

import '../../../../../model/bpms/enum_value_data.dart';
import '../../../../../util/theme/theme_util.dart';

class EmploymentTypeItemWidget extends StatelessWidget {
  const EmploymentTypeItemWidget({
    required this.militaryGuaranteeEmploymentData,
    required this.returnDataFunction,
    super.key,
    this.selectedMilitaryGuaranteeJobData,
  });

  final EnumValue militaryGuaranteeEmploymentData;
  final EnumValue? selectedMilitaryGuaranteeJobData;
  final Function(EnumValue selectedEmploymentType) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        returnDataFunction(militaryGuaranteeEmploymentData);
      },
      child: Container(
        height: 48.0,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          onTap: () {
            returnDataFunction(militaryGuaranteeEmploymentData);
          },
          child: Center(
            child: Text(
              militaryGuaranteeEmploymentData.title,
              style: TextStyle(
                color: ThemeUtil.textSubtitleColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
