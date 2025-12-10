import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/ui/bpms/feature/rule_page.dart';
import '../../../../../controller/bpms/rayan_card_facility/rayan_card_controller.dart';
import '../../../bpms/common/task_list_page.dart';
import '../../../bpms/feature/condition_page.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'page/rayan_card_customer_check_page.dart';

class RayanCardScreen extends StatelessWidget {
  const RayanCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RayanCardController>(
      init: RayanCardController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.rayan_card_facility,
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
                                controller.getRayanCardRulesRequest();
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
                              title: locale.rayan_card_loan_conditions_and_rules_title,
                              checkTitle: locale.rayan_card_accept_loan_rules_and_conditions,
                              scrollbarController: controller.scrollbarController,
                              otherItemData: controller.otherItemData,
                              isRuleChecked: controller.isRuleChecked,
                              isLoading: controller.isLoading,
                            ),
                            const RayanCardCustomerCheckPage(),
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
                              taskListControllerTag: RayanCardController.taskListControllerTag,
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
