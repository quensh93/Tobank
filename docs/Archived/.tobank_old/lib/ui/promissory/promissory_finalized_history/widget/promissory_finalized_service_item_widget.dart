import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/promissory/promissory_finalized_item_data.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';

class PromissoryFinalizedServiceItemWidget extends StatelessWidget {
  const PromissoryFinalizedServiceItemWidget({
    required this.promissoryFinalizedItemData,
    required this.returnDataFunction,
    super.key,
  });

  final PromissoryFinalizedItemData promissoryFinalizedItemData;
  final Function(PromissoryFinalizedItemData promissoryFinalizedItemData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        onTap: () {
          returnDataFunction(promissoryFinalizedItemData);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: [
              Card(
                elevation: Get.isDarkMode ? 1 : 0,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgIcon(
                    Get.isDarkMode ? promissoryFinalizedItemData.iconDark : promissoryFinalizedItemData.icon,
                    size: 24.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                promissoryFinalizedItemData.title,
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
