import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../controller/bpms/close_deposit/close_deposit_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/key_value_widget.dart';
import '../widget/close_deposit_item_widget.dart';

class CloseDepositSelectorPage extends StatelessWidget {
  const CloseDepositSelectorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<CloseDepositController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        KeyValueWidget(
                          keyString: '${locale.deposit_number}:',
                          valueString: controller.deposit.depositNumber,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: '${locale.deposit_inventory}:',
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.getBalance())),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              if (controller.depositList.isEmpty || controller.getBalance() == 0)
                Container()
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        locale.deposit_account_message,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        itemBuilder: (context, index) {
                          return CloseDepositItemWidget(
                            deposit: controller.depositList[index],
                            selectedDeposit: controller.selectedDeposit,
                            setSelectedDepositFunction: (deposit) {
                              controller.setSelectedDeposit(deposit);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemCount: controller.depositList.length),
                  ],
                ),
              const SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ContinueButtonWidget(
                  callback: () {
                    controller.validateSelectorPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirm_and_close_deposit,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
