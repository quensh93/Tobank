import 'package:universal_io/io.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/sign_up/sign_up_controller.dart';
import '../../../new_structure/core/theme/main_theme.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/passcode/password_text_field.dart';
import '../../../widget/svg/svg_icon.dart';

class NewPasswordPageWidget extends StatelessWidget {
  const NewPasswordPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
  //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<SignUpController>(builder: (controller) {
      Color getColor(bool condition) =>
          condition ? MainTheme.of(context).secondary : MainTheme.of(context).primary;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      locale.password_entry,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: ThemeUtil.textTitleColor,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      locale.password_label,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    PasswordTextField(
                      controller: controller.newPasswordController,
                      screen: Screen.newScreen,
                      hasNext: true,
                      currentFocusNode: controller.newPasswordFocusNode,
                      nextFocusNode: controller.reNewPasswordFocusNode,
                      hintText: locale.enter_password,
                      // errorText: controller.errorMessageNewPassword,
                      errorText: '',
                      isValid: controller.isCorrectNewPassword,
                      isNumerical: false,
                    ),
                  const SizedBox(height: 8,),
                  Row(children: [
                    SvgIcon(
                      SvgIcons.aboutUs,
                      colorFilter: ColorFilter.mode( controller.newPasswordController.text.isNotEmpty ? getColor(controller.hasLetters) : MainTheme.of(context).surfaceContainer ,
                        BlendMode.srcIn,
                      ),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      locale.has_letter_condition,
                      style: MainTheme.of(context).textTheme.bodyMedium.copyWith(
                        color: controller.newPasswordController.text.isNotEmpty ? getColor(controller.hasLetters) : MainTheme.of(context).surfaceContainer ,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 8),
                  Row(children: [
                    SvgIcon(
                      SvgIcons.aboutUs,
                      colorFilter: ColorFilter.mode(
                        controller.newPasswordController.text.isNotEmpty ? getColor(controller.hasMinLength) : MainTheme.of(context).surfaceContainer ,
                        BlendMode.srcIn,
                      ),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      locale.has_Length_condition,
                      style: MainTheme.of(context).textTheme.bodyMedium.copyWith(
                        color: controller.newPasswordController.text.isNotEmpty ? getColor(controller.hasMinLength) : MainTheme.of(context).surfaceContainer ,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 8),
                  Row(children: [
                    SvgIcon(
                    SvgIcons.aboutUs,
                    colorFilter: ColorFilter.mode(
                      controller.newPasswordController.text.isNotEmpty ? getColor(controller.hasDigits) : MainTheme.of(context).surfaceContainer,
                      BlendMode.srcIn,
                    ),
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                      locale.has_digit_condition,
                      style: MainTheme.of(context).textTheme.bodyMedium.copyWith(
                        color : controller.newPasswordController.text.isNotEmpty ? getColor(controller.hasDigits) : MainTheme.of(context).surfaceContainer ,
                      ))]),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      locale.repeat_password_label,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    PasswordTextField(
                      controller: controller.renewPasswordController,
                      screen: Screen.newScreen,
                      currentFocusNode: controller.reNewPasswordFocusNode,
                      hintText: locale.repeat_password_hint,
                      errorText: controller.errorMessageReNewPassword,
                      isValid: controller.isCorrectReNewPassword,
                      isNumerical: false,
                    ),
                    if (controller.showFingerprint())
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24.0),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(height: 24.0),
                          if (controller.canAuthenticate && (controller.hasFaceDetect || controller.hasFingerPrint))
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: context.theme.dividerColor),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ((Platform.isIOS && controller.hasFaceDetect)
                                                ? locale.face_id_activate
                                                : locale.fingerprint_activation),
                                            style: ThemeUtil.titleStyle,
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            locale.fingerprint_activation_message,
                                            style: TextStyle(
                                              color: ThemeUtil.textSubtitleColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                              height: 1.6,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      width: 44.0,
                                      height: 28.0,
                                      child: Transform.scale(
                                        scale: 0.8,
                                        transformHitTests: false,
                                        child: CupertinoSwitch(
                                          activeColor: context.theme.colorScheme.secondary,
                                          value: controller.isSecurityEnable,
                                          onChanged: (bool value) {
                                            controller.toggleActive(value);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          else
                            const SizedBox(),
                        ],
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ContinueButtonWidget(
              isEnabled:  (controller.hasDigits && controller.hasLetters && controller.hasMinLength),
              callback: () {
                controller.validatePassword();
              },
              isLoading: controller.isLoading,
              buttonTitle: locale.confirmation,

            ),
          ),
        ],
      );
    });
  }
}
