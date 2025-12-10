import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/sim_charge/sim_charge_controller.dart';
import '../../model/common/menu_data_model.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import '../common/pay_in_browser.dart';
import '../common/transaction_detail_page.dart';
import 'page/sim_charge_selector_page.dart';

class SimChargeScreen extends StatelessWidget {
  const SimChargeScreen({super.key, this.menuItemData});

  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<SimChargeController>(
      init: SimChargeController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: menuItemData != null ? menuItemData!.title! : locale.sim_card_recharge,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        children: <Widget>[
                          LoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.getChargeStaticDataRequest();
                            },
                          ),
                          const SimChargeSelectorPage(),
                          PayInBrowserWidget(
                            isLoading: controller.isLoading,
                            returnDataFunction: () {
                              controller.validateInternetPayment();
                            },
                            amount: controller.getCorrectAmount(),
                            url: controller.chargeInternetResponseData != null
                                ? controller.chargeInternetResponseData!.data!.url
                                : '',
                            titleText: locale.sim_card_recharge,
                          ),
                          TransactionDetailPage(
                            transactionData: controller.transactionData,
                            screenName: 'SimChargeScreen',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
