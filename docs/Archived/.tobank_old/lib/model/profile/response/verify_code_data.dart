import 'dart:convert';

import '../../common/error_response_data.dart';

VerifyCodeData verifyCodeDataFromJson(String str) =>
    VerifyCodeData.fromJson(json.decode(str));

String verifyCodeDataToJson(VerifyCodeData data) => json.encode(data.toJson());

class VerifyCodeData {
  VerifyCodeData({
    this.data,
    this.message,
    this.success,
  });

  Map<String, dynamic>? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory VerifyCodeData.fromJson(Map<String, dynamic> json) => VerifyCodeData(
        data: json['data'],
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data,
        'message': message,
        'success': success,
      };
}
