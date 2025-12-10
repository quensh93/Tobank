import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/open_long_term_deposit_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class OpenLongTermDepositRulePage extends StatelessWidget {
  const OpenLongTermDepositRulePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<OpenLongTermDepositController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(locale.general_terms_conditions,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Expanded(
                        child: Scrollbar(
                          controller: controller.scrollbarController,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: controller.scrollbarController,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    AppUtil.getContents(controller.otherItemData.data!.data!.content!),
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
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
                          value: controller.isChecked,
                          onChanged: (isCheck) {
                            controller.setChecked(isCheck!);
                          }),
                      Flexible(
                        child: Text(
                          locale.agree_terms,
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
                height: 24,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validateSecondPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_label,
                isEnabled: controller.isChecked,
              ),
            ],
          ),
        );
      },
    );
  }
}
