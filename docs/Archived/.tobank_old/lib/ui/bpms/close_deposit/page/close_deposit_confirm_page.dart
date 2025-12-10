import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../controller/bpms/close_deposit/close_deposit_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';

class CloseDepositConfirmPage extends StatelessWidget {
  const CloseDepositConfirmPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<CloseDepositController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  border: Border.all(
                    color: context.theme.dividerColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: context.theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: SvgIcon(
                                SvgIcons.warning,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                            child: Text(
                              locale.customer_commitment_to_non_connection_of_requested_deposit,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                height: 1.6,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(locale.customer_responsibility_disclaimer,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          height: 1.6,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: context.theme.dividerColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: context.theme.colorScheme.secondary,
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (!states.contains(WidgetState.selected)) {
                            return Colors.transparent;
                          }
                          return null;
                        }),
                        value: controller.isRuleChecked,
                        onChanged: (v) => controller.setChecked(v!),
                      ),
                      Flexible(
                        child: Text(
                         locale.customer_responsibility_disclaimer,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validateConfirmPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.next_step,
              ),
            ],
          ),
        );
      },
    );
  }
}
