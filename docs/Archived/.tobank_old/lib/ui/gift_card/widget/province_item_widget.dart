import 'package:flutter/material.dart';

import '../../../model/gift_card/city_province_data_model.dart';
import '../../../util/theme/theme_util.dart';

class ProvinceItemWidget extends StatelessWidget {
  const ProvinceItemWidget({
    required this.cityProvinceDataModel,
    required this.returnDataFunction,
    super.key,
    this.selectedCityProvinceDataModel,
  });

  final CityProvinceDataModel cityProvinceDataModel;
  final CityProvinceDataModel? selectedCityProvinceDataModel;
  final Function(CityProvinceDataModel cityProvinceDataModel) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        returnDataFunction(cityProvinceDataModel);
      },
      child: SizedBox(
        height: 48.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                cityProvinceDataModel.name!,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
