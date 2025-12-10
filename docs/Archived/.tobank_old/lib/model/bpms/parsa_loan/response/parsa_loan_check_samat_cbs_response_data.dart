import 'dart:convert';

import '../loan_detail.dart';

ParsaLoanCheckSamatCbsResponseData parsaLoanCheckSamatCbsResponseDataFromJson(String str) =>
    ParsaLoanCheckSamatCbsResponseData.fromJson(json.decode(str));

class ParsaLoanCheckSamatCbsResponseData {
  String? message;
  bool? success;
  Data? data;

  ParsaLoanCheckSamatCbsResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory ParsaLoanCheckSamatCbsResponseData.fromJson(Map<String, dynamic> json) => ParsaLoanCheckSamatCbsResponseData(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );
}

class Data {
  String? step;
  LoanDetail? loanDetail;
  String? orderId;
  int? cbsStatusCode;

  Data({
    this.step,
    this.loanDetail,
    this.orderId,
    this.cbsStatusCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        step: json['step'],
        loanDetail: json['loan_detail'] == null ? null : LoanDetail.fromJson(json['loan_detail']),
        orderId: json['order_id'],
        cbsStatusCode: json['cbs_status_code'],
      );
}
