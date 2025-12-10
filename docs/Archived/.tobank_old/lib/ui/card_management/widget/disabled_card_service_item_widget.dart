import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/service_item_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class DisabledCardServiceItemWidget extends StatelessWidget {
  const DisabledCardServiceItemWidget({
    required this.serviceItemData,
    super.key,
  });

  final ServiceItemData serviceItemData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(
            Get.isDarkMode ? serviceItemData.iconDark : serviceItemData.icon,
            colorFilter: ColorFilter.mode(context.theme.iconTheme.color!.withOpacity(0.4), BlendMode.srcIn),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(serviceItemData.title,
              style: TextStyle(
                color: ThemeUtil.textTitleColor.withOpacity(0.4),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    );
  }
}
