import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../ui/common/key_value_widget.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/persian_date.dart';
import '../../../../../../widget/ui/dotted_separator_widget.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/entities/receipt_data.dart';
import '../../../../../core/theme/main_theme.dart';

class LoanPaymentReceiptDetailWidget extends StatefulWidget {
  final ReceiptData receiptData;

  const LoanPaymentReceiptDetailWidget({
    required this.receiptData,
    super.key,
  });

  @override
  State<LoanPaymentReceiptDetailWidget> createState() => _LoanPaymentReceiptDetailWidgetState();
}

class _LoanPaymentReceiptDetailWidgetState extends State<LoanPaymentReceiptDetailWidget> {
  final PersianDate persianDate = PersianDate();

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      color: widget.receiptData.receiptType == ReceiptType.success
          ? MainTheme.of(context).surface
          : widget.receiptData.receiptType == ReceiptType.fail
              ? const Color(0x33F3BCC0)
              : const Color(0xFFFFF9EA),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            KeyValueWidget(
              keyString: locale.amount,
              valueString: locale.amount_format(AppUtil.formatMoney(widget.receiptData.amount.toString())),
            ),
            const DottedSeparatorWidget(),
            KeyValueWidget(
              keyString: locale.facility_number,
              valueString: widget.receiptData.paymentData.getInstallmentPaymentData().fileNumber,
            ),
            const DottedSeparatorWidget(),
            KeyValueWidget(
              keyString: locale.transaction_time,
              valueString: persianDate.parseToFormat(DateTime.now().toString(), 'd MM yyyy'),
            ),
            const DottedSeparatorWidget(),
            KeyValueWidget(
              keyString: locale.paid_via,
              valueString: widget.receiptData.destinationType == DestinationType.deposit ? locale.account : locale.wallet,
            ),
            const DottedSeparatorWidget(),
            KeyValueWidget(
              keyString: locale.origin,
              valueString: widget.receiptData.depositNumber,
            ),
            const DottedSeparatorWidget(),
            KeyValueWidget(
              keyString: locale.tracking_number,
              valueString: widget.receiptData.trackingNumber,
            ),
          ],
        ),
      ),
    );
  }
}
