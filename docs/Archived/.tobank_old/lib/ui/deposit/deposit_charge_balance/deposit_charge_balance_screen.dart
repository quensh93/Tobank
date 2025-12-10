import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/deposit/transfer/charge_deposit_balance_controller.dart';
import '../../../model/deposit/response/increase_deposit_balance_response_data.dart';
import '../../common/custom_app_bar.dart';
import '../../common/pay_in_browser.dart';
import '../../common/transaction_detail_page.dart';

class DepositChargeBalanceScreen extends StatelessWidget {
  const DepositChargeBalanceScreen({
    required this.increaseDepositBalanceResponseData,
    required this.chargeAmount,
    super.key,
  });
  final IncreaseDepositBalanceResponseData increaseDepositBalanceResponseData;
  final int chargeAmount;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<DepositChargeBalanceController>(
          init: DepositChargeBalanceController(
            increaseDepositBalanceResponseData: increaseDepositBalanceResponseData,
          ),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.deposit_money,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        children: <Widget>[
                          PayInBrowserWidget(
                            isLoading: controller.isLoading,
                            returnDataFunction: () {
                              controller.checkPayment();
                            },
                            amount: chargeAmount,
                            url: increaseDepositBalanceResponseData.data!.url!,
                            titleText:  locale.deposit_money,
                          ),
                          TransactionDetailPage(
                            transactionData: controller.transactionData,
                            screenName: 'DepositChargeBalancePage',
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
