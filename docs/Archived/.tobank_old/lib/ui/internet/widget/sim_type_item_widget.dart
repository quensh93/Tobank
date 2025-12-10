import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/internet/response/internet_static_data_model.dart';
import '../../../util/theme/theme_util.dart';

class SimTypeItemWidget extends StatelessWidget {
  const SimTypeItemWidget({
    required this.simType,
    required this.returnDataFunction,
    super.key,
    this.selectedSimType,
  });

  final SimType simType;
  final SimType? selectedSimType;
  final Function(SimType simType) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        returnDataFunction(simType);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedSimType == simType ? context.theme.colorScheme.secondary : context.theme.dividerColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                simType.title!,
                style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w500, fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
