import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '/ui/bpms/feature/rule_page.dart';
import '../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_controller.dart';
import '../../../bpms/common/task_list_page.dart';
import '../../../bpms/feature/condition_page.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'page/marriage_loan_customer_check_page.dart';

class MarriageLoanProcedureScreen extends StatelessWidget {
  const MarriageLoanProcedureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MarriageLoanProcedureController>(
      init: MarriageLoanProcedureController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.marriage_loan_,
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
                                controller.getMarriageLoanRulesRequest();
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
                              title: locale.marriage_loan_terms_conditions,
                              checkTitle: locale.accept_marriage_loan_terms_conditions,
                              scrollbarController: controller.scrollbarController,
                              otherItemData: controller.otherItemData,
                              isRuleChecked: controller.isRuleChecked,
                              isLoading: controller.isLoading,
                            ),
                            const MarriageLoanProcedureCustomerCheckPage(),
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
                              taskListControllerTag: MarriageLoanProcedureController.taskListControllerTag,
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
