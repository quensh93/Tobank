import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/micro_lending_loan/micro_lending_loan_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../common/payment_method_widget.dart';

class MicroLendingLoanCreditGradeInquirySelectPaymentBottomSheet extends StatelessWidget {
  const MicroLendingLoanCreditGradeInquirySelectPaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<MicroLendingLoanController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                        locale.credit_check_title,
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
                                AppUtil.formatMoney(controller.config!.price!),
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
                  const SizedBox(height: 32.0),
                  Text(locale.payable_amount, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 16.0,
                  ),
                  PaymentMethodWidget(
                    currentPaymentType: controller.currentPaymentType,
                    currentAmount: controller.walletAmount,
                    setCurrentPaymentTypeFunction: (paymentType) {
                      controller.setCurrentPaymentType(paymentType);
                    },
                    canPayWithDeposit: controller.mainController.activateLoanFeePayment,
                    canPayWithWallet: true,
                    canPayWithGateway: false,
                  ),
                  const SizedBox(
                    height: 36.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.validatePaymentPage();
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
