import 'dart:convert';

ParsaLoanGetPromissoryResponseData parsaLoanGetPromissoryResponseDataFromJson(String str) =>
    ParsaLoanGetPromissoryResponseData.fromJson(json.decode(str));

String parsaLoanGetPromissoryResponseDataToJson(ParsaLoanGetPromissoryResponseData data) => json.encode(data.toJson());

class ParsaLoanGetPromissoryResponseData {
  PromissoryData? data;
  bool? success;
  String? message;

  ParsaLoanGetPromissoryResponseData({
    this.data,
    this.success,
    this.message,
  });

  factory ParsaLoanGetPromissoryResponseData.fromJson(Map<String, dynamic> json) => ParsaLoanGetPromissoryResponseData(
        data: json['data'] == null ? null : PromissoryData.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
      };
}

class PromissoryData {
  String? recipientNationalNumber;
  String? recipientCellPhone;
  String? recipientType;
  int? percent;
  String? recipientFullName;
  int? amount;
  dynamic dueDate;
  String? description;
  bool? transferable;
  LoanDetailPromissory? loanDetail;
  int? userLoanId;

  PromissoryData({
    this.recipientNationalNumber,
    this.recipientCellPhone,
    this.recipientType,
    this.percent,
    this.recipientFullName,
    this.amount,
    this.dueDate,
    this.description,
    this.transferable,
    this.loanDetail,
    this.userLoanId,
  });

  factory PromissoryData.fromJson(Map<String, dynamic> json) => PromissoryData(
        recipientNationalNumber: json['recipient_national_number'],
        recipientCellPhone: json['recipient_cell_phone'],
        recipientType: json['recipient_type'],
        percent: json['percent'],
        recipientFullName: json['recipient_full_name'],
        amount: json['amount'],
        dueDate: json['due_date'],
        description: json['description'],
        transferable: json['transferable'],
        loanDetail: json['loan_detail'] == null ? null : LoanDetailPromissory.fromJson(json['loan_detail']),
        userLoanId: json['user_loan_id'],
      );

  Map<String, dynamic> toJson() => {
        'recipient_national_number': recipientNationalNumber,
        'recipient_cell_phone': recipientCellPhone,
        'recipient_type': recipientType,
        'percent': percent,
        'recipient_full_name': recipientFullName,
        'amount': amount,
        'due_date': dueDate,
        'description': description,
        'transferable': transferable,
        'loan_detail': loanDetail?.toJson(),
        'user_loan_id': userLoanId,
      };
}

class LoanDetailPromissory {
  int? id;
  String? loanType;
  String? step;
  dynamic requestedPrice;
  DateTime? expiredAt;
  String? deposit;
  dynamic months;
  bool? isActive;

  LoanDetailPromissory({
    this.id,
    this.loanType,
    this.step,
    this.requestedPrice,
    this.expiredAt,
    this.deposit,
    this.months,
    this.isActive,
  });

  factory LoanDetailPromissory.fromJson(Map<String, dynamic> json) => LoanDetailPromissory(
        id: json['id'],
        loanType: json['loan_type'],
        step: json['step'],
        requestedPrice: json['requested_price'],
        expiredAt: json['expired_at'] == null ? null : DateTime.parse(json['expired_at']),
        deposit: json['deposit'],
        months: json['months'],
        isActive: json['is_active'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'loan_type': loanType,
        'step': step,
        'requested_price': requestedPrice,
        'expired_at': expiredAt?.toIso8601String(),
        'deposit': deposit,
        'months': months,
        'is_active': isActive,
      };
}
