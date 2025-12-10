import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/parsa_loan/parsa_loan_select_plan_controller.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'view/parsa_loan_select_plan_page.dart';

class ParsaLoanSelectPlanScreen extends StatelessWidget {
  const ParsaLoanSelectPlanScreen({required this.trackingNumber, super.key});

  final String trackingNumber;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanSelectPlanController>(
      init: ParsaLoanSelectPlanController(trackingNumber: trackingNumber),
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
                                controller.getLoanDetailRequest();
                              },
                            ),
                            const ParsaLoanSelectPlanPage(),
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
