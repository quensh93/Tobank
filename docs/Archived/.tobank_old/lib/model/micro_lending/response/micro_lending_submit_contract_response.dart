import '../loan_detail.dart';

class MicroLendingSubmitContractResponse {
  MicroLendingSubmitContractResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory MicroLendingSubmitContractResponse.fromJson(Map<String, dynamic> json) => MicroLendingSubmitContractResponse(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.loanDetail,
    this.multiSignedContract,
  });

  LoanDetail? loanDetail;
  String? multiSignedContract;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        loanDetail: LoanDetail.fromJson(json['loan_detail']),
        multiSignedContract: json['multi_signed_contract'],
      );
}
