import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/parsa_loan/parsa_loan_get_customer_score_controller.dart';
import '../../bpms/feature/rule_page.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'page/parsa_loan_get_customer_score_loading_page.dart';

class ParsaLoanGetCustomerScoreScreen extends StatelessWidget {
  const ParsaLoanGetCustomerScoreScreen({required this.trackingNumber, super.key});

  final String trackingNumber;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanGetCustomerScoreController>(
      init: ParsaLoanGetCustomerScoreController(trackingNumber: trackingNumber),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.parsa_facilities,
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
                                controller.getParsaLoanCreditRulesRequest();
                              },
                            ),
                            BPMSRulePage(
                              callback: controller.validateInquiryRules,
                              setChecked: controller.setInquiryChecked,
                              title: locale.credit_score_rules_title,
                              checkTitle: locale.accept_credit_score_rules,
                              scrollbarController: controller.scrollbarController,
                              otherItemData: controller.creditOtherItemData,
                              isRuleChecked: controller.isInquiryRuleChecked,
                              isLoading: controller.isLoading,
                            ),
                            const ParsaLoanGetCustomerScoreLoadingPage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
