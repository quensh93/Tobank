import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '/ui/bpms/feature/condition_page.dart';
import '../../../../controller/parsa_loan/parsa_loan_controller.dart';
import '../../common/custom_app_bar.dart';

class ParsaLoanScreen extends StatelessWidget {
  const ParsaLoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParsaLoanController>(
      init: ParsaLoanController(),
      builder: (controller) {
//locale
        final locale = AppLocalizations.of(context)!;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString:locale.parsa_facilities,
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
