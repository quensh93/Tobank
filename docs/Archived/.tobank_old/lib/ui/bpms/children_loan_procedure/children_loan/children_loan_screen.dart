import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/ui/bpms/feature/rule_page.dart';
import '../../../../../controller/bpms/children_loan_procedure/children_loan_controller.dart';
import '../../../bpms/common/task_list_page.dart';
import '../../../bpms/feature/condition_page.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'page/children_loan_customer_check_page.dart';

class ChildrenLoanProcedureScreen extends StatelessWidget {
  const ChildrenLoanProcedureScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ChildrenLoanProcedureController>(
      init: ChildrenLoanProcedureController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.children_loan,
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
                                controller.getChildrenLoanRulesRequest();
                              },
                            ),
                            BPMSConditionPage(
                              callback: controller.validateFirstPage,
                              webViewController: controller.webViewController,
                              webViewKey: controller.webViewKey,
                              progress: controller.progress,
                              conditionUrl: controller.getConditionUrl(),
                              settings: controller.webViewSettings,
                              setProgress: controller.setProgress,
                              isLoading: controller.isLoading,
                            ),
                            BPMSRulePage(
                              callback: controller.validateRules,
                              setChecked: controller.setChecked,
                              title: locale.conditions_children,
                              checkTitle: locale.accept_conditions_children,
                              scrollbarController: controller.scrollbarController,
                              otherItemData: controller.otherItemData,
                              isRuleChecked: controller.isRuleChecked,
                              isLoading: controller.isLoading,
                            ),
                            const ChildrenLoanProcedureCustomerCheckPage(),
                            VirtualBranchLoadingPage(
                              controller.errorTitle,
                              hasError: controller.hasError,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              isLoading: controller.isLoading,
                              retryFunction: () {
                                controller.getApplicantTaskListRequest();
                              },
                            ),
                            const TaskListPage(
                              taskListControllerTag: ChildrenLoanProcedureController.taskListControllerTag,
                            ),
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
