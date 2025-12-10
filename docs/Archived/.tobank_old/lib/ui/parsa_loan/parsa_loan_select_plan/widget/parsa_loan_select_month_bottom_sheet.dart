import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/parsa_loan/parsa_loan_select_plan_controller.dart';
import '../../../../../util/theme/theme_util.dart';

class ParsaLoanSelectMonthBottomSheet extends StatelessWidget {
  const ParsaLoanSelectMonthBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
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
                        decoration:
                            BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Expanded(
                  child: controller.averagingPeriodFilterDataList.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                              height: 180,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                             Text(
                              locale.averaging_period_not_found,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
                            ),
                          ],
                        )
                      : ListView.separated(
                          itemCount: controller.averagingPeriodFilterDataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                controller
                                    .setAveragingPeriodFilterData(controller.averagingPeriodFilterDataList[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.averagingPeriodFilterDataList[index].durationInMonths.toString(),
                                  style: ThemeUtil.titleStyle,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(thickness: 1);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
