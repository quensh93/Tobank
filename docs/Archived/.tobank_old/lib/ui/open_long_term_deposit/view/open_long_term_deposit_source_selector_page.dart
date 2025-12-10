import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/open_long_term_deposit_controller.dart';
import '../../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../open_long_term_deposit_item_widget.dart';

class OpenLongTermDepositSourceSelectorPage extends StatelessWidget {
  const OpenLongTermDepositSourceSelectorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<OpenLongTermDepositController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Text(
                locale.select_deposit,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgIcon(
                    SvgIcons.success,
                    colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                    child: Text(
                      locale.deposit_instructions,
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
              Row(
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
                      locale.minimum_deposit_amount_10mil_rial,
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
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    itemBuilder: (context, index) {
                      return OpenLongTermDepositItemWidget(
                        deposit: controller.depositList[index],
                        selectedDeposit: controller.selectedSourceDeposit,
                        returnDataFunction: (Deposit deposit) {
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
                height: 16.0,
              ),
              ContinueButtonWidget(
                isLoading: controller.isLoading,
                callback: () {
                  controller.showLongTermDepositAmountBottomSheet();
                },
                buttonTitle: locale.continue_label,
                isEnabled: controller.selectedSourceDeposit != null,
              ),
            ],
          ),
        );
      },
    );
  }
}
