import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/card/card_change_password_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/passcode/password_text_field.dart';
import '../../../../widget/svg/svg_icon.dart';

class CardSecondaryPasswordChangeFirstPage extends StatelessWidget {
  const CardSecondaryPasswordChangeFirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardChangePasswordController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(locale.mandatory_to_comply, style: ThemeUtil.titleStyle),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          SvgIcon(
                            SvgIcons.success,
                            colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            size: 16,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Flexible(
                            child: Text(locale.second_card_password_lenght_5_12,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgIcon(
                            SvgIcons.success,
                            colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            size: 16,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Flexible(
                            child: Text(
                             locale.dont_use_11111_123456,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        locale.current_pass_word,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      PasswordTextField(
                        controller: controller.currentPinController,
                        screen: Screen.settings,
                        hasNext: true,
                        currentFocusNode: controller.currentPinFocusNode,
                        nextFocusNode: controller.newPinFocusNode,
                        hintText: locale.enter_current_password,
                        errorText: locale.enter_valid_value_for_current_password,
                        isValid: controller.isCurrentPinValid,
                        isNumerical: true,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.new_pass_word,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      PasswordTextField(
                        controller: controller.newPinController,
                        screen: Screen.settings,
                        hasNext: true,
                        currentFocusNode: controller.newPinFocusNode,
                        nextFocusNode: controller.reNewPinFocusNode,
                        hintText: locale.enter_new_pass_word,
                        errorText:locale.enter_valid_value_for_new_pass_word,
                        isValid: controller.isCurrentPinValid,
                        isNumerical: true,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.repeat_new_pass_word,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      PasswordTextField(
                        controller: controller.reNewPinController,
                        screen: Screen.settings,
                        hasNext: false,
                        currentFocusNode: controller.reNewPinFocusNode,
                        hintText:locale.do_repeat_new_pass_word,
                        errorText:locale.enter_valid_value_for_repeated_new_pass_word,
                        isValid: controller.isCurrentPinValid,
                        isNumerical: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButtonWidget(
                callback: () {
                  controller.validateChangePassword(pinType: 1);
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.change_second_pass_word,
              ),
            ),
          ],
        );
      },
    );
  }
}
