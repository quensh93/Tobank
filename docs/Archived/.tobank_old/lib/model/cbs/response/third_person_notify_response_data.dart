import 'dart:convert';

import '../../common/error_response_data.dart';

ThirdPersonNotifyResponseData thirdPersonNotifyResponseDataFromJson(String str) =>
    ThirdPersonNotifyResponseData.fromJson(json.decode(str));

class ThirdPersonNotifyResponseData {
  ThirdPersonNotifyResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ThirdPersonNotifyResponseData.fromJson(Map<String, dynamic> json) => ThirdPersonNotifyResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );
}

class Data {
  Data({
    this.ttl,
  });

  int? ttl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ttl: json['TTl'],
      );
}
