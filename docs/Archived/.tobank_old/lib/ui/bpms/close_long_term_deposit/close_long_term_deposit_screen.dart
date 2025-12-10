import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/bpms/close_long_term_deposit/close_long_term_deposit_controller.dart';
import '../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'view/close_long_term_deposit_result_page.dart';
import 'view/close_long_term_deposit_selector_page.dart';

class CloseLongTermDepositScreen extends StatelessWidget {
  const CloseLongTermDepositScreen({required this.task, required this.taskData, super.key});

  final Task task;
  final List<TaskDataFormField> taskData;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return GetBuilder<CloseLongTermDepositController>(
      init: CloseLongTermDepositController(
        task: task,
        taskData: taskData,
      ),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.close_deposit,
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
                              controller.getDepositBalanceRequest();
                            },
                          ),
                          const CloseLongTermDepositSelectorPage(),
                          const CloseLongTermDepositResultPage(),
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
