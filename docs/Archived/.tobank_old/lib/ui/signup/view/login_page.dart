import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/sign_up/sign_up_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/text_field_clear_icon_widget.dart';

class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<SignUpController>(builder: (controller) {
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
                     locale.validation_title,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      locale.validation_instructions,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      locale.mobile_number_label,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(11),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: controller.phoneNumberController,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        controller.update();
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText: locale.enter_your_mobile_number,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText: controller.isMobileValid ? null : locale.enter_valid_mobile_number,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                        suffixIcon: TextFieldClearIconWidget(
                          isVisible: controller.phoneNumberController.text.isNotEmpty,
                          clearFunction: () {
                            controller.phoneNumberController.clear();
                            controller.update();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      locale.national_code_title,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: controller.nationalCodeController,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        controller.update();
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText: locale.national_code_hint,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText: controller.isNationalCodeValid ? null :locale.enter_national_code_error,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                        suffixIcon: TextFieldClearIconWidget(
                          isVisible: controller.nationalCodeController.text.isNotEmpty,
                          clearFunction: () {
                            controller.nationalCodeController.clear();
                            controller.update();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      locale.birthdate_label,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: () {
                        controller.showSelectDateDialog();
                      },
                      child: IgnorePointer(
                        child: TextField(
                          controller: controller.dateController,
                          enabled: true,
                          readOnly: true,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            hintText:locale.birthdate_hint,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isDateValid ? null : locale.birthdate_error,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 16.0,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                SvgIcons.calendar,
                                colorFilter: ColorFilter.mode(context.theme.colorScheme.secondary, BlendMode.srcIn),
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    InkWell(
                      onTap: () {
                        controller.showRuleScreen();
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                          ),
                          children: [
                             TextSpan(
                              text:locale.agree_with_rules_message,
                              style: const TextStyle(
                                fontFamily: 'IranYekan',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text:locale.rules_and_regulations,
                              style: TextStyle(
                                  fontFamily: 'IranYekan',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: context.theme.colorScheme.secondary),
                            ),
                             TextSpan(
                              text: locale.agree_suffix,
                              style: const TextStyle(
                                fontFamily: 'IranYekan',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                controller.validateLoginPage();
              },
              isLoading: controller.isRequestOtpLoading,
              buttonTitle: locale.receive_verification_code,
            ),
          ),
        ],
      );
    });
  }
}
