import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/pichak/check_type_data.dart';
import '../../../../util/theme/theme_util.dart';

class CheckTypeItemWidget extends StatelessWidget {
  const CheckTypeItemWidget({
    required this.checkTypeData,
    required this.selectedCheckTypeData,
    required this.returnDataFunction,
    super.key,
  });

  final CheckTypeData checkTypeData;
  final CheckTypeData? selectedCheckTypeData;
  final Function(CheckTypeData checkTypeData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        returnDataFunction(checkTypeData);
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedCheckTypeData!.id == checkTypeData.id
              ? context.theme.colorScheme.secondary.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              color: selectedCheckTypeData!.id == checkTypeData.id
                  ? context.theme.colorScheme.secondary
                  : context.theme.dividerColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Center(
            child: Text(
              checkTypeData.title!,
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
