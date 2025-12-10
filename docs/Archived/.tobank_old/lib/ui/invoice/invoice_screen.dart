import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/invoice/invoice_controller.dart';
import '../../model/common/menu_data_model.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import '../common/pay_in_browser.dart';
import '../common/transaction_detail_page.dart';
import 'page/list_bill_page.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({
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
      child: GetBuilder<InvoiceController>(
          init: InvoiceController(),
          builder: (controller) {
            return PopScope(
              canPop: false,
              onPopInvoked: controller.onBackPress,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: menuItemData != null ? menuItemData!.title! : locale.pay_bill_,
                  context: context,
                ),
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.pageController,
                          children: [
                            LoadingPage(
                              controller.errorTitle,
                              hasError: controller.hasError,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              isLoading: controller.isListLoading,
                              retryFunction: () {
                                controller.billDataListRequest();
                              },
                            ),
                            const ListBillPage(),
                            PayInBrowserWidget(
                              isLoading: controller.isLoading,
                              returnDataFunction: () {
                                controller.validateInternetPayment();
                              },
                              amount: controller.getCorrectAmount(),
                              url: controller.payBillData != null ? controller.payBillData!.data!.url : '',
                              titleText: locale.pay_bill_,
                            ),
                            TransactionDetailPage(
                              transactionData: controller.transactionData,
                              screenName: 'InvoicePaymentScreen',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
