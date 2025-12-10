import 'dart:convert';

import '../../common/error_response_data.dart';

DeleteAccountOtpResponseData deleteAccountOtpResponseDataFromJson(String str) =>
    DeleteAccountOtpResponseData.fromJson(json.decode(str));

String deleteAccountOtpResponseDataToJson(DeleteAccountOtpResponseData data) => json.encode(data.toJson());

class DeleteAccountOtpResponseData {
  DeleteAccountOtpResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory DeleteAccountOtpResponseData.fromJson(Map<String, dynamic> json) => DeleteAccountOtpResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.ttl,
  });

  int? ttl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ttl: json['ttl'],
      );

  Map<String, dynamic> toJson() =>
      {
        'ttl': ttl,
      };
}
