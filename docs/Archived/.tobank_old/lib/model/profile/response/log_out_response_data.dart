// To parse this JSON data, do
//
//     final logOutResponse = logOutResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/error_response_data.dart';

LogOutResponse logOutResponseFromJson(String str) => LogOutResponse.fromJson(json.decode(str));

String logOutResponseToJson(LogOutResponse data) => json.encode(data.toJson());

class LogOutResponse {
  LogOutResponse({
    this.message,
    this.success,
  });

  String? message;
  bool? success;
  int? statusCode;
  ErrorResponseData? errorResponseData;

  factory LogOutResponse.fromJson(Map<String, dynamic> json) => LogOutResponse(
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'message': message,
        'success': success,
      };
}
