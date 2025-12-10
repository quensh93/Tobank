import 'dart:convert';

import '../../common/error_response_data.dart';

CheckSanaResponseData checkSanaResponseDataFromJson(String str) => CheckSanaResponseData.fromJson(json.decode(str));

String checkSanaResponseDataToJson(CheckSanaResponseData? data) => json.encode(data!.toJson());

class CheckSanaResponseData {
  CheckSanaResponseData({
    this.message,
    this.success,
  });

  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory CheckSanaResponseData.fromJson(Map<String, dynamic> json) => CheckSanaResponseData(
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
      };
}
