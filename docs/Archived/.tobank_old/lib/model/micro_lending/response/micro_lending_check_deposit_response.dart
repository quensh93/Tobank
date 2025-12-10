import '../loan_detail.dart';

class MicroLendingCheckDepositResponse {
  MicroLendingCheckDepositResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory MicroLendingCheckDepositResponse.fromJson(Map<String, dynamic> json) => MicroLendingCheckDepositResponse(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.step,
    this.loanDetail,
  });

  String? step;
  LoanDetail? loanDetail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        step: json['step'],
        loanDetail: LoanDetail.fromJson(json['loan_detail']),
      );
}
