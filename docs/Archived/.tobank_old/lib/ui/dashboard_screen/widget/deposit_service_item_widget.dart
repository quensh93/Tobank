import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/common/menu_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class DepositServiceItemWidget extends StatelessWidget {
  const DepositServiceItemWidget({
    required this.virtualBranchMenuData,
    required this.returnDataFunction,
    super.key,
  });

  final MenuData virtualBranchMenuData;
  final Function(MenuData virtualBranchMenuData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      onTap: () {
        returnDataFunction(virtualBranchMenuData);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
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
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgIcon(Get.isDarkMode ? virtualBranchMenuData.iconDark : virtualBranchMenuData.icon),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                virtualBranchMenuData.title,
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
