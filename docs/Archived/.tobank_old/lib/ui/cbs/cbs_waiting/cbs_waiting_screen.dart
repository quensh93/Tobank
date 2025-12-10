import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/cbs/cbs_waiting/cbs_waiting_controller.dart';
import '../../../../model/transaction/response/transaction_data.dart';
import '../../common/custom_app_bar.dart';
import 'page/cbs_loading_page.dart';

class CBSWaitingScreen extends StatelessWidget {
  const CBSWaitingScreen({
    required this.transactionData,
    super.key,
  });

  final TransactionData transactionData;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CBSWaitingController>(
          init: CBSWaitingController(transactionData: transactionData),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.credit_check,
                context: context,
              ),
              body: const SafeArea(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: CBSLoadingPage(),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
