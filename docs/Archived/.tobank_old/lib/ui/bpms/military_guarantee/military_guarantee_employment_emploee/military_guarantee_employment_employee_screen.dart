import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/military_guarantee/military_guarantee_employment_employee_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../common/custom_app_bar.dart';
import 'view/military_guarantee_employment_employee_page.dart';

class MilitaryGuaranteeEmploymentEmployeeScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const MilitaryGuaranteeEmploymentEmployeeScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeEmploymentEmployeeController>(
      init: MilitaryGuaranteeEmploymentEmployeeController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.military_service_guarantee,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          MilitaryGuaranteeEmploymentEmployeePage(),
                        ],
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
