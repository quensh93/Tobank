import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/internet/internet_plan_filter_data.dart';
import '../../../util/theme/theme_util.dart';

class InternetPlanFilterItemWidget extends StatelessWidget {
  const InternetPlanFilterItemWidget({
    required this.internetPlanFilterData,
    required this.selectedInternetPlanFilterDataList,
    required this.returnDataFunction,
    super.key,
  });

  final InternetPlanFilterData internetPlanFilterData;
  final List<InternetPlanFilterData> selectedInternetPlanFilterDataList;
  final Function(InternetPlanFilterData internetPlanFilterData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      color: selectedInternetPlanFilterDataList.contains(internetPlanFilterData)
          ? context.theme.colorScheme.secondary
          : context.theme.colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          returnDataFunction(internetPlanFilterData);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Center(
            child: Text(
              internetPlanFilterData.title!,
              style: TextStyle(
                color: selectedInternetPlanFilterDataList.contains(internetPlanFilterData)
                    ? Colors.white
                    : ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
