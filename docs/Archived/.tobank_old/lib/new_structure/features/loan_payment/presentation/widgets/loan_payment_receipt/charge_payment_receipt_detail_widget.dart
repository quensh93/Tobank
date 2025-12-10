import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../ui/common/key_value_widget.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/persian_date.dart';
import '../../../../../../widget/ui/dotted_separator_widget.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/entities/receipt_data.dart';
import '../../../../../core/theme/main_theme.dart';

class ChargePaymentReceiptDetailWidget extends StatefulWidget {
  final ReceiptData receiptData;

  const ChargePaymentReceiptDetailWidget({
    required this.receiptData,
    super.key,
  });

  @override
  State<ChargePaymentReceiptDetailWidget> createState() => _ChargePaymentReceiptDetailWidgetState();
}

class _ChargePaymentReceiptDetailWidgetState extends State<ChargePaymentReceiptDetailWidget> {
  final PersianDate persianDate = PersianDate();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            KeyValueWidget(
              keyString: locale.amount,
              valueString: locale.amount_format(AppUtil.formatMoney(widget.receiptData.amount.toString())),
            ),
            const DottedSeparatorWidget(),
            KeyValueWidget(
              keyString: locale.transaction_time,
              valueString: persianDate.parseToFormat(DateTime.now().toString(), 'd MM yyyy'),
            ),
            const DottedSeparatorWidget(),
            KeyValueWidget(
              keyString:
                  widget.receiptData.paymentData.getChargeAndPackagePaymentData().chargeAndPackageType ==
                          ChargeAndPackageType.CHARGE
                      ? locale.buy_charge
                      : locale.buy_internet_package_,
              valueString: widget.receiptData.paymentData.getChargeAndPackagePaymentData().mobile,
            ),
            const DottedSeparatorWidget(),
            KeyValueWidget(
              keyString: locale.paid_via,
              valueString: widget.receiptData.destinationType == DestinationType.deposit ? locale.account : locale.wallet,
            ),
            if (widget.receiptData.depositNumber != '')
            const DottedSeparatorWidget(),
            if (widget.receiptData.depositNumber != '')
              KeyValueWidget(
                keyString: locale.origin,
                valueString: widget.receiptData.depositNumber,
              ),
            if (widget.receiptData.trackingNumber != '') const DottedSeparatorWidget(),
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
