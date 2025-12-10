import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '/ui/bpms/feature/rule_page.dart';
import '../../../../../controller/bpms/credit_card_facility/credit_card_controller.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import '../../common/task_list_page.dart';
import '../../feature/condition_page.dart';
import 'page/credit_card_customer_check_page.dart';
import 'page/credit_card_deposit_selector_page.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<CreditCardController>(
      init: CreditCardController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.credit_card_reception,
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
                                controller.checkAccessRequest();
                              },
                            ),
                            const CreditCardDepositSelectorPage(),
                            VirtualBranchLoadingPage(
                              controller.errorTitle,
                              hasError: controller.hasError,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              isLoading: controller.isLoading,
                              retryFunction: () {
                                controller.getCreditCardRulesRequest();
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
                              title: locale.credit_card_loan_terms,
                              checkTitle: locale.accept_credit_card_loan_terms,
                              scrollbarController: controller.scrollbarRuleController,
                              otherItemData: controller.otherItemData,
                              isRuleChecked: controller.isRuleChecked,
                              isLoading: controller.isLoading,
                            ),
                            const CreditCardCustomerCheckPage(),
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
                              taskListControllerTag: CreditCardController.taskListControllerTag,
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
