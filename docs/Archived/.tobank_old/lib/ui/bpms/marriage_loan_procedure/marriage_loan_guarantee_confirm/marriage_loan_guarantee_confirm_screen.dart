import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_guarantee_confirm_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'view/marriage_loan_guarantee_confirm_page.dart';

class MarriageLoanProcedureGuaranteePanelScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const MarriageLoanProcedureGuaranteePanelScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MarriageLoanProcedureGuaranteeConfirmController>(
      init: MarriageLoanProcedureGuaranteeConfirmController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.guarantee_request,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          VirtualBranchLoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.getProcessDetailRequest();
                            },
                          ),
                          const MarriageLoanProcedureGuaranteeConfirmPage(),
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
