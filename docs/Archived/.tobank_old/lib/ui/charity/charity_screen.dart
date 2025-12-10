import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/charity/charity_controller.dart';
import '../../model/common/menu_data_model.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import '../common/pay_in_browser.dart';
import '../common/transaction_detail_page.dart';
import 'page/charity_selector_page.dart';

class CharityScreen extends StatelessWidget {
  const CharityScreen({
    super.key,
    this.menuItemData,
  });

  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CharityController>(
        init: CharityController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: menuItemData != null ? menuItemData!.title! : locale.niko_kari,
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
                              controller.getCharityListRequest();
                            },
                          ),
                          const CharitySelectorPage(),
                          PayInBrowserWidget(
                            isLoading: controller.isLoading,
                            returnDataFunction: () {
                              controller.validateInternetPayment();
                            },
                            amount: controller.getCorrectAmount(),
                            url: controller.charityInternetResponseData != null
                                ? controller.charityInternetResponseData!.data!.url
                                : '',
                            titleText: locale.niko_kari,
                          ),
                          TransactionDetailPage(
                            transactionData: controller.transactionData,
                            screenName: 'CharityScreen',
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
      ),
    );
  }
}
