import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/bpms/military_guarantee/military_guarantee_person_type_item_data.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';

class MilitaryGuaranteePersonTypeItem extends StatelessWidget {
  const MilitaryGuaranteePersonTypeItem({
    required this.militaryGuaranteePersonTypeItemData,
    required this.returnDataFunction,
    super.key,
  });

  final Function(MilitaryGuaranteePersonTypeItemData militaryGuaranteePersonTypeItemData) returnDataFunction;
  final MilitaryGuaranteePersonTypeItemData militaryGuaranteePersonTypeItemData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      onTap: () {
        returnDataFunction(militaryGuaranteePersonTypeItemData);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(
            color: context.theme.dividerColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: [
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: Card(
                  elevation: Get.isDarkMode ? 1 : 0,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgIcon(militaryGuaranteePersonTypeItemData.icon),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                militaryGuaranteePersonTypeItemData.title,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
