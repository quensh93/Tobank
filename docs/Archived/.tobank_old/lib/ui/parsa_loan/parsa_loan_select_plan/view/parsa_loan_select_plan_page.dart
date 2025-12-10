import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/util/theme/theme_util.dart';
import '/widget/button/continue_button_widget.dart';
import '../../../../../controller/parsa_loan/parsa_loan_select_plan_controller.dart';
import '../widget/parsa_loan_plan_item_widget.dart';

class ParsaLoanSelectPlanPage extends StatelessWidget {
  const ParsaLoanSelectPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return GetBuilder<ParsaLoanSelectPlanController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 32.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.average_period,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: ThemeUtil.textTitleColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.showFilterPlanBottomSheet();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(color: context.theme.dividerColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/ic_filter.svg',
                                  colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  locale.filters,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  InkWell(
                    onTap: () {
                      controller.openSelectMonthBottomSheet();
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: controller.monthController,
                        keyboardType: TextInputType.text,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        readOnly: true,
                        enabled: true,
                        enableInteractiveSelection: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        decoration:  InputDecoration(
                          filled: true,
                          hintText: locale.select_average_period,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 16.0,
                          ),
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            if (controller.selectedAveragingPeriodFilterData != null)
              Expanded(
                child: controller.selectedAveragingPeriodFilterData != null && controller.parsaPlanList.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                            height: 100,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            locale.no_plan_found,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            locale.parsa_loan_plans_based_on_balance,
                            textAlign: TextAlign.right,
                            style: ThemeUtil.titleStyle,
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                              itemCount: controller.parsaPlanList.length,
                              itemBuilder: (context, index) {
                                return ParsaLoanPlanItemWidget(
                                  index: index,
                                  selectedIndex: controller.selectedParsaLoanPlanIndex,
                                  planData: controller.parsaPlanList[index],
                                  selectedPlanData: controller.selectedParsaLoanPlan,
                                  setSelectedPlanFunction: controller.setSelectedParsaLoanPlan,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 16,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ContinueButtonWidget(
                                  callback: () {
                                    controller.validateSelectPlanPage();
                                  },
                                  isLoading: controller.isLoading,
                                  buttonTitle: locale.continue_label,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
              )
            else
              controller.allParsaPlanList.isEmpty && controller.selectedAveragingPeriodFilterData != null
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              locale.average_not_found_in_period,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Center(
                              child: SvgPicture.asset(
                                'assets/icons/ic_empty_wallet.svg',
                                width: 240,
                                height: 240,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
          ],
        );
      },
    );
  }
}
