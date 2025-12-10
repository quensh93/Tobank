import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../util/app_util.dart';
import '../../../../../../../util/theme/theme_util.dart';
import '../../../../../../../widget/button/continue_button_widget.dart';
import '../../../../controller/micro_lending_loan/micro_lending_loan_controller.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../common/key_value_widget.dart';
import '../widget/repayment_duration_item_widget.dart';

class MicroLendingLoanAmountPage extends StatelessWidget {
  const MicroLendingLoanAmountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MicroLendingLoanController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.loan_request_title,
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
                          valueString: controller.loanDetail!.extra!.cbsRiskScore!,
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 16.0),
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
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.minusSquareDark : SvgIcons.minusSquare,
                                colorFilter:
                                    controller.selectedCreditCardAmountData == controller.loanDetail!.extra!.minPrice!
                                        ? ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn)
                                        : null,
                                size: 32.0,
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
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.addSquareDark : SvgIcons.addSquare,
                                colorFilter:
                                    controller.selectedCreditCardAmountData == controller.loanDetail!.extra!.maxPrice!
                                        ? ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn)
                                        : null,
                                size: 32.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SfSlider(
                          min: controller.loanDetail!.extra!.minPrice!,
                          max: controller.loanDetail!.extra!.maxPrice!,
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
                              locale.amount_format(AppUtil.formatMoney(controller.loanDetail!.extra!.minPrice!)),
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              locale.amount_format(AppUtil.formatMoney(controller.loanDetail!.extra!.maxPrice!)),
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),
                        Text(
                          locale.repayment_duration_label,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GridView(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: controller.repaymentDurationOptions.length,
                            mainAxisSpacing: 16.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 2.8,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          children: List<Widget>.generate(controller.repaymentDurationOptions.length, (index) {
                            return RepaymentDurationItemWidget(
                              duration: controller.repaymentDurationOptions[index],
                              selectedDuration: controller.repaymentDuration,
                              returnSelectedFunction: (value) {
                                controller.setRepaymentDuration(value);
                              },
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
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
                      children: [
                        KeyValueWidget(
                          keyString: locale.installment_amount,
                          valueString: controller.installment == null
                              ? '-'
                              : locale.amount_format(AppUtil.formatMoney(controller.installment)),
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 16.0),
                        KeyValueWidget(
                          keyString: locale.total_repayment_label,
                          valueString:
                              controller.repayment == null ? '-' : locale.amount_format(AppUtil.formatMoney(controller.repayment)),
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
