import 'dart:convert';

import '../../common/error_response_data.dart';

SubmitAzkiLoanContractResponseModel submitAzkiLoanContractResponseModelFromJson(String str) =>
    SubmitAzkiLoanContractResponseModel.fromJson(json.decode(str));

class SubmitAzkiLoanContractResponseModel {
  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  SubmitAzkiLoanContractResponseModel({
    this.data,
    this.success,
    this.message,
  });

  factory SubmitAzkiLoanContractResponseModel.fromJson(Map<String, dynamic> json) =>
      SubmitAzkiLoanContractResponseModel(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );
}

class Data {
  Loan? loan;

  Data({
    this.loan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        loan: json['loan'] == null ? null : Loan.fromJson(json['loan']),
      );
}

class Loan {
  Loan({
    this.contract,
  });

  String? contract;

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        contract: json['contract'],
      );
}
