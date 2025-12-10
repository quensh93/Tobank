// installment_list_data_entity.dart
class InstallmentListDataEntity {
  final String loan;
  final String firstUnpaidInstallmentNumber;
  final int unpaidInstallmentNumber;
  final String deliveryDate;
  final int nextPayDate;
  final String fileNumber;
  final int delayedInstallmentNumber;

  InstallmentListDataEntity({
    required this.loan,
    required this.firstUnpaidInstallmentNumber,
    required this.unpaidInstallmentNumber,
    required this.deliveryDate,
    required this.nextPayDate,
    required this.fileNumber,
    required this.delayedInstallmentNumber,
  });

  factory InstallmentListDataEntity.fromJson(Map<String, dynamic> json) {
    return InstallmentListDataEntity(
      loan: json['loan'] as String,
      firstUnpaidInstallmentNumber: json['first_unpaid_installment_number'] as String,
      unpaidInstallmentNumber: json['unpaid_installment_number'] as int,
      deliveryDate: json['delivery_date'] as String,
      nextPayDate: json['next_pay_date'] as int,
      fileNumber: json['file_number'] as String,
      delayedInstallmentNumber: json['delayed_installment_number'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loan': loan,
      'first_unpaid_installment_number': firstUnpaidInstallmentNumber,
      'unpaid_installment_number': unpaidInstallmentNumber,
      'delivery_date': deliveryDate,
      'next_pay_date': nextPayDate,
      'file_number': fileNumber,
      'delayed_installment_number': delayedInstallmentNumber,
    };
  }


  @override
  String toString() {
    return '🔵 InstallmentEntity(\n'
        'loan: $loan\n'
        'firstUnpaidInstallmentNumber: $firstUnpaidInstallmentNumber\n'
        'unpaidInstallmentNumber: $unpaidInstallmentNumber\n'
        'deliveryDate: $deliveryDate\n'
        'nextPayDate: $nextPayDate\n'
        'fileNumber: $fileNumber\n'
        'delayed_installment_number: $delayedInstallmentNumber\n'
        ')';
  }
}