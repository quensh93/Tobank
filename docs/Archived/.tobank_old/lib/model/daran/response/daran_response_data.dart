import 'dart:convert';

import '../../common/error_response_data.dart';

DaranResponseData daranResponseDataFromJson(String str) => DaranResponseData.fromJson(json.decode(str));

String daranResponseDataToJson(DaranResponseData data) => json.encode(data.toJson());

class DaranResponseData {
  DaranResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory DaranResponseData.fromJson(Map<String, dynamic> json) => DaranResponseData(
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
    this.result,
    this.status,
    this.message,
  });

  String? result;
  int? status;
  String? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json['result'],
        status: json['status'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() =>
      {
        'result': result,
        'status': status,
        'message': message,
      };
}
