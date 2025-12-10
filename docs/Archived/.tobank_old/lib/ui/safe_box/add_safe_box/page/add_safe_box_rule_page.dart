import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/safe_box/add_safe_box_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';

class AddSafeBoxRulePage extends StatelessWidget {
  const AddSafeBoxRulePage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AddSafeBoxController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Card(
                  elevation: Get.isDarkMode ? 1 : 0,
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
                        child: Text(locale.terms_and_conditions_title_safe_box,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          thickness: 1,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Expanded(
                        child: RawScrollbar(
                          controller: controller.scrollbarController,
                          thumbVisibility: true,
                          radius: const Radius.circular(8.0),
                          thickness: 6.0,
                          thumbColor: Colors.blueGrey.withOpacity(0.5),
                          child: SingleChildScrollView(
                            controller: controller.scrollbarController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: Text(
                                    controller.otherItemData != null
                                        ? AppUtil.getContents(controller.otherItemData!.data!.data!.content!)
                                        : locale.agreement_text,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  locale.confirmation_message_safe_box,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 16,
                    // fontWeight: FontWeight.w500,
                    height: 1.6,
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
                          locale.acceptance_text_safe_box,
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
                height: 20.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validateFirstPage();
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
