import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/open_long_term_deposit_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../open_long_term_deposit_item_widget.dart';

class LongTermDepositDestinationSelectorBottomSheet extends StatelessWidget {
  const LongTermDepositDestinationSelectorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<OpenLongTermDepositController>(
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
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
                Text(
                  locale.destination_deposit_selection_title,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
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
                        locale.select_destination_deposit_message,
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      itemBuilder: (context, index) {
                        return OpenLongTermDepositItemWidget(
                          deposit: controller.depositList[index],
                          selectedDeposit: controller.selectedDestinationDeposit,
                          returnDataFunction: (deposit) {
                            controller.setSelectedDestinationDeposit(deposit);
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
                    controller.validateFourthPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
                  isEnabled: controller.selectedDestinationDeposit != null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
