import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/register/migrate_ekyc_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../common/custom_app_bar.dart';
import '../common/text_field_clear_icon_widget.dart';

class MigrateEkycScreen extends StatelessWidget {
  const MigrateEkycScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MigrateEkycController>(
      init: MigrateEkycController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.identity_update,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                locale.first_name_english,
                                style: ThemeUtil.titleStyle,
                              ),
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
                                  errorText: controller.isEnglishFirstNameValidate
                                      ? null
                                      : locale.please_enter_first_name_english,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Get.isDarkMode ? Colors.transparent : context.theme.disabledColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Get.isDarkMode ? Colors.transparent : context.theme.disabledColor),
                                  ),
                                  hintText: locale.enter_last_name_english,
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
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
                              Text(
                                locale.last_name_english,
                                style: ThemeUtil.titleStyle,
                              ),
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
                                autofillHints: const [AutofillHints.familyName],
                                textAlign: TextAlign.right,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  controller.update();
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  errorText: controller.isEnglishLastNameValidate
                                      ? null
                                      : locale.please_enter_last_name_english,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Get.isDarkMode ? Colors.transparent : ThemeUtil.hintColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Get.isDarkMode ? Colors.transparent : ThemeUtil.hintColor),
                                  ),
                                  hintText: locale.please_enter_last_name_english,
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
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
                              Text(
                                locale.job,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              TextField(
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                  fontFamily: 'IranYekan',
                                ),
                                controller: controller.jobTextEditingController,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.right,
                                onChanged: (value) {
                                  controller.update();
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  errorText: controller.isJobValidate ? null : locale.job_entry_error,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Get.isDarkMode ? Colors.transparent : ThemeUtil.hintColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Get.isDarkMode ? Colors.transparent : ThemeUtil.hintColor),
                                  ),
                                  hintText: locale.job_input_hint,
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                  suffixIcon: TextFieldClearIconWidget(
                                    isVisible: controller.jobTextEditingController.text.isNotEmpty,
                                    clearFunction: () {
                                      controller.jobTextEditingController.clear();
                                      controller.update();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                locale.home_phone_number,
                                style: ThemeUtil.titleStyle,
                              ),
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
                                  errorText: controller.isHomePhoneNumberValidate
                                      ? null
                                      : locale.please_enter_valid_home_phone,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Get.isDarkMode ? Colors.transparent : ThemeUtil.hintColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Get.isDarkMode ? Colors.transparent : ThemeUtil.hintColor),
                                  ),
                                  hintText: locale.enter_home_phone_number,
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
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
                              const SizedBox(
                                height: 40.0,
                              ),
                              ContinueButtonWidget(
                                callback: () {
                                  controller.migrateEkyc();
                                },
                                isLoading: controller.isLoading,
                                buttonTitle: locale.identity_update,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
