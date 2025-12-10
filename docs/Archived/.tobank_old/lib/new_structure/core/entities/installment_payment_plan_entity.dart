// deposit_data_entity.dart
import 'enums.dart';

class InstallmentPaymentPlanEntity {
  final int amount;
  final String depositNumber;
  final String fileNumber;
  final bool transactionSuccess;
  bool? isSettlement;
  final int referenceNumber;
  ChargeAndPackageType? chargeAndPackageType;

  InstallmentPaymentPlanEntity({
    required this.amount,
    required this.depositNumber,
    required this.fileNumber,
    required this.referenceNumber,
    required this.transactionSuccess,
    this.isSettlement,
    this.chargeAndPackageType,
  });

  factory InstallmentPaymentPlanEntity.fromJson(Map<String, dynamic> json) {
    return InstallmentPaymentPlanEntity(
      amount: json['amount'] as int,
      depositNumber: json['deposit_number'] as String,
      fileNumber: json['file_number'] as String,
      referenceNumber: json['reference_number'] as int,
      transactionSuccess: json['transaction_success'] as bool,
      isSettlement: json['is_settlement']!=null? json['is_settlement'] as bool: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'deposit_number': depositNumber,
      'file_number': fileNumber,
      'reference_number': referenceNumber,
    };
  }

  @override
  String toString() {
    return '🔵 InstallmentPaymentPlanEntity(\n'
        'amount: $amount\n'
        'depositNumber: $depositNumber\n'
        'fileNumber: $fileNumber\n'
        'referenceNumber: $referenceNumber\n'
        ')';
  }
}