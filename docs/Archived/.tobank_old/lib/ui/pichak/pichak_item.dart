import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/common/pichak_item_data.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class PichakItemWidget extends StatelessWidget {
  const PichakItemWidget({
    required this.pichakItemData,
    required this.returnDataFunction,
    super.key,
  });

  final Function(PichakItemData pichakItemData) returnDataFunction;
  final PichakItemData pichakItemData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      onTap: () {
        returnDataFunction(pichakItemData);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(color: context.theme.dividerColor),
        ),
        child: Row(
          children: <Widget>[
            Card(
              elevation: 1,
              margin: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgIcon(
                  Get.isDarkMode ? pichakItemData.iconDark : pichakItemData.iconName,
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pichakItemData.title!,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  pichakItemData.description!,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
