import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/ui/bpms/feature/deposit_page.dart';
import '/ui/bpms/feature/rule_page.dart';
import '../../../../../controller/bpms/retail_loan/retail_loan_controller.dart';
import '../../../bpms/common/task_list_page.dart';
import '../../../bpms/feature/condition_page.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'view/retail_loan_customer_check_page.dart';

class RetailLoanScreen extends StatelessWidget {
  const RetailLoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RetailLoanController>(
      init: RetailLoanController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.small_loan,
                  context: context,
                ),
                body: SafeArea(
                  child: Container(
                    color: context.theme.colorScheme.surface,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16.0,
                        ),
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
                                  controller.getRetailLoanRulesRequest();
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
                                title: locale.small_loan_terms_and_conditions,
                                checkTitle: locale.accept_small_loan_terms_and_conditions,
                                scrollbarController: controller.scrollbarController,
                                otherItemData: controller.otherItemData,
                                isRuleChecked: controller.isRuleChecked,
                                isLoading: controller.isLoading,
                              ),
                              BPMSDepositPage(
                                callback: controller.validateSelectDepositPage,
                                setSelectedDepositFunction: controller.setSelectedDeposit,
                                depositList: controller.depositList,
                                selectedDeposit: controller.selectedDeposit,
                                isLoading: controller.isLoading,
                              ),
                              const RetailLoanCustomerCheckPage(),
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
                                taskListControllerTag: RetailLoanController.taskListControllerTag,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
