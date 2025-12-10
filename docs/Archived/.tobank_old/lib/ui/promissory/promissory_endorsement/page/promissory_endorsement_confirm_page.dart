import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_endorsement_controller.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/key_value_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class PromissoryEndorsementConfirmPage extends StatelessWidget {
  const PromissoryEndorsementConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryEndorsementController>(
      builder: (controller) {
        final isIndividual = controller.selectedReceiverType == PromissoryCustomerType.individual;
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locale.recipient_info,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.name,
                          valueString: controller.receiverName!,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: isIndividual ? locale.national_code_title : locale.national_code,
                          valueString: controller.receiverNationalCodeController.text,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: isIndividual ?  locale.mobile_number : locale.contact_number,
                          valueString: controller.receiverMobileController.text,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
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
                  readOnly: !isIndividual,
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
                      horizontal: 20.0,
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
                  height: 16.0,
                ),
                Text(
                  locale.description_title,
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
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 4,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    controller.update();
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: locale.description_hint,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isDescriptionValid ? null : locale.description_error,
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
