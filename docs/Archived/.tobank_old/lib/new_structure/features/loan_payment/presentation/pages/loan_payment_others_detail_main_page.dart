import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../ui/common/custom_app_bar.dart';
import '../../../../core/entities/loan_details_entity.dart';
import '../widgets/loan_payment_others/loan_payment_others_detail_main_page_scaffold_widget.dart';

class LoanPaymentOthersDetailMainPage extends StatelessWidget {
  final LoanDetailsEntity detailsData;
  final String nationalCode;

  const LoanPaymentOthersDetailMainPage({
    required this.detailsData,
    required this.nationalCode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          titleString: locale.pay_others_loan,
          context: context,
        ),
        body: SafeArea(
            child: LoanPaymentOthersDetailMainPageScaffoldWidget(
          detailsData: detailsData,
          nationalCode: nationalCode,
        )),
      ),
    );
  }
}
