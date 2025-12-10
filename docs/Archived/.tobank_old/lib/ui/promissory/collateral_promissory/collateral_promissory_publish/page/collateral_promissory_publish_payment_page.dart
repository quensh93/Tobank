import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/promissory/collateral_promissory/collateral_promissory_publish_controller.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../common/key_value_widget.dart';
import '../../../../common/payment_method_widget.dart';

class CollateralPromissoryPublishPaymentPage extends StatelessWidget {
  const CollateralPromissoryPublishPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CollateralPromissoryPublishController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 16.0,
              ),
              Column(
                children: [
                  Card(
                    elevation: Get.isDarkMode ? 1 : 0,
                    margin: EdgeInsets.zero,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgIcon(
                        Get.isDarkMode ? SvgIcons.promissoryRequestDark : SvgIcons.promissoryRequest,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                   Text(
                    locale.promissory_issuance,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      fontFamily: 'IranYekan',
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                       Text(
                        locale.payable_amount,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                      ),
                      Row(
                        children: [
                          Text(
                            AppUtil.formatMoney(controller.getCorrectAmount()),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16.0,
                              fontFamily: 'IranYekan',
                            ),
                          ),
                           Text(
                            locale.rial,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
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
                    children: [
                      KeyValueWidget(
                        keyString: locale.stamp_duty,
                        valueString:
                            locale.amount_format(AppUtil.formatMoney(controller.promissoryAmountResponseData!.data!.stampFee)),
                      ),
                      if (controller.promissoryAmountResponseData!.data!.gssToYektaFee! != 0)
                        const SizedBox(
                          height: 16.0,
                        )
                      else
                        Container(),
                      if (controller.promissoryAmountResponseData!.data!.gssToYektaFee! != 0)
                        KeyValueWidget(
                          keyString: locale.renewal_authentication,
                          valueString:
                              locale.amount_format(AppUtil.formatMoney(controller.promissoryAmountResponseData!.data!.gssToYektaFee)),
                        )
                      else
                        Container(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      KeyValueWidget(
                        keyString: locale.issuance_fee,
                        valueString: locale.amount_format(AppUtil.formatMoney(controller.promissoryAmountResponseData!.data!.wage)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.payment_method,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 16.0,
              ),
              PaymentMethodWidget(
                currentPaymentType: controller.currentPaymentType,
                currentAmount: controller.walletAmount,
                setCurrentPaymentTypeFunction: (paymentType) {
                  controller.setCurrentPaymentType(paymentType);
                },
                canPayWithDeposit: controller.mainController.activatePromissoryPublishPayment,
                canPayWithWallet: true,
                canPayWithGateway: false,
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validatePaymentPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.payment_button,
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      );
    });
  }
}
