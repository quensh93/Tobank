import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/internet_plan/internet_plan_controller.dart';
import '../../model/common/menu_data_model.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import '../common/pay_in_browser.dart';
import '../common/transaction_detail_page.dart';
import 'page/internet_plan_page.dart';
import 'page/internet_selector_page.dart';

class InternetScreen extends StatelessWidget {
  const InternetScreen({super.key, this.menuItemData});

  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<InternetPlanController>(
        init: InternetPlanController(),
        builder: (controller) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: PopScope(
              canPop: false,
              onPopInvoked: controller.onBackPress,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: menuItemData != null ? menuItemData!.title! : locale.internet_package_name,
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
                                controller.getInternetStaticDataRequest();
                              },
                            ),
                            const InternetSelectorPage(),
                            const InternetPlanPage(),
                            PayInBrowserWidget(
                              isLoading: controller.isLoading,
                              returnDataFunction: () {
                                controller.validateInternetPayment();
                              },
                              amount: controller.getCorrectAmount(),
                              url: controller.internetPlanPayInternetResponseData != null
                                  ? controller.internetPlanPayInternetResponseData!.data!.url
                                  : '',
                              titleText: locale.internet_package,
                            ),
                            TransactionDetailPage(
                              transactionData: controller.transactionData,
                              screenName: 'InternetScreen',
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
        });
  }
}
