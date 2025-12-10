import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/azki_loan/azki_loan_controller.dart';
import '../common/custom_app_bar.dart';
import 'page/azki_loan_info_page.dart';
import 'page/azki_loan_promissory_page.dart';
import 'page/azki_loan_result_page.dart';
import 'page/azki_loan_sign_contract_page.dart';
import 'page/azki_loan_summery_page.dart';

class AzkiLoanScreen extends StatelessWidget {
  const AzkiLoanScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<AzkiLoanController>(
        init: AzkiLoanController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.receive_loan,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          AzkiLoanInfoPage(),
                          AzkiLoanSummeryPage(),
                          AzkiLoanPromissoryPage(),
                          AzkiLoanSignContractPage(),
                          AzkiLoanResultPage(),
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
