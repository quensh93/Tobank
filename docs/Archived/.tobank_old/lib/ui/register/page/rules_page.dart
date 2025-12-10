import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/register/register_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RegisterController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 32,
                  ),
                  const SizedBox(width: 16.0),
                  Flexible(
                    child: Text(
                      locale.general_terms_and_conditions_title,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16,
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
                child: Card(
                  elevation: 0,
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
                        child: Text(locale.branch_rules_title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ThemeUtil.textTitleColor,
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
                                    AppUtil.getContents(controller.otherItemData!.data!.data!.content!),
                                    style: TextStyle(
                                      color: ThemeUtil.textSubtitleColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
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
                          locale.acceptance_confirmation_text,
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
                  controller.validateRules();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_button_confirm_rules,
                isEnabled: controller.isChecked,
              ),
            ],
          ),
        );
      },
    );
  }
}
