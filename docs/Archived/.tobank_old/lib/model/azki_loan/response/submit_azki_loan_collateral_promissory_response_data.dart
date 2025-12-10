import 'dart:convert';

import '../../common/error_response_data.dart';

SubmitAzkiLoanCollateralPromissoryResponse submitAzkiLoanCollateralPromissoryResponseFromJson(String str) =>
    SubmitAzkiLoanCollateralPromissoryResponse.fromJson(json.decode(str));

String submitAzkiLoanCollateralPromissoryResponseToJson(SubmitAzkiLoanCollateralPromissoryResponse data) =>
    json.encode(data.toJson());

class SubmitAzkiLoanCollateralPromissoryResponse {
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  SubmitAzkiLoanCollateralPromissoryResponse({
    this.success,
    this.message,
  });

  factory SubmitAzkiLoanCollateralPromissoryResponse.fromJson(Map<String, dynamic> json) =>
      SubmitAzkiLoanCollateralPromissoryResponse(
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
