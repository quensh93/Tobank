import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/parsa_loan/parsa_loan_inquiry_controller.dart';
import '../../bpms/feature/rule_page.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';

class ParsaLoanInquiryScreen extends StatelessWidget {
  const ParsaLoanInquiryScreen({required this.trackingNumber, super.key});

  final String trackingNumber;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanInquiryController>(
      init: ParsaLoanInquiryController(trackingNumber: trackingNumber),
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
                                controller.getParsaLoanCommitmentRulesRequest();
                              },
                            ),
                            BPMSRulePage(
                              callback: controller.validateCustomerCommitment,
                              setChecked: controller.setCustomerCommittalChecked,
                              title: locale.customer_commitment_form_title,
                              checkTitle:
                                  locale.commitment_check_title,
                              scrollbarController: controller.scrollbarController,
                              otherItemData: controller.otherItemData,
                              isRuleChecked: controller.isCustomerCommittalChecked,
                              isLoading: controller.isLoading,
                            ),
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
