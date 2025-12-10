import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/common/main_menu_item_data.dart';
import '../../../model/common/menu_data_model.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class ServiceItemWidget extends StatelessWidget {
  const ServiceItemWidget({
    required this.menuItemData,
    required this.returnDataFunction,
    super.key,
  });

  final Function(MenuItemData menuItemData) returnDataFunction;
  final MenuItemData menuItemData;

  @override
  Widget build(BuildContext context) {
    final MainMenuItemData? menuItem =
        DataConstants.getMenuItems().firstWhereOrNull((element) => element.uuid == menuItemData.uuid);
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        returnDataFunction(menuItemData);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              elevation: 1,
              shadowColor: Colors.transparent,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: menuItem != null
                    ? SvgIcon(
                        Get.isDarkMode ? menuItem.iconDark! : menuItem.icon!,
                        size: 28,
                      )
                    : const SizedBox(
                        width: 24,
                        height: 24,
                      ),
              )),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            menuItemData.title!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.0,
              color: ThemeUtil.textTitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
