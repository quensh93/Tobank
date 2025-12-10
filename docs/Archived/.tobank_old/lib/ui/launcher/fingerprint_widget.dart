import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class FingerprintWidget extends StatelessWidget {
  const FingerprintWidget({
    required this.callback,
    required this.isFaceAvailable,
    super.key,
  });

  final Function callback;
  final bool isFaceAvailable;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(100.0),
            ),
            onTap: () {
              callback();
            },
            child: Container(
              width: 88,
              height: 88,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: context.theme.colorScheme.secondary.withOpacity(0.1)),
              child: isFaceAvailable
                  ? SvgIcon(
                      SvgIcons.faceId,
                      colorFilter: ColorFilter.mode(ThemeUtil.primaryColor, BlendMode.srcIn),
                    )
                  : SvgIcon(
                      Get.isDarkMode ? SvgIcons.touchDark : SvgIcons.touch,
                      colorFilter: ColorFilter.mode(ThemeUtil.primaryColor, BlendMode.dstIn),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
