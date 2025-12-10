import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/pichak/check_owner_status_data.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class OwnerStatusItemWidget extends StatelessWidget {
  const OwnerStatusItemWidget({
    required this.checkOwnerStatusData,
    super.key,
  });

  final CheckOwnerStatusData checkOwnerStatusData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                SvgIcon(
                  SvgIcons.status,
                  colorFilter: ColorFilter.mode(checkOwnerStatusData.iconColor, BlendMode.srcIn),
                  size: 32.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  checkOwnerStatusData.title,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Divider(thickness: 1),
            const SizedBox(height: 8.0),
            Text(
              checkOwnerStatusData.description,
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
