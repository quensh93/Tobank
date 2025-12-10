import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/card_to_card/card_to_card_controller.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/common/menu_data_model.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import '../common/transaction_detail_page.dart';
import 'page/card_to_card_amount_page.dart';
import 'page/card_to_card_hub_payment_page.dart';
import 'page/card_to_card_payment_page.dart';
import 'page/card_to_card_select_cards_page.dart';

class CardToCardScreen extends StatelessWidget {
  const CardToCardScreen({
    super.key,
    this.customerCard,
    this.menuItemData,
  });

  final CustomerCard? customerCard;
  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardToCardController>(
        init: CardToCardController(selectedSourceCustomerCard: customerCard),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  appBar: CustomAppBar(
                    titleString: menuItemData != null ? menuItemData!.title! : locale.card_to_card,
                    context: context,
                  ),
                  body: Column(
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
                                controller.getCustomerCard();
                              },
                            ),
                            const CardToCardSelectCardsPage(),
                            const CardToCardAmountPage(),
                            if (controller.isHub()) const CardToCardHubPaymentPage() else const CardToCardPaymentPage(),
                            TransactionDetailPage(
                              transactionData: controller.transactionData,
                              cardOwnerName: controller.getCardOwnerName(),
                              screenName: 'CardToCardScreen',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
