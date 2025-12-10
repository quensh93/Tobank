import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/launcher/launcher_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/passcode/password_text_field.dart';
import '../fingerprint_widget.dart';

class CheckLoginStatusPage extends StatelessWidget {
  const CheckLoginStatusPage({super.key});

  @override
  Widget build(BuildContext context) {

    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<LauncherController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                height: 4.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        controller.logout();
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          locale.forgot_password,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 36.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validatePassword();
                },
                isLoading: controller.isLoading,
                buttonTitle:locale.login_to_tobank,
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
    });
  }
}
