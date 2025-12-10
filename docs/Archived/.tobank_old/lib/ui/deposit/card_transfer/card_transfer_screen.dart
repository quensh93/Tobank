import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/deposit/transfer/card_transfer_controller.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../common/loading_page.dart';
import '../../common/transaction_detail_page.dart';
import 'page/card_transfer_amount_page.dart';
import 'page/card_transfer_payment_page.dart';
import 'page/card_transfer_select_destination_page.dart';

class CardTransferScreen extends StatelessWidget {
  const CardTransferScreen({
    required this.deposit,
    required this.hideTabViewFunction,
    super.key,
  });

  final Deposit? deposit;
  final Function(bool isHideTabView) hideTabViewFunction;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardTransferController>(
      init: CardTransferController(deposit: deposit, hideTabViewFunction: hideTabViewFunction),
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvoked: controller.onBackPress,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Expanded(
                    child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    LoadingPage(
                      controller.errorTitle,
                      hasError: controller.hasError,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      isLoading: controller.isCardsLoading,
                      retryFunction: () {
                        controller.getCustomerCardRequest();
                      },
                    ),
                    const CardTransferSelectDestinationPage(),
                    const CardTransferAmountPage(),
                    const CardTransferPaymentPage(),
                    TransactionDetailPage(
                      transactionData: controller.transactionData,
                      cardOwnerName: controller.getCardOwnerName(),
                      screenName: 'CardTransferScreen',
                    ),
                  ],
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
