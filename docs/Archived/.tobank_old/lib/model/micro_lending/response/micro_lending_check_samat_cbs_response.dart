import '../loan_detail.dart';

class MicroLendingCheckSamatCBSResponse {
  MicroLendingCheckSamatCBSResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory MicroLendingCheckSamatCBSResponse.fromJson(Map<String, dynamic> json) => MicroLendingCheckSamatCBSResponse(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.loanDetail,
  });

  LoanDetail? loanDetail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        loanDetail: LoanDetail.fromJson(json['loan_detail']),
      );
}
