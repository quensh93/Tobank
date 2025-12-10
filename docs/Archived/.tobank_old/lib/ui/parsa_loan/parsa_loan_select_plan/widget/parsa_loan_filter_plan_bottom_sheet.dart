import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/parsa_loan/parsa_loan_select_plan_controller.dart';
import '../../../../../util/data_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import 'filter_wage_repayment_item_widget.dart';

class ParsaLoanFilterPlanBottomSheet extends StatelessWidget {
  const ParsaLoanFilterPlanBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    final List<int> wageCosts = DataConstants.getParsaLoanWageCosts();
    final List<int> repaymentDurations = DataConstants.getParsaLoanRepaymentDurations();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<ParsaLoanSelectPlanController>(
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
                      decoration: BoxDecoration(
                        color: context.theme.dividerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(locale.filters, style: ThemeUtil.titleStyle),
                    InkWell(
                      onTap: () {
                        controller.removePlanFilters();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                        child: Text(locale.remove_filters,
                            style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Text(
                  locale.service_fee,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 12.0),
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 2.8,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  children: List<Widget>.generate(wageCosts.length, (index) {
                    return FilterWageRepaymentItemWidget(
                      item: wageCosts[index],
                      selectedItem: controller.tempSelectedWageCostFilterData,
                      tail: locale.percent,
                      returnSelectedFunction: controller.setTempSelectedWageCostFilterData,
                    );
                  }),
                ),
                const SizedBox(height: 24.0),
                Text(
                  locale.repayment,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 12.0),
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 2.8,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  children: List<Widget>.generate(repaymentDurations.length, (index) {
                    return FilterWageRepaymentItemWidget(
                      item: repaymentDurations[index],
                      selectedItem: controller.tempSelectedRepaymentDurationFilterData,
                      tail: locale.monthly,
                      returnSelectedFunction: controller.setTempSelectedRepaymentDurationFilterData,
                    );
                  }),
                ),
                const SizedBox(height: 24.0),
                ContinueButtonWidget(
                  callback: () {
                    controller.setSelectedWageRepaymentFilterData();
                  },
                  isLoading: false,
                  buttonTitle: locale.apply_filters,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
