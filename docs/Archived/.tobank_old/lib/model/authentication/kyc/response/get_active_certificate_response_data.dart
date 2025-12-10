import 'dart:convert';

import '../../../common/error_response_data.dart';

GetActiveCertificateResponseData getActiveCertificateResponseDataFromJson(String str) =>
    GetActiveCertificateResponseData.fromJson(json.decode(str));

String getActiveCertificateResponseDataToJson(GetActiveCertificateResponseData data) => json.encode(data.toJson());

class GetActiveCertificateResponseData {
  GetActiveCertificateResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory GetActiveCertificateResponseData.fromJson(Map<String, dynamic> json) => GetActiveCertificateResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
      };
}

class Data {
  Data({
    this.trackingNumber,
    this.registrationDate,
    this.status,
    this.token,
    this.provider,
  });

  String? trackingNumber;
  int? registrationDate;
  int? status;
  String? token;
  int? provider;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        token: json['token'],
        provider: json['provider'],
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'registrationDate': registrationDate,
        'status': status,
        'token': token,
        'provider': provider,
      };
}
