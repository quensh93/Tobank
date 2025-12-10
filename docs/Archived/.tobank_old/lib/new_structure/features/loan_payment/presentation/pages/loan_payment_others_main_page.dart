import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../ui/common/custom_app_bar.dart';
import '../widgets/loan_payment_others/loan_payment_others_main_page_scaffold_widget.dart';

class LoanPaymentOthersMainPage extends StatelessWidget {

  const LoanPaymentOthersMainPage({super.key,});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        //backgroundColor:Color(0xFF1D2449),
        appBar: CustomAppBar(
          titleString: locale.pay_others_loan,
          context: context,
        ),
        body: const SafeArea(child: LoanPaymentOthersMainPageScaffoldWidget()),
      ),
    );
  }
}
