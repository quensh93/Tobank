import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/pichak/transfer_status_controller.dart';
import '../../common/custom_app_bar.dart';
import 'view/transfer_status_inquiry_cheque_info_page.dart';
import 'view/transfer_status_inquiry_result_page.dart';

class TransferStatusInquiryScreen extends StatelessWidget {
  const TransferStatusInquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<TransferStatusController>(
          init: TransferStatusController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.cheque_status_inquiry_title,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        children: const [
                          TransferStatusInquiryChequeInfoPage(),
                          TransferStatusInquiryResultPage(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
