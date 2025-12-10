import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/pichak/check_transfer_controller.dart';
import '../../common/custom_app_bar.dart';
import 'page/check_transfer_cheque_info_page.dart';
import 'page/check_transfer_confirm_page.dart';
import 'page/check_transfer_receiver_page.dart';
import 'page/check_transfer_result_page.dart';

class CheckTransferScreen extends StatelessWidget {
  final bool transferReversal;
  const CheckTransferScreen({required this.transferReversal, super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<CheckTransferController>(
          init: CheckTransferController(),
          builder: (controller) {
            return PopScope(
              canPop: false,
              onPopInvoked: controller.onBackPress,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: transferReversal ? locale.cheque_transfer_reversal : locale.cheque_transfer,
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
                            const CheckTransferChequeInfoPage(),
                            CheckTransferReceiverPage(transferReversal: transferReversal),
                            CheckTransferConfirmPage(transferReversal: transferReversal),
                            CheckTransferResultPage(transferReversal: transferReversal),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
