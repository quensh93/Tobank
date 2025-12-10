import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../util/theme/theme_util.dart';
import '../svg/svg_icon.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    required this.buttonTitle,
    required this.buttonIcon,
    required this.onPressed,
    super.key,
    this.isLoading = false,
  });

  final String buttonTitle;
  final SvgIcons buttonIcon;
  final Function onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: OutlinedButton(
        onPressed: () {
          if (!isLoading) {
            onPressed();
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            side: BorderSide(
              color: context.theme.dividerColor,
            ),
          ),
        ),
        child: isLoading
            ? SpinKitFadingCircle(
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.iconTheme.color,
                    ),
                  );
                },
                size: 24.0,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgIcon(
                    buttonIcon,
                    colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                    size: 24.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    buttonTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: ThemeUtil.textTitleColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
