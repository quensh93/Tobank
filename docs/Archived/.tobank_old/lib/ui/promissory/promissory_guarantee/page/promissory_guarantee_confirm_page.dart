import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_guarantee_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/key_value_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class PromissoryGuaranteeConfirmPage extends StatelessWidget {
  const PromissoryGuaranteeConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryGuaranteeController>(
      builder: (controller) {
        final isIndividual =
            controller.promissoryInquiryResponseData!.data!.recipientType == PromissoryCustomerType.individual;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Card(
                  elevation: Get.isDarkMode ? 1 : 0,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locale.promissory_note_info,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 8.0),
                        KeyValueWidget(
                          keyString: locale.promissory_amount,
                          valueString:
                              locale.amount_format(AppUtil.formatMoney(controller.promissoryInquiryResponseData!.data!.amount)),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.payment_date,
                          valueString: controller.promissoryInquiryResponseData!.data!.dueDate ?? '',
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.process_detail,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          controller.promissoryInquiryResponseData!.data!.description ?? '',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.pay_location,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          controller.promissoryInquiryResponseData!.data!.paymentPlace!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.issuer_information,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.national_code_title,
                          valueString: controller.promissoryInquiryResponseData!.data!.issuerNn ?? '',
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.issuer_mobile_number,
                          valueString: '0${controller.promissoryInquiryResponseData!.data!.issuerCellphone}',
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.full_name,
                          valueString: controller.promissoryInquiryResponseData!.data!.issuerFullName ?? '',
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.residence_address,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          controller.promissoryInquiryResponseData!.data!.issuerAddress ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.recipient_information,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: isIndividual ? locale.national_code_title : locale.national_code,
                          valueString: controller.promissoryInquiryResponseData!.data!.recipientNn ?? '',
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: isIndividual ?  locale.mobile_number : locale.contact_number,
                          valueString: isIndividual
                              ? '0${controller.promissoryInquiryResponseData!.data!.recipientCellphone}'
                              : controller.promissoryInquiryResponseData!.data!.recipientCellphone,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: isIndividual ? locale.full_name : locale.company_name,
                          valueString: controller.promissoryInquiryResponseData!.data!.recipientFullName ?? '',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  locale.payment_address,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.paymentAddressController,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    fontFamily: 'IranYekan',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(200),
                  ],
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 4,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    controller.update();
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                    hintText: locale.payment_address_hint,
                    errorText: controller.isPaymentAddressValid ? null : locale.payment_address_error,
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
                    suffixIcon: TextFieldClearIconWidget(
                      isVisible: controller.paymentAddressController.text.isNotEmpty,
                      clearFunction: () {
                        controller.paymentAddressController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  locale.description,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.descriptionController,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    fontFamily: 'IranYekan',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(200),
                  ],
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 4,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    controller.update();
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                    hintText: locale.guarantee_description_hint,
                    errorText: controller.isDescriptionValid ? null : locale.guarantee_description_error,
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
                    suffixIcon: TextFieldClearIconWidget(
                      isVisible: controller.descriptionController.text.isNotEmpty,
                      clearFunction: () {
                        controller.descriptionController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateConfirmPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirm_continue,
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
