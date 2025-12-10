import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_spouse_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../common/custom_app_bar.dart';
import 'view/marriage_loan_spouse_check_page.dart';
import 'view/marriage_loan_spouse_document_page.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
class MarriageLoanProcedureSpouseScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const MarriageLoanProcedureSpouseScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MarriageLoanProcedureSpouseController>(
      init: MarriageLoanProcedureSpouseController(
        task: task,
        taskData: taskData,
      ),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.upload_spouse_identity_information,
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
                            MarriageLoanProcedureSpouseCheckPage(),
                            MarriageLoanProcedureSpouseDocumentPage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
