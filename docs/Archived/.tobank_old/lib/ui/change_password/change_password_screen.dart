import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/change_password/change_password_controller.dart';
import '../../new_structure/core/theme/main_theme.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';
import '../../widget/passcode/password_text_field.dart';
import '../../widget/svg/svg_icon.dart';
import '../common/custom_app_bar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<ChangePasswordController>(
          init: ChangePasswordController(),
          builder: (controller) {
            Color getColor(bool condition) =>
                condition ? MainTheme.of(context).secondary : MainTheme.of(context).primary;
            return Scaffold(
              appBar: CustomAppBar(
                titleString:locale.change_password,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                locale.current_password,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              PasswordTextField(
                                controller: controller.currentPasswordController,
                                screen: Screen.settings,
                                hasNext: true,
                                currentFocusNode: controller.currentPasswordFocusNode,
                                nextFocusNode: controller.newPasswordFocusNode,
                                hintText: locale.enter_current_password,
                                errorText: locale.incorrect_password,
                                isValid: controller.isCorrectCurrentPassword,
                                isNumerical: false,
                              ),

                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                locale.new_password,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              //this one has red error line when empty
                              PasswordTextField(
                                controller: controller.newPasswordController,
                                screen: Screen.settings,
                                hasNext: true,
                                currentFocusNode: controller.newPasswordFocusNode,
                                nextFocusNode: controller.reNewPasswordFocusNode,
                                hintText: locale.enter_new_password,
                                errorText:'',
                                isValid: controller.isCorrectNewPassword,
                                isNumerical: false,
                                onchanged: (txt){
                                  setState(() {
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),

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
                                locale.repeat_new_password,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              PasswordTextField(
                                controller: controller.renewPasswordController,
                                screen: Screen.settings,
                                currentFocusNode: controller.reNewPasswordFocusNode,
                                hintText: locale.re_enter_new_password,
                                errorText: locale.password_not_match,
                                isValid: controller.isCorrectReNewPassword,
                                isNumerical: false,
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              // Row(
                              //   children: [
                              //     Card(
                              //       color:Colors.transparent ,
                              //       elevation: 0,
                              //       margin: EdgeInsets.zero,
                              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              //       child: Padding(
                              //         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              //         child: Text(
                              //           locale.password_length_5char,
                              //           style: ThemeUtil.titleStyle,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ContinueButtonWidget(
                        callback: () {
                          controller.validate();
                        },
                        isLoading: controller.isLoading,
                        buttonTitle: locale.confirm_and_save,
                        isEnabled: (controller.hasMinLength & controller.hasLetters & controller.hasDigits),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
