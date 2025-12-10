import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/ui/bpms/feature/rule_page.dart';
import '../../../controller/micro_lending_loan/micro_lending_loan_controller.dart';
import '..//bpms/feature/condition_page.dart';
import '../common/custom_app_bar.dart';
import '../common/virtual_branch_loading_page.dart';
import '../common/virtual_branch_pay_in_browser.dart';
import 'view/micro_lending_credit_grade_inquiry_page.dart';
import 'view/micro_lending_loan_amount_page.dart';
import 'view/micro_lending_loan_cbs_loading_page.dart';
import 'view/micro_lending_loan_credit_grade_inquiry_rule_page.dart';
import 'view/micro_lending_loan_result_page.dart';
import 'view/micro_lending_loan_sign_contract_page.dart';
import 'view/micro_lending_select_deposit_page.dart';

class MicroLendingLoanScreen extends StatelessWidget {
  const MicroLendingLoanScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MicroLendingLoanController>(
      init: MicroLendingLoanController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.turbo_loan,
                  context: context,
                ),
                body: SafeArea(
                  child: Container(
                    color: context.theme.colorScheme.surface,
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
                                  controller.getCurrentStepRequest();
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
                                title: locale.rules_title,
                                checkTitle: locale.accept_rules,
                                scrollbarController: controller.scrollbarController,
                                otherItemData: controller.otherItemData,
                                isRuleChecked: controller.isRuleChecked,
                                isLoading: controller.isLoading,
                              ),
                              const MicroLendingSelectDepositPage(),
                              VirtualBranchLoadingPage(
                                controller.errorTitle,
                                hasError: controller.hasError,
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                isLoading: controller.isLoading,
                                retryFunction: () {
                                  controller.checkSana();
                                },
                              ),
                              VirtualBranchLoadingPage(
                                controller.errorTitle,
                                hasError: controller.hasError,
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                isLoading: controller.isLoading,
                                retryFunction: () {
                                  controller.getMicroLendingLoanCreditRulesRequest();
                                },
                              ),
                              MicroLendingLoanCreditGradeInquiryRulePage(
                                callback: controller.validateInquiryRules,
                                setChecked: controller.setInquiryChecked,
                                title: locale.credit_score_rules_title,
                                checkTopTitle:
                                    locale.credit_score_rules_notice(controller.config?.expirationDuration),
                                checkTitle: locale.accept_credit_score_rules,
                                scrollbarController: controller.scrollbarController,
                                otherItemData: controller.creditOtherItemData,
                                isRuleChecked: controller.isInquiryRuleChecked,
                                isLoading: controller.isLoading,
                              ),
                              VirtualBranchPayInBrowserWidget(
                                isLoading: controller.isLoading,
                                returnDataFunction: () {
                                  controller.validateInternetPayment();
                                },
                                amount: controller.config?.price ?? 0,
                                url: controller.microLendingFeeInternetPayData != null
                                    ? controller.microLendingFeeInternetPayData!.data!.url
                                    : '',
                                titleText: locale.pay_inquiry_fee,
                              ),
                              const MicroLendingLoanCreditGradeInquiryPage(),
                              const MicroLendingLoanCbsLoadingPage(),
                              const MicroLendingLoanAmountPage(),
                              const MicroLendingLoanSignContractPage(),
                              const MicroLendingLoanResultPage(),
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
