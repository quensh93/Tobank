import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/cbs/cbs_services/cbs_services_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../common/payment_method_widget.dart';

class CBSSelectPaymentBottomSheet extends StatelessWidget {
  const CBSSelectPaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CBSServicesController>(
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
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: SvgIcon(
                            SvgIcons.cbsSearch,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        locale.credit_check,
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
                                AppUtil.formatMoney(controller.mainController.creditInquiryPrice!),
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
                    currentAmount: controller.walletAmount,
                    setCurrentPaymentTypeFunction: (paymentType) {
                      controller.setCurrentPaymentType(paymentType);
                    },
                    canPayWithDeposit: controller.mainController.activateCreditInquiryPayment &&
                        controller.mainController.isCustomerHasFullAccess(),
                    canPayWithWallet: true,
                    canPayWithGateway: false,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.validatePayment();
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
