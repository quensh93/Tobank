import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/promissory/promissory_item_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class PromissoryItemWidget extends StatelessWidget {
  const PromissoryItemWidget({
    required this.promissoryItemData,
    required this.returnDataFunction,
    super.key,
  });

  final Function(PromissoryItemData promissoryItemData) returnDataFunction;
  final PromissoryItemData promissoryItemData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        onTap: () {
          returnDataFunction(promissoryItemData);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: <Widget>[
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
                    Get.isDarkMode ? promissoryItemData.iconDark : promissoryItemData.icon,
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
                    promissoryItemData.title,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      height: 1.6,
                    ),
                  ),
                  if (promissoryItemData.subtitle.isEmpty) Container() else const SizedBox(height: 8.0),
                  if (promissoryItemData.subtitle.isEmpty)
                    Container()
                  else
                    Text(
                      promissoryItemData.subtitle,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        height: 1.6,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
