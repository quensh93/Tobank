import 'payment_data.dart';

class ChargeDepositData {
  final int amount;
  final String depositNumber;
  final int shouldPayAmount;
  final PaymentData paymentData;
  const ChargeDepositData({
    required this.amount,
    required this.depositNumber,
    required this.shouldPayAmount,
    required this.paymentData,
  });
}


