import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/safe_box/add_safe_box_controller.dart';
import '../../common/custom_app_bar.dart';
import '../../common/pay_in_browser.dart';
import '../../common/transaction_detail_page.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'page/add_safe_box_branch_list_page.dart';
import 'page/add_safe_box_list_page.dart';
import 'page/add_safe_box_rule_page.dart';

class AddSafeBoxScreen extends StatelessWidget {
  const AddSafeBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AddSafeBoxController>(
      init: AddSafeBoxController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.rent_safety_box,
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
                                controller.getSafeBoxRulesRequest();
                              },
                            ),
                            const AddSafeBoxRulePage(),
                            const AddSafeBoxBranchListPage(),
                            const AddSafeBoxListPage(),
                            PayInBrowserWidget(
                              isLoading: controller.isLoading,
                              returnDataFunction: () {
                                controller.validateInternetPayment();
                              },
                              amount: controller.selectedFund != null ? controller.selectedFund!.paymentAmount : 0,
                              url: controller.safeBoxInternetPayData != null
                                  ? controller.safeBoxInternetPayData!.data!.url
                                  : '',
                              titleText: locale.safe_box_title,
                            ),
                            TransactionDetailPage(
                              transactionData: controller.transactionData,
                              screenName: 'SafeBoxScreen',
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
