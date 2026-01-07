import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/l10n/gen/app_localizations.dart';
import '../../../../../controller/promissory/request_promissory_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/key_value_widget.dart';

class RequestPromissoryConfirmPage extends StatelessWidget {
  const RequestPromissoryConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    // TODO: Add more detail
    return GetBuilder<RequestPromissoryController>(
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
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.amount)),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.payment_date,
                          valueString: controller.isOnTime ? locale.due_on_demand : controller.dateController.text,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.description,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          controller.descriptionController.text == '' ? '--' : controller.descriptionController.text,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
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
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          controller.paymentAddressController.text,
                          style: const TextStyle(fontWeight: FontWeight.w600, height: 1.4, fontSize: 16.0),
                        )
                      ],
                    ),
                  ),
                ),
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
                          locale.issuer_information,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 8.0),
                        KeyValueWidget(
                          keyString: locale.national_code_title,
                          valueString: controller.mainController.authInfoData!.nationalCode ?? '',
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.issuer_mobile_number,
                          valueString: controller.mainController.authInfoData!.mobile ?? '',
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.full_name,
                          valueString: controller.getCustomerDetail(),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.residence_address,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          controller.issuerAddressController.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                          locale.recipient_information,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 8.0),
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
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: isIndividual ? locale.full_name : locale.name,
                          valueString: controller.receiverName!,
                        ),
                      ],
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
