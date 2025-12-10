import 'dart:convert';

import '../../common/error_response_data.dart';

DestUserInfoResponse destUserInfoResponseFromJson(String str) => DestUserInfoResponse.fromJson(json.decode(str));

String destUserInfoResponseToJson(DestUserInfoResponse data) => json.encode(data.toJson());

class DestUserInfoResponse {
  DestUserInfoResponse({
    this.data,
    this.message,
    this.success,
  });

  DestUserInfoData? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory DestUserInfoResponse.fromJson(Map<String, dynamic> json) => DestUserInfoResponse(
        data: json['data'] == null ? null : DestUserInfoData.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class DestUserInfoData {
  DestUserInfoData({
    this.firstName,
    this.lastName,
  });

  String? firstName;
  String? lastName;

  factory DestUserInfoData.fromJson(Map<String, dynamic> json) => DestUserInfoData(
        firstName: json['first_name'],
        lastName: json['last_name'],
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
      };
}
