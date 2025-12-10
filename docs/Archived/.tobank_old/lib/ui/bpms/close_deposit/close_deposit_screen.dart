import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../controller/bpms/close_deposit/close_deposit_controller.dart';
import '../../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'page/close_deposit_confirm_page.dart';
import 'page/close_deposit_result_page.dart';
import 'page/close_deposit_selector_page.dart';

class CloseDepositScreen extends StatelessWidget {
  const CloseDepositScreen({required this.deposit, super.key});

  final Deposit deposit;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<CloseDepositController>(
      init: CloseDepositController(deposit: deposit),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.close_deposit,
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
                              controller.getDepositBalanceRequest();
                            },
                          ),
                          const CloseDepositConfirmPage(),
                          const CloseDepositSelectorPage(),
                          const CloseDepositResultPage(),
                          VirtualBranchLoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.getTaskDataRequest();
                            },
                          ),
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
