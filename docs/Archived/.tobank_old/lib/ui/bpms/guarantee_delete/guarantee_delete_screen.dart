import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../controller/bpms/guarantee_delete_controller.dart';
import '../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../common/custom_app_bar.dart';
import '../../common/detail_item_widget.dart';
import '../../common/text_field_clear_icon_widget.dart';

class GuaranteeDeleteScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const GuaranteeDeleteScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GuaranteeDeleteController>(
      init: GuaranteeDeleteController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.remove_guarantor,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                locale.guarantor_defined_message,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(
                                height: 32.0,
                              ),
                              DetailItemWidget(
                                title: locale.guarantee_mobile_title,
                                value: controller.guarantorMobile ?? '',
                                showCopyIcon: false,
                                isSecure: false,
                              ),
                              const SizedBox(height: 16.0),
                              MySeparator(
                                color: context.theme.dividerColor,
                              ),
                              const SizedBox(height: 16.0),
                              DetailItemWidget(
                                title: locale.guarantee_national_code_title,
                                value: controller.guarantorNationalId ?? '',
                                showCopyIcon: false,
                                isSecure: false,
                              ),
                              const SizedBox(height: 16.0),
                              MySeparator(
                                color: context.theme.dividerColor,
                              ),
                              const SizedBox(height: 16.0),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                locale.guarantor_removal_reason,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              TextField(
                                controller: controller.descriptionGuaranteeController,
                                keyboardType: TextInputType.text,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                ),
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: locale.enter_guarantor_removal_reason,
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                  ),
                                  errorText:
                                      controller.isGuaranteeDescriptionValid ? null : locale.enter_guarantor_removal_reason,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 16.0,
                                  ),
                                  suffixIcon: TextFieldClearIconWidget(
                                    isVisible: controller.descriptionGuaranteeController.text.isNotEmpty,
                                    clearFunction: () {
                                      controller.descriptionGuaranteeController.clear();
                                      controller.update();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ContinueButtonWidget(
                                callback: () {
                                  controller.validateDeletePage();
                                },
                                isLoading: controller.isLoading,
                                buttonTitle: locale.remove_guarantor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
