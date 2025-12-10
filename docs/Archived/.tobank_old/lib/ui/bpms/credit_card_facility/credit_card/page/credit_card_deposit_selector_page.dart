import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../controller/bpms/credit_card_facility/credit_card_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../widget/credit_card_deposit_item_widget.dart';

class CreditCardDepositSelectorPage extends StatelessWidget {
  const CreditCardDepositSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<CreditCardController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgIcon(
                    SvgIcons.success,
                    colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: Text(
                     locale.user_message_average,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: controller.depositList.isEmpty
                    ? Center(
                        child: Text(
                          locale.no_deposit_message,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        itemBuilder: (context, index) {
                          return CreditCardDepositItemWidget(
                            deposit: controller.depositList[index],
                            selectedDeposit: controller.selectedDeposit,
                            returnDataFunction: (deposit) {
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
              ),
              const SizedBox(
                height: 16,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validateSelectDepositPage();
                },
                isLoading: controller.isLoading,
                buttonTitle:locale.continue_label,
                isEnabled: controller.selectedDeposit != null,
              ),
            ],
          ),
        );
      },
    );
  }
}
