import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/children_loan_procedure/children_loan_child_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../common/custom_app_bar.dart';
import 'page/children_loan_child_check_page.dart';
import 'page/children_loan_child_document_page.dart';

class ChildrenLoanProcedureChildScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const ChildrenLoanProcedureChildScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ChildrenLoanProcedureChildController>(
      init: ChildrenLoanProcedureChildController(
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
                  titleString: locale.child_identity_information_upload,
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
                            ChildrenLoanProcedureChildCheckPage(),
                            ChildrenLoanProcedureChildDocumentPage(),
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
