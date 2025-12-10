import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_charge_deposit_controller.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';

class MilitaryGuaranteeChargeDepositPage extends StatelessWidget {
  const MilitaryGuaranteeChargeDepositPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeChargeDepositController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.insufficient_balance,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    border: Border.all(
                      color: Get.isDarkMode ? context.theme.colorScheme.surface : ThemeUtil.borderColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locale.expert_opinion,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          controller.calculateFeeDescription!,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(thickness: 2),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.cash_deposit,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              controller.cashDeposit!,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                             locale.fees_and_charges,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              locale.amount_format(AppUtil.formatMoney(controller.cashTotalAmount)),
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.current_cash_deposit_balance,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              locale.amount_format(AppUtil.formatMoney(controller.cashDepositBalance!)),
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.collateral_deposit,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              controller.collateralDeposit!,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.collateral_amount,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              locale.amount_format(AppUtil.formatMoney(controller.collateralTotalAmount)),
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.current_collateral_deposit_balance,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              locale.amount_format(AppUtil.formatMoney(controller.collateralDepositBalance!)),
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateCheckBalance();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.check_balance_button,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
