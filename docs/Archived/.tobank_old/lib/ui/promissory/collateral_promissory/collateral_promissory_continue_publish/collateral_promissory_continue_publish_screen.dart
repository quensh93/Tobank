import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/collateral_promissory/collateral_promissory_continue_publish_controller.dart';
import '../../../../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../../../../model/promissory/response/promissory_request_history_response_data.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'page/collateral_promissory_continue_publish_pay_in_browser.dart';
import 'page/collateral_promissory_continue_publish_sign_page.dart';

class CollateralPromissoryContinuePublishScreen extends StatelessWidget {
  const CollateralPromissoryContinuePublishScreen({
    required this.promissoryRequest,
    required this.resultCallback,
    super.key,
  });

  final PromissoryRequest promissoryRequest;
  final void Function(CollateralPromissoryPublishResultData collateralPromissoryPublishResultData) resultCallback;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CollateralPromissoryContinuePublishController>(
        init: CollateralPromissoryContinuePublishController(
          promissoryRequest: promissoryRequest,
          resultCallback: resultCallback,
        ),
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
                          CollateralPromissoryContinuePublishPayInBrowserWidget(
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
                          const CollateralPromissoryContinuePublishSignPage(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
