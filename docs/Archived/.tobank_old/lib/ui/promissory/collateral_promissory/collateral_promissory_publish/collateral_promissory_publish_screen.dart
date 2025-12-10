import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/collateral_promissory/collateral_promissory_publish_controller.dart';
import '../../../../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../../../../model/promissory/collateral_promissory/collateral_promissory_request_data.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'page/collateral_promissory_publish_confirm_page.dart';
import 'page/collateral_promissory_publish_pay_in_browser.dart';
import 'page/collateral_promissory_publish_payment_page.dart';
import 'page/collateral_promissory_publish_rule_page.dart';
import 'page/collateral_promissory_publish_sign_page.dart';

class CollateralPromissoryPublishScreen extends StatelessWidget {
  const CollateralPromissoryPublishScreen(
      {required this.collateralPromissoryRequestData, required this.resultCallback, super.key});

  final CollateralPromissoryRequestData collateralPromissoryRequestData;
  final void Function(CollateralPromissoryPublishResultData collateralPromissoryPublishResultData) resultCallback;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<CollateralPromissoryPublishController>(
          init: CollateralPromissoryPublishController(
              collateralPromissoryRequestData: collateralPromissoryRequestData, resultCallback: resultCallback),
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
                        child: Container(
                          color: context.theme.colorScheme.surface,
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
                                  controller.getRules();
                                },
                              ),
                              const CollateralPromissoryPublishRulePage(),
                              VirtualBranchLoadingPage(
                                controller.errorTitle,
                                hasError: controller.hasError,
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                isLoading: controller.isLoading,
                                retryFunction: () {
                                  controller.getLegalInfoRequest();
                                },
                              ),
                              const CollateralPromissoryPublishConfirmPage(),
                              VirtualBranchLoadingPage(
                                controller.errorTitle,
                                hasError: controller.hasError,
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                isLoading: controller.isLoading,
                                retryFunction: () {
                                  controller.getWalletDetailRequest();
                                },
                              ),
                              const CollateralPromissoryPublishPaymentPage(),
                              CollateralPromissoryPublishPayInBrowserWidget(
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
                              const CollateralPromissoryPublishSignPage(),
                            ],
                          ),
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
