import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_endorsement_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/key_value_widget.dart';

class PromissoryEndorsementIssuerPage extends StatelessWidget {
  const PromissoryEndorsementIssuerPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryEndorsementController>(
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locale.issuer_information,
                          style: ThemeUtil.titleStyle,
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
                        KeyValueWidget(
                          keyString: locale.mobile_number,
                          valueString: controller.mainController.authInfoData!.mobile!,
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
                        KeyValueWidget(
                          keyString: locale.deposit_shaba,
                          valueString: controller.selectedDeposit!.depositIban!,
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
                          locale.issuer_residence_info,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.postal_code,
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
                          controller.getPostalCode(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          locale.address_of_residence,
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
                          controller.getCustomerAddress(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            height: 1.6,
                          ),
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
                    controller.validateIssuerPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
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
