import '../loan_detail.dart';
import '../parsa_lending_config.dart';

class ParsaLendingGetLoanDetailResponseData {
  ParsaLendingGetLoanDetailResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory ParsaLendingGetLoanDetailResponseData.fromJson(Map<String, dynamic> json) =>
      ParsaLendingGetLoanDetailResponseData(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.loanDetail,
    this.config,
  });

  LoanDetail? loanDetail;
  ParsaLendingConfig? config;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        loanDetail: LoanDetail.fromJson(json['loan_detail']),
        config: json['config'] != null ? ParsaLendingConfig.fromJson(json['config']) : null,
      );
}
