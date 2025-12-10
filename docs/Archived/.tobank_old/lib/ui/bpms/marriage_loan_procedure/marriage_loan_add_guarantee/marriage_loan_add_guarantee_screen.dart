import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_add_guarantee_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';


class MarriageLoanProcedureAddGuaranteeScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const MarriageLoanProcedureAddGuaranteeScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MarriageLoanProcedureAddGuaranteeController>(
      init: MarriageLoanProcedureAddGuaranteeController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.marriage_loan_,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                locale.guarantee_info_title,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              Text(
                                locale.guarantee_mobile_title,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              TextField(
                                controller: controller.mobileGuaranteeController,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                  fontFamily: 'IranYekan',
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(11),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  controller.update();
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: locale.guarantee_mobile_title,
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                  ),
                                  errorText:
                                      controller.isGuaranteeMobileValid ? null : locale.guarantee_mobile_error,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  suffixIcon: TextFieldClearIconWidget(
                                    isVisible: controller.mobileGuaranteeController.text.isNotEmpty,
                                    clearFunction: () {
                                      controller.mobileGuaranteeController.clear();
                                      controller.update();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                locale.guarantee_birthday_title,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        controller.showSelectDateDialog();
                                      },
                                      child: IgnorePointer(
                                        child: TextField(
                                          controller: controller.birthdayDateGuaranteeController,
                                          enabled: true,
                                          readOnly: true,
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'IranYekan',
                                            fontSize: 16.0,
                                          ),
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            filled: false,
                                            hintText: locale.guarantee_birthday_hint,
                                            hintStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                            ),
                                            errorText: controller.isBirthdayGuaranteeValid
                                                ? null
                                                : locale.guarantee_birthday_error,
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                            ),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SvgIcon(
                                                SvgIcons.calendar,
                                                colorFilter: ColorFilter.mode(
                                                    context.theme.colorScheme.secondary, BlendMode.srcIn),
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                locale.guarantee_national_code_title,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              TextField(
                                controller: controller.nationalCodeGuaranteeController,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                  fontFamily: 'IranYekan',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  controller.update();
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: locale.guarantee_national_code_hint,
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                  ),
                                  errorText: controller.isNationalCodeGuaranteeValid ? null : locale.national_code_error_,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  suffixIcon: TextFieldClearIconWidget(
                                    isVisible: controller.nationalCodeGuaranteeController.text.isNotEmpty,
                                    clearFunction: () {
                                      controller.nationalCodeGuaranteeController.clear();
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
                                  controller.validateGuaranteeCheck();
                                },
                                isLoading: controller.isLoading,
                                buttonTitle: locale.submit_button,
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
