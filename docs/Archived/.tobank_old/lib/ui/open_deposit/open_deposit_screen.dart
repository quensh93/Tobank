import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/deposit/open_deposit_controller.dart';
import '../../../model/deposit/response/deposit_type_response_data.dart';
import '../common/custom_app_bar.dart';
import '../common/virtual_branch_loading_page.dart';
import 'page/open_deposit_result_page.dart';
import 'page/open_deposit_rule_page.dart';
import 'page/request_card_result_page.dart';
import 'page/request_card_selector_page.dart';
import 'page/request_card_template_page.dart';

class OpenDepositScreen extends StatelessWidget {
  const OpenDepositScreen({
    required this.selectedDepositType,
    this.branchCode,
    super.key,
  });

  final DepositType selectedDepositType;
  final int? branchCode;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<OpenDepositController>(
      init: OpenDepositController(selectedDepositType: selectedDepositType, branchCode: branchCode),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.deposit_button_opening,
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
                                controller.validateFirstPage();
                              },
                            ),
                            const OpenDepositRulePage(),
                            const OpenDepositResultPage(),
                            VirtualBranchLoadingPage(
                              controller.errorTitle,
                              hasError: controller.hasError,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              isLoading: controller.isLoading,
                              retryFunction: () {
                                controller.getDibalitePublicKeyRequest();
                              },
                            ),
                            const RequestCardSelectorPage(),
                            const RequestCardTemplatePage(),
                            const RequestCardResultPage(),
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
