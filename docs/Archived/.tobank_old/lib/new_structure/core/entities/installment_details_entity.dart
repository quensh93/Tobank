// installment_entity.dart
import 'installment_payment_entity.dart';

class InstallmentDetailsEntity {
  final bool isAfterDelivery;
  final bool isOverUsance;
  final bool isDoubtful;
  final bool isPostPoned;
  final String amount;
  final String interest;
  final String penalty;
  final bool isPayed;
  final String paymentStatus;
  final String deliveryDate;
  final String installmentPenalty;
  final String installmentNumber;
  final String lifeInsurance;
  final String remainingAmount;
  final List<InstallmentPaymentEntity>? installmentPayments;

  InstallmentDetailsEntity({
    required this.isAfterDelivery,
    required this.isOverUsance,
    required this.isDoubtful,
    required this.isPostPoned,
    required this.amount,
    required this.interest,
    required this.penalty,
    required this.isPayed,
    required this.paymentStatus,
    required this.deliveryDate,
    required this.installmentPenalty,
    required this.installmentNumber,
    required this.lifeInsurance,
    required this.remainingAmount,
    this.installmentPayments,
  });

  factory InstallmentDetailsEntity.fromJson(Map<String, dynamic> json) {
    return InstallmentDetailsEntity(
      isAfterDelivery: json['isAfterDelivery'].toString().toLowerCase() == 'true',
      isOverUsance: json['isOverUsance'].toString().toLowerCase() == 'true',
      isDoubtful: json['isDoubtful'].toString().toLowerCase() == 'true',
      isPostPoned: json['isPostPoned'].toString().toLowerCase() == 'true',
      amount: json['amount'] as String,
      interest: json['interest'] as String,
      penalty: json['penalty'] as String,
      isPayed: json['isPayed'].toString().toLowerCase() == 'true',
      paymentStatus: json['paymentStatus'] as String,
      deliveryDate: json['deliveryDate'] as String,
      installmentPenalty: json['installmentPenalty'] as String,
      installmentNumber: json['installmentNumber'] as String,
      lifeInsurance: json['lifeInsurance'] as String,
      remainingAmount: json['remainingAmount'] as String,
      installmentPayments: json['installmentPayments'] != null
          ? (json['installmentPayments'] as List)
          .map((e) => InstallmentPaymentEntity.fromJson(e as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isAfterDelivery': isAfterDelivery.toString(),
      'isOverUsance': isOverUsance.toString(),
      'isDoubtful': isDoubtful.toString(),
      'isPostPoned': isPostPoned.toString(),
      'amount': amount,
      'interest': interest,
      'penalty': penalty,
      'isPayed': isPayed.toString(),
      'paymentStatus': paymentStatus,
      'deliveryDate': deliveryDate,
      'installmentPenalty': installmentPenalty,
      'installmentNumber': installmentNumber,
      'lifeInsurance': lifeInsurance,
      'remainingAmount': remainingAmount,
      'installmentPayments': installmentPayments?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return '🔵 InstallmentEntity(\n'
        'isAfterDelivery: $isAfterDelivery\n'
        'isOverUsance: $isOverUsance\n'
        'isDoubtful: $isDoubtful\n'
        'isPostPoned: $isPostPoned\n'
        'amount: $amount\n'
        'interest: $interest\n'
        'penalty: $penalty\n'
        'isPayed: $isPayed\n'
        'paymentStatus: $paymentStatus\n'
        'deliveryDate: $deliveryDate\n'
        'installmentPenalty: $installmentPenalty\n'
        'installmentNumber: $installmentNumber\n'
        'lifeInsurance: $lifeInsurance\n'
        'remainingAmount: $remainingAmount\n'
        'installmentPayments: $installmentPayments\n'
        ')';
  }
}