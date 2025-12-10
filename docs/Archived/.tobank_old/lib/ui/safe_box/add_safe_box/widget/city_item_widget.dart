import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/safe_box/response/safe_box_city_list_response_data.dart';
import '../../../../../util/theme/theme_util.dart';

class CityItemWidget extends StatelessWidget {
  const CityItemWidget({
    required this.safeBoxCityData,
    required this.selectedSafeBoxCityData,
    required this.returnDataFunction,
    super.key,
  });

  final SafeBoxCityData safeBoxCityData;
  final SafeBoxCityData? selectedSafeBoxCityData;
  final Function(SafeBoxCityData safeBoxCityData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selectedSafeBoxCityData != null && selectedSafeBoxCityData!.id == safeBoxCityData.id
            ? context.theme.colorScheme.secondary.withOpacity(0.10)
            : Colors.transparent,
        border: Border.all(
            color: selectedSafeBoxCityData != null && selectedSafeBoxCityData!.id == safeBoxCityData.id
                ? context.theme.colorScheme.secondary
                : context.theme.dividerColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          returnDataFunction(safeBoxCityData);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              safeBoxCityData.name ?? '',
              style: TextStyle(
                color: selectedSafeBoxCityData != null && selectedSafeBoxCityData!.id == safeBoxCityData.id
                    ? context.theme.colorScheme.secondary
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
