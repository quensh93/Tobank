import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../ui/common/custom_app_bar.dart';
import '../widgets/loan_payment_list/loan_payment_list_main_page_scaffold_widget.dart';

class LoanPaymentListMainPage extends StatelessWidget {

  const LoanPaymentListMainPage({super.key,});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          titleString: locale.pay_your_own_loan,
          context: context,
        ),
        body: const SafeArea(child: LoanPaymentListMainPageScaffoldWidget()),
      ),
    );
  }
}
