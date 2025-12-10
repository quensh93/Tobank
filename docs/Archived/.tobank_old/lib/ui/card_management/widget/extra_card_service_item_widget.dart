import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/service_item_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class ExtraCardServiceItemWidget extends StatelessWidget {
  const ExtraCardServiceItemWidget({
    required this.serviceItemData,
    required this.returnDataFunction,
    super.key,
  });

  final ServiceItemData serviceItemData;
  final Function(ServiceItemData serviceItemData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
      ),
      child: InkWell(
        onTap: () {
          returnDataFunction(serviceItemData);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(Get.isDarkMode ? serviceItemData.iconDark : serviceItemData.icon),
            const SizedBox(
              width: 8.0,
            ),
            Text(serviceItemData.title,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ))
          ],
        ),
      ),
    );
  }
}
