import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/promissory/continue_request_promissory_controller.dart';
import '../../../../model/promissory/response/promissory_request_history_response_data.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import '../request_promissory/page/promissory_transaction_detail_page.dart';
import 'page/continue_request_promissory_pay_in_browser.dart';
import 'page/continue_request_promissory_sign_page.dart';

class ContinueRequestPromissoryScreen extends StatelessWidget {
  const ContinueRequestPromissoryScreen({
    required this.promissoryRequest,
    super.key,
  });

  final PromissoryRequest promissoryRequest;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<ContinueRequestPromissoryController>(
          init: ContinueRequestPromissoryController(promissoryRequest: promissoryRequest),
          builder: (controller) {
            return PopScope(
              canPop: false,
              onPopInvoked: controller.onBackPress,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: '${locale.continue_label} ${promissoryRequest.faServiceName}',
                  context: context,
                ),
                body: SafeArea(
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
                                controller.fetchPromissoryUnsignedDocumentRequest();
                              },
                            ),
                            ContinueRequestPromissoryPayInBrowserWidget(
                              isLoading: controller.isLoading,
                              returnDataFunction: () {
                                controller.validateInternetPayment();
                              },
                              amount: controller.getCorrectAmount(),
                              url: controller.promissoryInternetPaymentResponseData != null
                                  ? controller.promissoryInternetPaymentResponseData!.data!.url
                                  : '',
                              titleText: locale.online_promissory_and_bill_issuance,
                            ),
                            const ContinueRequestPromissorySignPage(),
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
