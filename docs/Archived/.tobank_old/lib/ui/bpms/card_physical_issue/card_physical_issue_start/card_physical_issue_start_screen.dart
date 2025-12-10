import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/card_physical_issue/card_physical_issue_start_controller.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'view/card_physical_issue_start_address_page.dart';
import 'view/card_physical_issue_start_card_template_page.dart';
import 'view/card_physical_issue_start_result_page.dart';

class CardPhysicalIssueStartScreen extends StatelessWidget {
  const CardPhysicalIssueStartScreen({
    required this.depositNumber,
    super.key,
  });

  final String depositNumber;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardPhysicalIssueStartController>(
      init: CardPhysicalIssueStartController(
        depositNumber: depositNumber,
      ),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.card_issuance_request,
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
                              controller.getDibalitePublicKeyRequest();
                            },
                          ),
                          const CardPhysicalIssueStartAddressPage(),
                          const CardPhysicalIssueStartCardTemplatePage(),
                          const CardPhysicalIssueStartResultPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
