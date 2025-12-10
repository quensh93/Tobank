import 'dart:convert';

import '../../common/error_response_data.dart';

GetAzkiLoanDetailResponse getAzkiLoanDetailResponseFromJson(String str) =>
    GetAzkiLoanDetailResponse.fromJson(json.decode(str));

class GetAzkiLoanDetailResponse {
  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  GetAzkiLoanDetailResponse({
    this.data,
    this.success,
    this.message,
  });

  factory GetAzkiLoanDetailResponse.fromJson(Map<String, dynamic> json) => GetAzkiLoanDetailResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );
}

class Data {
  String? recipientNationalNumber;
  String? recipientCellPhone;
  String? recipientType;
  String? recipientFullName;
  int? percent;
  int? amount;
  dynamic dueDate;
  String? description;
  bool? transferable;
  AzkiLoan? azkiLoan;

  Data({
    this.recipientNationalNumber,
    this.recipientCellPhone,
    this.recipientType,
    this.recipientFullName,
    this.percent,
    this.amount,
    this.dueDate,
    this.description,
    this.transferable,
    this.azkiLoan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        recipientNationalNumber: json['recipient_national_number'],
        recipientCellPhone: json['recipient_cell_phone'],
        recipientType: json['recipient_type'],
        recipientFullName: json['recipient_full_name'],
        percent: json['percent'],
        amount: json['amount'],
        dueDate: json['due_date'],
        description: json['description'],
        transferable: json['transferable'],
        azkiLoan: json['azki_loan'] == null ? null : AzkiLoan.fromJson(json['azki_loan']),
      );
}

class AzkiLoan {
  AzkiLoan({
    this.id,
    this.amount,
    this.paybackPeriod,
    this.accountNumber,
  });

  int? id;
  int? amount;
  int? paybackPeriod;
  String? accountNumber;

  factory AzkiLoan.fromJson(Map<String, dynamic> json) => AzkiLoan(
        id: json['id'],
        amount: json['amount'],
        paybackPeriod: json['payback_period'],
        accountNumber: json['account_number'],
      );
}
