import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/request_promissory_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';

class RequestPromissoryRulePage extends StatelessWidget {
  const RequestPromissoryRulePage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RequestPromissoryController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16.0,
              ),
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
                        child: Text(locale.online_promissory_issuance_terms,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      const Divider(
                        thickness: 1,
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
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    controller.otherItemData != null
                                        ? AppUtil.getContents(controller.otherItemData!.data!.data!.content!)
                                        : '',
                                    style: const TextStyle(
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
                height: 24,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () {
                  controller.setChecked(!controller.isRuleChecked);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                            onChanged: (isCheck) {
                              controller.setChecked(isCheck!);
                            }),
                         Flexible(
                          child: Text(
                            locale.accept_online_promissory_terms,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                buttonTitle: locale.continue_label,
                isEnabled: controller.isRuleChecked,
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
