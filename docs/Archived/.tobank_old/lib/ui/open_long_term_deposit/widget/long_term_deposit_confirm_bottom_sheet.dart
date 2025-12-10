import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/open_long_term_deposit_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class LongTermDepositConfirmBottomSheet extends StatelessWidget {
  const LongTermDepositConfirmBottomSheet({super.key});

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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.deposit_type_label,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                controller.selectedDepositType.localName ?? '',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.source_deposit_number_label,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              controller.selectedSourceDeposit!.depositNumber ?? '',
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.destination_deposit_number_label,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              controller.selectedDestinationDeposit!.depositNumber ?? '',
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.deposit_amount_label,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              locale.amount_format(AppUtil.formatMoney(controller.amount)),
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateFifthPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirm_deposit_button,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
