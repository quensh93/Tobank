import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/common/settings_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class AccountItemWidget extends StatelessWidget {
  const AccountItemWidget({
    required this.settingsItemData,
    required this.returnDataFunction,
    super.key,
  });

  final Function(SettingsItemData settingsItemData) returnDataFunction;
  final SettingsItemData settingsItemData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        returnDataFunction(settingsItemData);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: context.theme.dividerColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              SvgIcon(
                settingsItemData.icon,
                size: 24,
                colorFilter: ColorFilter.mode(
                  context.theme.iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  settingsItemData.title,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ),
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
