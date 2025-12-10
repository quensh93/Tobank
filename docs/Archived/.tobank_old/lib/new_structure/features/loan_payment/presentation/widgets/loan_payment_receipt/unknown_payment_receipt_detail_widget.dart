import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/entities/enums.dart';
import '../../../../../core/entities/receipt_data.dart';
import '../../../../../core/theme/main_theme.dart';

class UnknownPaymentReceiptDetailWidget extends StatefulWidget {
  final ReceiptData receiptData;

  const UnknownPaymentReceiptDetailWidget({
    required this.receiptData,
    super.key,
  });

  @override
  State<UnknownPaymentReceiptDetailWidget> createState() => _UnknownPaymentReceiptDetailWidgetState();
}

class _UnknownPaymentReceiptDetailWidgetState extends State<UnknownPaymentReceiptDetailWidget> {
  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
        color:MainTheme.of(context).surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Text(
          (widget.receiptData.paymentData.paymentType == PaymentListType.othersLoan ||
                  widget.receiptData.paymentData.paymentType == PaymentListType.myselfLoan)
              ? locale.uncertain_loan_payment_status_message : widget.receiptData.paymentData.paymentType==PaymentListType.charge? locale.uncertain_charge_payment_status_message:locale.uncertain_package_payment_status_message,
          textAlign: TextAlign.center,
          style:  TextStyle(
            color: MainTheme.of(context).surfaceContainerHigh,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
