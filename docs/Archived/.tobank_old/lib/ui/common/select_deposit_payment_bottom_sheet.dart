import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../util/theme/theme_util.dart';
import '../../controller/common/select_deposit_payment_controller.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../widget/button/continue_button_widget.dart';
import '../bpms/feature/deposit_with_balance_item_widget.dart';

class SelectDepositPaymentBottomSheet extends StatelessWidget {
  const SelectDepositPaymentBottomSheet({
    required this.depositList,
    required this.selectDeposit,
    super.key,
  });

  final List<Deposit> depositList;
  final Function(Deposit deposit) selectDeposit;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<SelectDepositPaymentController>(
          init: SelectDepositPaymentController(
            depositList: depositList,
            selectDeposit: selectDeposit,
          ),
          builder: (controller) {
            return Column(
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
                Text(
                  locale.select_deposit_for_payment,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () {
                              selectDeposit(depositList[index]);
                            },
                            child: BPMSDepositWithBalanceItemWidget(
                              deposit: depositList[index],
                              setSelectedDepositFunction: () =>
                                  controller.setSelectedDepositFunction(depositList[index]),
                              isDepositBalanceLoading:
                                  controller.depositBalanceLoadingMap[depositList[index].depositNumber!] ?? false,
                              balanceFunction: () => controller.getDepositBalanceRequest(depositList[index], false),
                              selectedDeposit: controller.selectedDeposit,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(thickness: 1);
                        },
                        itemCount: depositList.length),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateDeposit();
                  },
                  isLoading: false,
                  buttonTitle: locale.payment_button,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
