import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/check_login/check_login_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/passcode/password_text_field.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../launcher/fingerprint_widget.dart';

class CheckLoginBottomSheet extends StatelessWidget {
  const CheckLoginBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CheckLoginController>(
          init: CheckLoginController(),
          builder: (controller) {
            return PopScope(
              canPop: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (Get.isDarkMode)
                      const SvgIcon(
                        SvgIcons.tobankWhite,
                        size: 32.0,
                      )
                    else
                      const SvgIcon(
                        SvgIcons.tobankRed,
                        size: 32.0,
                      ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(locale.security_message, style: ThemeUtil.titleStyle),
                      ],
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Text(locale.password_label, style: ThemeUtil.titleStyle),
                    const SizedBox(
                      height: 12.0,
                    ),
                    PasswordTextField(
                      screen: Screen.newScreen,
                      controller: controller.passwordController,
                      hintText: locale.password_hint,
                      errorText: locale.password_error_farsi_5char,
                      isValid: controller.isCorrectPassword,
                      isNumerical: false,
                    ),
                    const SizedBox(
                      height: 36.0,
                    ),
                    ContinueButtonWidget(
                      callback: () {
                        controller.validatePassword();
                      },
                      isLoading: controller.isLoading,
                      buttonTitle: locale.login_again,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    if (controller.isSecurityEnable && (controller.hasFingerPrint || controller.hasFaceDetect))
                      Column(
                        children: [
                          FingerprintWidget(
                            callback: () {
                              if (!controller.isLoading) {
                                controller.authenticate();
                              }
                            },
                            isFaceAvailable: controller.hasFaceDetect,
                          ),
                        ],
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
