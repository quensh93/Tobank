import '../loan_detail.dart';

class ParsaLoanSubmitContractResponseData {
  Data? data;
  bool? success;
  String? message;

  ParsaLoanSubmitContractResponseData({
    this.data,
    this.success,
    this.message,
  });

  factory ParsaLoanSubmitContractResponseData.fromJson(Map<String, dynamic> json) =>
      ParsaLoanSubmitContractResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );
}

class Data {
  LoanDetail? loanDetail;

  Data({
    this.loanDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        loanDetail: json['loan_detail'] == null ? null : LoanDetail.fromJson(json['loan_detail']),
      );
}
