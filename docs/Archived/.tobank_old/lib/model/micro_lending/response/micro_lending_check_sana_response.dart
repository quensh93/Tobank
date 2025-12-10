import '../loan_detail.dart';
import '../micro_lending_config.dart';

class MicroLendingCheckSanaResponse {
  MicroLendingCheckSanaResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory MicroLendingCheckSanaResponse.fromJson(Map<String, dynamic> json) => MicroLendingCheckSanaResponse(
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
  MicroLendingConfig? config;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        loanDetail: LoanDetail.fromJson(json['loan_detail']),
        config: MicroLendingConfig.fromJson(json['config']),
      );
}
