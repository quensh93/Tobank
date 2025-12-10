// loan_details_entity.dart
import 'installment_details_entity.dart';

class LoanDetailsEntity {
  final String approvedAmount;
  final String fileNumber;
  final String title;
  final int installmentsPaidNumber;
  final String installmentsNumber;
  final String settlement;
  final String debt;
  final int payableAmount;
  final String grantDate;
  final String fileStatus;
  final List<InstallmentDetailsEntity> installments;

  LoanDetailsEntity(
      {required this.approvedAmount,
      required this.fileNumber,
      required this.title,
      required this.installmentsPaidNumber,
      required this.installmentsNumber,
      required this.settlement,
      required this.grantDate,
      required this.debt,
      required this.payableAmount,
      required this.installments,
      required this.fileStatus});

  factory LoanDetailsEntity.fromJson(Map<String, dynamic> json) {
    return LoanDetailsEntity(
        approvedAmount: json['approved_amount'] as String,
        fileNumber: json['file_number'] as String,
        grantDate: json['grant_date'] as String,
        title: json['title'] as String,
        installmentsPaidNumber: json['installments_paid_number'] as int,
        installmentsNumber: json['installments_number'] as String,
        settlement: json['settlement'] as String,
        debt: json['debt'] as String,
        payableAmount: json['payable_amount'] as int,
        installments: (json['installments'] as List)
            .map((e) => InstallmentDetailsEntity.fromJson(e as Map<String, dynamic>))
            .toList(),
        fileStatus: json['file_status'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'approved_amount': approvedAmount,
      'grant_date': grantDate,
      'file_number': fileNumber,
      'title': title,
      'installments_paid_number': installmentsPaidNumber,
      'installments_number': installmentsNumber,
      'settlement': settlement,
      'debt': debt,
      'payable_amount': payableAmount,
      'installments': installments.map((e) => e.toJson()).toList(),
      'file_status': fileStatus
    };
  }

  @override
  String toString() {
    return '🔵 LoanDetailsEntity(\n'
        'approvedAmount: $approvedAmount\n'
        'fileNumber: $fileNumber\n'
        'grantDate: $grantDate\n'
        'title: $title\n'
        'installmentsPaidNumber: $installmentsPaidNumber\n'
        'installmentsNumber: $installmentsNumber\n'
        'settlement: $settlement\n'
        'debt: $debt\n'
        'installments: $installments\n'
        'fileStatus: $fileStatus\n'
        ')';
  }
}
