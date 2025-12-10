import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/pichak/owner_credit_controller.dart';
import '../../common/custom_app_bar.dart';
import 'page/owner_credit_inquiry_cheque_info_page.dart';
import 'page/owner_credit_inquiry_result_page.dart';

class OwnerCreditInquiryScreen extends StatelessWidget {
  const OwnerCreditInquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<OwnerCreditController>(
          init: OwnerCreditController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString:locale.cheque_issuer_credit_inquiry,
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
                          OwnerCreditInquiryChequeInfoPage(),
                          OwnerCreditInquiryResultPage(),
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
