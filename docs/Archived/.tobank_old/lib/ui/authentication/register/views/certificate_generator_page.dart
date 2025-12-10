import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../controller/authentication/authentication_extension/address_verification_flow_methods.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/authentication_register_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class CertificateGeneratorPage extends StatelessWidget {
  const CertificateGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AuthenticationRegisterController>(
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        locale.please_enter_additional_information,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(locale.first_name_english, style: ThemeUtil.titleStyle),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        controller: controller.englishNameEditingController,
                        keyboardType: TextInputType.text,
                        autofillHints: const [AutofillHints.givenName],
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText:locale.enter_first_name_english,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isEnglishFirstNameValidate ? null : locale.please_enter_first_name_english,
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
                            isVisible: controller.englishNameEditingController.text.isNotEmpty,
                            clearFunction: () {
                              controller.englishNameEditingController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(locale.last_name_english, style: ThemeUtil.titleStyle),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        controller: controller.englishFamilyTextEditingController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.right,
                        autofillHints: const [AutofillHints.familyName],
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.enter_last_name_english,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isEnglishLastNameValidate
                              ? null
                              : locale.please_enter_last_name_english,
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
                            isVisible: controller.englishFamilyTextEditingController.text.isNotEmpty,
                            clearFunction: () {
                              controller.englishFamilyTextEditingController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(locale.email, style: ThemeUtil.titleStyle),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        controller: controller.emailEditingController,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.enter_email,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isEmailValidate ? null :locale.please_enter_valid_email,
                          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
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
                            isVisible: controller.emailEditingController.text.isNotEmpty,
                            clearFunction: () {
                              controller.emailEditingController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(locale.home_phone_number, style: ThemeUtil.titleStyle),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        controller: controller.homePhoneNumberTextEditingController,
                        keyboardType: TextInputType.phone,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        textAlign: TextAlign.right,
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(11),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.enter_home_phone_number,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText:
                              controller.isHomePhoneNumberValidate ? null : locale.please_enter_valid_home_phone,
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
                            isVisible: controller.homePhoneNumberTextEditingController.text.isNotEmpty,
                            clearFunction: () {
                              controller.homePhoneNumberTextEditingController.clear();
                              controller.update();
                            },
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
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (!controller.isLoading) {
                      controller.validateFrom();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ThemeUtil.primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.isLoading)
                          SpinKitFadingCircle(
                            itemBuilder: (_, int index) {
                              return const DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              );
                            },
                            size: 24.0,
                          )
                        else
                          Container(),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Flexible(
                          child: Text(
                            controller.isLoading ? locale.process_in_progress : locale.submit_process,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 14.0,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
