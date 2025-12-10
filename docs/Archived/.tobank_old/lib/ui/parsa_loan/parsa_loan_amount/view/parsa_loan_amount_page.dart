import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../util/app_util.dart';
import '../../../../../../../util/theme/theme_util.dart';
import '../../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../controller/parsa_loan/parsa_loan_amount_controller.dart';
import '../../../common/key_value_widget.dart';
import '../../../common/selector_item_widget.dart';

class ParsaLoanAmountPage extends StatelessWidget {
  const ParsaLoanAmountPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanAmountController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.specify_requested_amount,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 20,
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
                        KeyValueWidget(
                          keyString: locale.credit_ranking_label,
                          valueString: controller.loanDetail!.extra!.cbsRiskScore,
                        ),
                        const SizedBox(height: 12.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 12.0),
                        Text(
                          locale.payable_amount_label,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.stepDownAmount();
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                Get.isDarkMode
                                    ? 'assets/icons/ic_minus_square_dark.svg'
                                    : 'assets/icons/ic_minus_square.svg',
                                colorFilter: controller.selectedCreditCardAmountData == controller.minPrice
                                    ? ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn)
                                    : null,
                                height: 32.0,
                                width: 32.0,
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  controller.showSelectAmountBottomSheet();
                                },
                                borderRadius: BorderRadius.circular(2.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    locale.amount_format(AppUtil.formatMoney(controller.selectedCreditCardAmountData!)),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.stepUpAmount();
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                Get.isDarkMode
                                    ? 'assets/icons/ic_add_square_dark.svg'
                                    : 'assets/icons/ic_add_square.svg',
                                colorFilter: controller.selectedCreditCardAmountData == controller.maxPrice
                                    ? ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn)
                                    : null,
                                height: 32.0,
                                width: 32.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SfSlider(
                          min: controller.minPrice,
                          max: controller.maxPrice,
                          value: controller.selectedCreditCardAmountData,
                          activeColor: context.theme.colorScheme.secondary,
                          inactiveColor: context.theme.disabledColor,
                          stepSize: controller.amountStep,
                          onChanged: (dynamic value) {
                            controller.setSelectedAmountData(value);
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.amount_format(AppUtil.formatMoney(controller.minPrice)),
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              locale.amount_format(AppUtil.formatMoney(controller.maxPrice)),
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: Get.isDarkMode ? 1 : 0,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SelectorItemWidget(
                          title: locale.detail,
                          isSelected: controller.selectBarValue == 0,
                          callBack: () {
                            controller.setSelectedBar(0);
                          },
                        ),
                      ),
                      Container(
                        height: 24.0,
                        width: 1.0,
                        color: context.theme.dividerColor,
                      ),
                      Expanded(
                        child: SelectorItemWidget(
                          title: locale.collateral,
                          isSelected: controller.selectBarValue == 1,
                          callBack: () {
                            controller.setSelectedBar(1);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (controller.selectBarValue == 0)
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
                            keyString: locale.installment_amount_label,
                            valueString: controller.installment == null
                                ? '-'
                                : locale.amount_format(AppUtil.formatMoney(controller.installment)),
                          ),
                          const SizedBox(height: 16.0),
                          const Divider(thickness: 1),
                          const SizedBox(height: 16.0),
                          KeyValueWidget(
                            keyString: locale.total_repayment_label,
                            valueString: controller.repayment == null
                                ? '-'
                                : locale.amount_format(AppUtil.formatMoney(controller.repayment)),
                          ),
                        ],
                      ),
                    ),
                  )
                else
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
                            keyString: locale.electronic_guarantee_amount,
                            valueString: controller.repayment == null
                                ? '-'
                                : locale.amount_format(AppUtil.formatMoney(controller.getWarrantyAmount())),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateAmountPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
