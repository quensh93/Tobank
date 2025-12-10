import 'dart:convert';

import '../../common/error_response_data.dart';

RenewCertificateResponseData renewCertificateResponseDataFromJson(String str) =>
    RenewCertificateResponseData.fromJson(json.decode(str));

String renewCertificateResponseDataToJson(RenewCertificateResponseData data) => json.encode(data.toJson());

class RenewCertificateResponseData {
  RenewCertificateResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory RenewCertificateResponseData.fromJson(Map<String, dynamic> json) => RenewCertificateResponseData(
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
    this.certificate,
  });

  String? trackingNumber;
  int? registrationDate;
  int? status;
  String? certificate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        certificate: json['certificate'],
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'registrationDate': registrationDate,
        'status': status,
        'certificate': certificate,
      };
}
