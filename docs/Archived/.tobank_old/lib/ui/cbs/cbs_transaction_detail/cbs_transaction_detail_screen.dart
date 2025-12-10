import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/cbs/cbs_transaction_detail/cbs_transaction_detail_controller.dart';
import '../../../../model/transaction/response/transaction_data.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'view/cbs_transaction_detail_page.dart';

class CBSTransactionDetailScreen extends StatelessWidget {
  const CBSTransactionDetailScreen({
    required this.transactionData,
    required this.displayDescription,
    super.key,
  });

  final TransactionData transactionData;
  final bool displayDescription;

  @override
  Widget build(BuildContext context) {//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CBSTransactionDetailController>(
          init: CBSTransactionDetailController(
            transactionData: transactionData,
          ),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.credit_check,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          VirtualBranchLoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.fetchPdfDocumentRequest();
                            },
                          ),
                          CBSTransactionDetailPage(
                            transactionData: controller.transactionData,
                            displayDescription: displayDescription,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
