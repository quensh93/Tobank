import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/model/common/main_menu_item_data.dart';
import '/model/common/menu_data_model.dart';
import '/util/data_constants.dart';
import '/util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class ServiceItemWidget extends StatelessWidget {
  const ServiceItemWidget({
    required this.menuItemData,
    required this.selectProcessFunction,
    required this.isEnroll,
    super.key,
  });

  final MenuItemData menuItemData;
  final Function(MenuItemData menuItemData) selectProcessFunction;
  final bool isEnroll;

  @override
  Widget build(BuildContext context) {
    final MainMenuItemData? menuItem = DataConstants.getMenuItems().firstWhereOrNull(
      (element) => element.uuid == menuItemData.uuid,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        splashColor: Colors.grey.withOpacity(0.2),
        onTap: () {
          selectProcessFunction(menuItemData);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: (menuItem != null)
                    ? SvgIcon(
                        (Get.isDarkMode) ? menuItem.iconDark! : menuItem.icon!,
                        size: 28.0,
                      )
                    : const SizedBox(
                        width: 28,
                        height: 28,
                      ),
              ),
              Flexible(
                child: Text(
                  menuItemData.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    height: 1.6,
                    color: isEnroll ? ThemeUtil.textTitleColor : context.theme.disabledColor,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  menuItemData.subtitle ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    height: 1.6,
                    color: isEnroll ? ThemeUtil.textSubtitleColor : context.theme.disabledColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
