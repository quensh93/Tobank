import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/micro_lending_loan/micro_lending_loan_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import 'amount_item_widget.dart';

class MicroLendingLoanSelectAmountBottomSheet extends StatelessWidget {
  const MicroLendingLoanSelectAmountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<MicroLendingLoanController>(
        builder: (controller) {
          final amountList = controller.selectingAmountList;
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
                Text(locale.select_amount, style: ThemeUtil.titleStyle),
                const SizedBox(height: 24.0),
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 10 / 4,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  children: List<Widget>.generate(amountList.length, (index) {
                    final int amount = amountList[index];
                    return AmountItemWidget(
                      amount: amount,
                      selectedAmount: controller.tempSelectedCreditCardAmountData,
                      returnSelectedFunction: controller.setTempSelectedAmountData,
                    );
                  }),
                ),
                const SizedBox(height: 24.0),
                ContinueButtonWidget(
                  callback: () {
                    controller.confirmSelectAmountBottomSheet();
                  },
                  isLoading: false,
                  buttonTitle: locale.submit_button,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
