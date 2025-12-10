import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/wallet/wallet_charge_controller.dart';
import '../../../model/transaction/response/transaction_data_response.dart';
import '../../../model/wallet/response/charge_wallet_response_data.dart';
import '../../common/custom_app_bar.dart';
import '../../common/pay_in_browser.dart';
import '../../common/transaction_detail_page.dart';

class WalletChargeScreen extends StatelessWidget {
  const WalletChargeScreen({
    required this.chargeWalletResponseData,
    required this.transactionDataResponse,
    required this.chargeAmount,
    super.key,
  });

  final ChargeWalletInternetResponseData? chargeWalletResponseData;
  final TransactionDataResponse? transactionDataResponse;
  final int chargeAmount;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<WalletChargeController>(
          init: WalletChargeController(
            chargeWalletResponseData: chargeWalletResponseData,
            transactionDataResponse: transactionDataResponse,
          ),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.wallet,
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
                            url: controller.chargeWalletResponseData?.data!.url!,
                            titleText: locale.charge_wallet,
                          ),
                          TransactionDetailPage(
                            transactionData: controller.transactionData,
                            screenName: 'WalletChargePage',
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
