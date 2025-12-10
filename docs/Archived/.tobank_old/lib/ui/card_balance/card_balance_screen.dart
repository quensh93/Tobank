import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/card_balance/card_balance_controller.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/common/menu_data_model.dart';
import '../common/custom_app_bar.dart';
import 'page/card_balance_info_page.dart';
import 'page/card_balance_result_page.dart';

class CardBalanceScreen extends StatelessWidget {
  const CardBalanceScreen({
    super.key,
    this.customerCard,
    this.bankInfo,
    this.menuItemData,
  });

  final CustomerCard? customerCard;
  final BankInfo? bankInfo;
  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardBalanceController>(
        init: CardBalanceController(customerCard: customerCard, bankInfo: bankInfo),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: menuItemData != null ? menuItemData!.title! : locale.receive_inventory,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        children: const <Widget>[
                          CardBalanceInfoPage(),
                          CardBalanceResultPage(),
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
