import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../controller/card_management/card_management_controller.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/payment_method_widget.dart';

class WalletChargeSelectPaymentBottomSheet extends StatelessWidget {
  const WalletChargeSelectPaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardManagementController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 36,
                          height: 4,
                          decoration:
                              BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                    ],
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Column(
                    children: [
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgIcon(
                            Get.isDarkMode ? SvgIcons.walletDark : SvgIcons.wallet,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        locale.increase_wallet_balance,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            locale.payable_amount,
                            style: TextStyle(
                                color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w500, fontSize: 14.0),
                          ),
                          Row(
                            children: [
                              Text(
                                AppUtil.formatMoney(controller.amountController.text),
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                locale.rial,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
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
                  const SizedBox(height: 24.0),
                  Text(locale.payment_method, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 16.0,
                  ),
                  PaymentMethodWidget(
                    currentPaymentType: controller.currentPaymentType,
                    currentAmount: 0,
                    setCurrentPaymentTypeFunction: (paymentType) {
                      controller.setCurrentPaymentType(paymentType);
                    },
                    canPayWithDeposit: controller.mainController.activateWalletChargePayment &&
                        controller.mainController.isCustomerHasFullAccess(),
                    canPayWithWallet: false,
                    canPayWithGateway: true,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.validateWalletChargePayment();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.payment_button,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
