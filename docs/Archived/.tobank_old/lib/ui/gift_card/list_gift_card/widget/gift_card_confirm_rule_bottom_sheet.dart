import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/gift_card/gift_card_list_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class GiftCardConfirmRuleBottomSheet extends StatelessWidget {
  const GiftCardConfirmRuleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<GiftCardListController>(
        builder: (controller) {
          final String deliveryCost = AppUtil.formatMoney(controller.costsData!.data!.deliveryCost.toString());
          final String chargeAmount = AppUtil.formatMoney(controller.costsData!.data!.chargeAmount.toString());
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
                Text(locale.buy_gift_card, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.buy_gift_card_message(deliveryCost, chargeAmount),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 16.0,
                    height: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      activeColor: context.theme.colorScheme.secondary,
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (!states.contains(WidgetState.selected)) {
                          return Colors.transparent;
                        }
                        return null;
                      }),
                      value: controller.confirmRules,
                      onChanged: (value) {
                        controller.setConfirmRules(value);
                      },
                    ),
                    Flexible(
                        child: InkWell(
                      onTap: () {
                        controller.showRulesScreen();
                      },
                      child: RichText(
                        text: TextSpan(
                          text: '${locale.rules_and_regulations} ',
                          style: TextStyle(
                            color: context.theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'IranYekan',
                            height: 1.6,
                            fontSize: 16.0,
                          ),
                          children: <TextSpan>[

                            TextSpan(
                                text: locale.accept_terms,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontFamily: 'IranYekan',
                                  fontWeight: FontWeight.w600,
                                  height: 1.6,
                                  fontSize: 14.0,
                                )),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  !controller.isValidateData ? locale.validate_terms_warning : '',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: context.theme.colorScheme.error,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.giftCardConfirmRule();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
                  isEnabled: controller.confirmRules,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
