// installment_payment_entity.dart
class InstallmentPaymentEntity {
  final String amount;
  final String interest;
  final String penalty;
  final String date;
  final String paymentForType;
  final String transactionCode;

  InstallmentPaymentEntity({
    required this.amount,
    required this.interest,
    required this.penalty,
    required this.date,
    required this.paymentForType,
    required this.transactionCode,
  });

  factory InstallmentPaymentEntity.fromJson(Map<String, dynamic> json) {
    return InstallmentPaymentEntity(
      amount: json['amount'] as String,
      interest: json['interest'] as String,
      penalty: json['penalty'] as String,
      date: json['date'] as String,
      paymentForType: json['paymentForType'] as String,
      transactionCode: json['transactionCode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'interest': interest,
      'penalty': penalty,
      'date': date,
      'paymentForType': paymentForType,
      'transactionCode': transactionCode,
    };
  }

  @override
  String toString() {
    return '🔵 InstallmentPaymentEntity(\n'
        'amount: $amount\n'
        'interest: $interest\n'
        'penalty: $penalty\n'
        'date: $date\n'
        'paymentForType: $paymentForType\n'
        'transactionCode: $transactionCode\n'
        ')';
  }
}