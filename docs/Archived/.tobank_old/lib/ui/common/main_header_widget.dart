import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class MainHeaderWidget extends StatelessWidget {
  const MainHeaderWidget({
    required this.title,
    super.key,
    this.returnFunction,
    this.hideBackButton,
    this.showSupportButton = true,
  });

  final String title;
  final Function? returnFunction;
  final bool? hideBackButton;
  final bool showSupportButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (hideBackButton != null)
                const SizedBox(
                  height: 32.0,
                  width: 32.0,
                )
              else
                InkWell(
                  onTap: () {
                    if (returnFunction != null) {
                      returnFunction!();
                    } else {
                      Get.back();
                    }
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgIcon(
                        SvgIcons.back,
                        colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 32),
            ],
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
