import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/promissory/collateral_promissory/collateral_promissory_publish_controller.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/key_value_widget.dart';

class CollateralPromissoryPublishConfirmPage extends StatelessWidget {
  const CollateralPromissoryPublishConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CollateralPromissoryPublishController>(
      builder: (controller) {
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
                          keyString: locale.amount,
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.collateralPromissoryRequestData.amount)),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.payment_date,
                          valueString: controller.collateralPromissoryRequestData.dueDate == null
                              ? locale.due_on_demand
                              : controller.collateralPromissoryRequestData.dueDate!,
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
                          controller.collateralPromissoryRequestData.description ?? '-',
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
                          controller.paymentAddress ?? '',
                          style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                              fontSize: 16.0),
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
                          keyString: locale.full_name,
                          valueString: controller.getCustomerDetail(),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString:  locale.mobile_number,
                          valueString: controller.mainController.authInfoData!.mobile!,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.national_code_title,
                          valueString: controller.mainController.authInfoData!.nationalCode!,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.address_of_residence,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          controller.customerInfoResponse!.data!.address!,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                            fontSize: 16.0,
                          ),
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
                          locale.recipient_information,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 8.0),
                        KeyValueWidget(
                          keyString: locale.name,
                          valueString: controller.recipientName!,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.contact_number,
                          valueString: controller.collateralPromissoryRequestData.recipientCellPhone,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.recipient_national_id_title,
                          valueString: controller.collateralPromissoryRequestData.recipientNN,
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
                    controller.submitRequestPromissory();
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
