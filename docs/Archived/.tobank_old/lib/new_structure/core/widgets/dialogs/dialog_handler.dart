import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../theme/main_theme.dart';

class DialogHandler {
  DialogHandler._();

  static void showDialogMessage({
    required BuildContext buildContext,
    String? message,
    String? description,
    TextStyle? descriptionStyle,
    TextAlign? descriptionAlign,
    TextStyle? messageStyle,
    String? positiveMessage,
    String? negativeMessage,
    SvgIcons? iconPath,
    Widget? iconWidget,
    Color? iconColor,
    Function? positiveFunction,
    Function? negativeFunction,
    Color? backgroundPositive,
    Color? colorPositive,
    Color? backgroundNegative,
    Color? colorNegative,
    double? iconBottomSizedBox,
    double? iconsize
  }) {
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (iconPath != null)
                      SvgIcon(
                        iconPath,
                        size: iconsize??48.0,
                        color: iconColor,
                      ),
                    if(iconWidget != null)
                     iconWidget,
                    if (message != null)
                      SizedBox(height:iconBottomSizedBox?? 16),
                    if (message != null)
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: messageStyle??MainTheme.of(context).textTheme.titleSmall.copyWith(color: MainTheme.of(context).surfaceContainerHigh)
                      ),
                    if (description != null)
                      const SizedBox(height: 16.0),
                    if (description != null)
                      Text(
                        description,
                        textAlign: descriptionAlign??TextAlign.center,
                        style:  descriptionStyle??MainTheme.of(context).textTheme.titleSmall.copyWith(color: MainTheme.of(context).surfaceContainerHigh)
                      ),
                    const SizedBox(
                      height: 36.0,
                    ),
                    Row(
                      children: [
                        if (positiveMessage != null)
                          Expanded(
                            child: SizedBox(
                              height: 48.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  positiveFunction!();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: colorPositive ?? ThemeUtil.primaryColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  positiveMessage,
                                  style: MainTheme.of(context).textTheme.titleMedium.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        if (positiveMessage != null && negativeMessage != null)
                          const SizedBox(
                            width: 12.0,
                          ),
                        if (negativeMessage != null)
                          Expanded(
                            child: SizedBox(
                              height: 48.0,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  negativeFunction!();
                                },
                                child: Text(
                                  negativeMessage,
                                  style:MainTheme.of(context).textTheme.titleMedium
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
