import 'package:flutter/material.dart';

import '../../../model/gift_card/city_province_data_model.dart';
import '../../../util/theme/theme_util.dart';

class CityItemWidget extends StatelessWidget {
  const CityItemWidget({
    required this.city,
    required this.returnDataFunction,
    super.key,
    this.selectedCity,
  });

  final City city;
  final City? selectedCity;
  final Function(City city) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        returnDataFunction(city);
      },
      child: Container(
        height: 48.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: city.id == selectedCity!.id ? Colors.transparent : Colors.transparent,
        ),
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          onTap: () {
            returnDataFunction(city);
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  city.name!,
                  style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 14.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
