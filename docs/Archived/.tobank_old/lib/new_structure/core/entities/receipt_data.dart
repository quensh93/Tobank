import 'enums.dart';
import 'payment_data.dart';

class ReceiptData {
  final ReceiptType receiptType;
  final DestinationType destinationType;
  final PaymentData paymentData;
  final String depositNumber;
  final String trackingNumber;
  final int amount;
  final bool? isSettlement;
  const ReceiptData({
    required this.receiptType,
    required this.destinationType,
    required this.paymentData,
    required this.depositNumber,
    required this.trackingNumber,
    required this.amount,
    this.isSettlement,
  });
}


