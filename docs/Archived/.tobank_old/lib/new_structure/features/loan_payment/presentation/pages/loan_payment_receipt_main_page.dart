import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../ui/common/custom_app_bar.dart';
import '../../../../core/entities/enums.dart';
import '../../../../core/entities/receipt_data.dart';
import '../widgets/loan_payment_receipt/loan_payment_receipt_main_page_scaffold_widget.dart';

class LoanPaymentReceiptMainPage extends StatelessWidget {
  final ReceiptData receiptData;

  const LoanPaymentReceiptMainPage({
    required this.receiptData,
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
          titleString: (receiptData.paymentData.paymentType == PaymentListType.othersLoan ||
                  receiptData.paymentData.paymentType == PaymentListType.myselfLoan)
              ? locale.pay_loans
              : receiptData.paymentData.getChargeAndPackagePaymentData().chargeAndPackageType == ChargeAndPackageType.INTERNET
                  ? locale.internet
                  : locale.charge,
          context: context,
        ),
        body: SafeArea(
            child: LoanPaymentReceiptMainPageScaffoldWidget(
              receiptData: receiptData,
          // receiptType: receiptType,
          // destinationType: destinationType,
          // chargeAndPackageResponseData: chargeAndPackageResponseData,
          // installmentResponseData: installmentResponseData,
        )),
      ),
    );
  }
}
