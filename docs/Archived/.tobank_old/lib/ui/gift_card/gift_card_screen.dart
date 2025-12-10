import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/gift_card/gift_card_controller.dart';
import '../../model/gift_card/response/costs_data.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import '../common/pay_in_browser.dart';
import '../common/transaction_detail_page.dart';
import 'page/gift_card_confirm_page.dart';
import 'page/gift_card_custom_design_selector_page.dart';
import 'page/gift_card_design_selector_page.dart';
import 'page/gift_card_receiver_info_page.dart';
import 'page/gift_card_select_card_page.dart';

class GiftCardScreen extends StatelessWidget {
  const GiftCardScreen({required this.costsData, super.key});

  final CostsData costsData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<GiftCardController>(
          init: GiftCardController(costsData: costsData),
          builder: (controller) {
            return PopScope(
              canPop: false,
              onPopInvoked: controller.onBackPress,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.gift_card,
                  context: context,
                ),
                body: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          LoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.listOfGiftCardAmountRequest();
                            },
                          ),
                          const GiftCardSelectCardPage(),
                          if (controller.isCustom)
                            const GiftCardCustomDesignSelectorPage()
                          else
                            const GiftCardDesignSelectorPage(),
                          const GiftCardSReceiverInfoPage(),
                          const GiftCardConfirmPage(),
                          PayInBrowserWidget(
                            returnDataFunction: () {
                              controller.validateInternetPayment();
                            },
                            amount: controller.physicalGiftCardDataRequest.cards != null ? controller.getAllCost() : 0,
                            url: controller.physicalGiftCardInternetPayData != null
                                ? controller.physicalGiftCardInternetPayData!.url
                                : '',
                            titleText: locale.gift_card,
                            isLoading: controller.isLoading,
                          ),
                          TransactionDetailPage(
                            transactionData: controller.transactionData,
                            screenName: 'PhysicalGiftCardScreen',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
