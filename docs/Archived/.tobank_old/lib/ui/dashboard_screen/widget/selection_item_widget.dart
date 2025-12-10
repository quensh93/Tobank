import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class SelectionItemWidget extends StatelessWidget {
  const SelectionItemWidget({
    required this.title,
    required this.icon,
    required this.iconSelected,
    required this.index,
    required this.selectedTab,
    required this.returnDataFunction,
    super.key,
  });

  final String title;
  final SvgIcons icon;
  final SvgIcons iconSelected;
  final int index;
  final int selectedTab;
  final Function(int index) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          returnDataFunction(index);
        },
        child: Column(
          children: [
            SvgIcon(
              index == selectedTab ? iconSelected : icon,
              colorFilter: ColorFilter.mode(
                  index == selectedTab ? ThemeUtil.primaryColor : context.theme.iconTheme.color!, BlendMode.srcIn),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: index == selectedTab ? FontWeight.w600 : FontWeight.w500,
                color: index == selectedTab ? context.textTheme.bodyLarge!.color : ThemeUtil.textSubtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
