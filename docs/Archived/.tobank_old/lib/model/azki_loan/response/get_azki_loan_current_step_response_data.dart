import 'dart:convert';

import '../../common/error_response_data.dart';

GetAzkiLoanCurrentStepResponse getAzkiLoanCurrentStepResponseFromJson(String str) =>
    GetAzkiLoanCurrentStepResponse.fromJson(json.decode(str));

String getAzkiLoanCurrentStepResponseToJson(GetAzkiLoanCurrentStepResponse data) => json.encode(data.toJson());

class GetAzkiLoanCurrentStepResponse {
  String? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  GetAzkiLoanCurrentStepResponse({
    this.data,
    this.success,
    this.message,
  });

  factory GetAzkiLoanCurrentStepResponse.fromJson(Map<String, dynamic> json) => GetAzkiLoanCurrentStepResponse(
        data: json['data'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data,
        'success': success,
        'message': message,
      };
}
