import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/safe_box/add_safe_box_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/payment_method_widget.dart';

class SelectPaymentBottomSheet extends StatelessWidget {
  const SelectPaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<AddSafeBoxController>(
        builder: (controller) {
          return Padding(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          Get.isDarkMode ? SvgIcons.safeBoxDark : SvgIcons.safeBox,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Center(child: Text(locale.safe_box_title, style: ThemeUtil.titleStyle)),
                const SizedBox(
                  height: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          locale.payable_amount_label,
                          style: TextStyle(
                              color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w500, fontSize: 14.0),
                        ),
                        Row(
                          children: [
                            Text(
                              AppUtil.formatMoney(controller.selectedFund!.paymentAmount),
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
                    const SizedBox(
                      height: 16.0,
                    ),
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
                      canPayWithDeposit: false,
                      canPayWithWallet: true,
                      canPayWithGateway: true,
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
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
