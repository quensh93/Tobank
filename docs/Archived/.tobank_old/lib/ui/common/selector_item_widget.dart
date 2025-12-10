import 'package:flutter/material.dart';

import '../../util/theme/theme_util.dart';

class SelectorItemWidget extends StatelessWidget {
  const SelectorItemWidget({
    required this.title,
    required this.isSelected,
    required this.callBack,
    super.key,
  });

  final Function callBack;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callBack();
      },
      child: SizedBox(
        height: 56.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? ThemeUtil.textTitleColor : ThemeUtil.textSubtitleColor,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 3.0,
                  width: 56.0,
                  decoration: BoxDecoration(
                    color: isSelected ? ThemeUtil.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(3.0),
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
