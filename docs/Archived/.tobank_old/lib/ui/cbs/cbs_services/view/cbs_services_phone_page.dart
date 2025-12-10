import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/cbs/cbs_services/cbs_services_controller.dart';
import '../../../../../util/constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class CbsServicesPhonePage extends StatelessWidget {
  const CbsServicesPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CBSServicesController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      locale.sim_card_number,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      crossAxisAlignment:
                          controller.isPhoneNumberValid ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              controller.nationalCodeController.clear();
                              controller.update();
                            },
                            controller: controller.phoneNumberController,
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(11),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              fontFamily: 'IranYekan',
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              hintText: locale.like_09123456789,
                              hintStyle: ThemeUtil.hintStyle,
                              errorText: controller.isPhoneNumberValid ? null : locale.enter_valid_cell_phone,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 16.0,
                              ),
                              suffixIcon: TextFieldClearIconWidget(
                                isVisible: controller.phoneNumberController.text.isNotEmpty,
                                clearFunction: () {
                                  controller.clearPhoneNumberTextField();
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        InkWell(
                          onTap: () {
                            controller.setMinePhoneNumber();
                          },
                          child: Card(
                            elevation: Get.isDarkMode ? 1 : 0,
                            shadowColor: Colors.transparent,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                            ),
                            child: SizedBox(
                              height: 56.0,
                              width: 56.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgIcon(
                                  Get.isDarkMode ? SvgIcons.userProfileDark : SvgIcons.userProfile,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        if(!kIsWeb)
                        InkWell(
                          onTap: () {
                            controller.showSelectContactScreen();
                          },
                          child: Card(
                            elevation: Get.isDarkMode ? 1 : 0,
                            shadowColor: Colors.transparent,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                            ),
                            child: SizedBox(
                              height: 56.0,
                              width: 56.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgIcon(
                                  Get.isDarkMode ? SvgIcons.contactListDark : SvgIcons.contactList,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    if (controller.phoneNumberController.text.length == Constants.mobileNumberLength &&
                        controller.phoneNumberController.text != controller.mainController.authInfoData!.mobile!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              hintText: locale.enter_applicant_national_code,
                              hintStyle: ThemeUtil.hintStyle,
                              errorText: controller.isNationalCodeValid ? null : locale.national_code_error_message,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
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
              callback: () {
                controller.validatePhonePage();
              },
              isLoading: controller.isLoading,
              buttonTitle: locale.continue_label,
              isEnabled: controller.isEnabled(),
            ),
          ),
        ],
      );
    });
  }
}
