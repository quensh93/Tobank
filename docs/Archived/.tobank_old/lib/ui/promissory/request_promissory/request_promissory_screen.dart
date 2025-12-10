import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/promissory/request_promissory_controller.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'page/promissory_transaction_detail_page.dart';
import 'page/request_promissory_confirm_page.dart';
import 'page/request_promissory_data_page.dart';
import 'page/request_promissory_issuer_page.dart';
import 'page/request_promissory_pay_in_browser.dart';
import 'page/request_promissory_receiver_page.dart';
import 'page/request_promissory_rule_page.dart';
import 'page/request_promissory_sign_page.dart';

class RequestPromissoryScreen extends StatelessWidget {
  const RequestPromissoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<RequestPromissoryController>(
          init: RequestPromissoryController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.promissory_issuance,
                context: context,
              ),
              body: SafeArea(
                child: PopScope(
                  canPop: false,
                  onPopInvoked: controller.onBackPress,
                  child: Column(
                    children: <Widget>[
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
                                controller.getRulesRequest();
                              },
                            ),
                            const RequestPromissoryRulePage(),
                            const RequestPromissoryIssuerPage(),
                            const RequestPromissoryReceiverPage(),
                            const RequestPromissoryDataPage(),
                            const RequestPromissoryConfirmPage(),
                            VirtualBranchLoadingPage(
                              '',
                              hasError: true,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              isLoading: controller.isLoading,
                              retryFunction: () {
                                controller.getWalletDetailRequest();
                              },
                            ),
                            RequestPromissoryPayInBrowserWidget(
                              isLoading: controller.isLoading,
                              returnDataFunction: () {
                                controller.validateInternetPayment();
                              },
                              amount: controller.getCorrectAmount(),
                              url: controller.promissoryInternetPaymentResponseData != null
                                  ? controller.promissoryInternetPaymentResponseData!.data!.url
                                  : '',
                              titleText: locale.promissory_issuance,
                            ),
                            const RequestPromissorySignPage(),
                            PromissoryTransactionDetailPage(
                              transactionData: controller.transactionData,
                              screenName: 'RequestPromissoryScreen',
                              multiSignPath: controller.multiSignPath,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
