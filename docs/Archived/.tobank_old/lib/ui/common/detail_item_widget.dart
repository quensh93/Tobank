import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_util.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class DetailItemWidget extends StatelessWidget {
  const DetailItemWidget({
    required this.title,
    required this.value,
    required this.showCopyIcon,
    required this.isSecure,
    super.key,
    this.isShow,
    this.toggleIsShowFunction,
    this.valueTextDirection,
    this.copyClipboardFunction,
  });

  final String title;
  final String value;
  final bool showCopyIcon;
  final bool isSecure;
  final bool? isShow;
  final Function(bool isShow)? toggleIsShowFunction;
  final Function(String value)? copyClipboardFunction;
  final TextDirection? valueTextDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: ThemeUtil.textSubtitleColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showCopyIcon)
                    InkWell(
                      onTap: () {
                        copyClipboardFunction!(value);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          SvgIcons.copy,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        ),
                      ),
                    )
                  else
                    Container(),
                  if (isSecure)
                    InkWell(
                      onTap: () {
                        toggleIsShowFunction!(isShow!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          isShow! ? SvgIcons.hidePassword : SvgIcons.showPassword,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        ),
                      ),
                    )
                  else
                    Container(),
                  Flexible(
                    child: Text(
                      isSecure ? AppUtil.secureText(value, isShow) ?? '' : value,
                      textDirection: valueTextDirection ?? TextDirection.ltr,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
