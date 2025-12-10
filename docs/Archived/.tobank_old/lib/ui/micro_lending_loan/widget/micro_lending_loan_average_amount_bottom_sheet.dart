import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/micro_lending_loan/micro_lending_loan_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../common/key_value_widget.dart';

class MicroLendingLoanAverageAmountBottomSheet extends StatelessWidget {
  const MicroLendingLoanAverageAmountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<MicroLendingLoanController>(
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
                  height: 24.0,
                ),
                Text(locale.loan_conditions_title, style: ThemeUtil.titleStyle),
                const SizedBox(height: 12.0),
                Text(
                  locale.loan_conditions_message,
                  style: ThemeUtil.hintStyle,
                ),
                const SizedBox(height: 24.0),
                Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.loanDetail!.extra!.depositAverageMinimumAmountList!.length,
                          itemBuilder: (context, index) {
                            final minimumItem = controller.loanDetail!.extra!.depositAverageMinimumAmountList![index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                KeyValueWidget(
                                  keyString: minimumItem.title!,
                                  valueString: locale.amount_format(AppUtil.formatMoney(minimumItem.depositAverageMinimumAmount!)),
                                ),
                                const SizedBox(height: 8.0),
                                const Divider(thickness: 1),
                                const SizedBox(height: 8.0),
                              ],
                            );
                          },
                        ),
                        KeyValueWidget(
                          keyString: locale.max_payable_loan_key,
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.loanDetail!.extra!.maxPrice!)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                ContinueButtonWidget(
                  callback: () {
                    controller.verifyAverageAmount();
                  },
                  isLoading: false,
                  buttonTitle:locale.confirm_continue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
