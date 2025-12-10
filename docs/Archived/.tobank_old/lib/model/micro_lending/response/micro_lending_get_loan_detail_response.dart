import '../loan_detail.dart';
import '../micro_lending_config.dart';

class MicroLendingGetLoanDetailResponse {
  MicroLendingGetLoanDetailResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory MicroLendingGetLoanDetailResponse.fromJson(Map<String, dynamic> json) => MicroLendingGetLoanDetailResponse(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.step,
    this.loanDetail,
    this.config,
  });

  String? step;
  LoanDetail? loanDetail;
  MicroLendingConfig? config;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        step: json['step'],
        loanDetail: LoanDetail.fromJson(json['loan_detail']),
        config: MicroLendingConfig.fromJson(json['config']),
      );
}
