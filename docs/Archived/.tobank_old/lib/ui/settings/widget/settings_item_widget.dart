import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/common/settings_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    required this.settingItemData,
    required this.returnDataFunction,
    super.key,
  });

  final SettingsItemData settingItemData;
  final Function(SettingsItemData settingItemData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        returnDataFunction(settingItemData);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.dividerColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              SvgIcon(Get.isDarkMode ? settingItemData.iconDark : settingItemData.icon),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  settingItemData.title,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              SvgIcon(
                SvgIcons.arrowLeft,
                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
