import 'dart:convert';

import '../../../common/error_response_data.dart';

IssueCertificateResponseData issueCertificateResponseDataFromJson(String str) =>
    IssueCertificateResponseData.fromJson(json.decode(str));

String issueCertificateResponseDataToJson(IssueCertificateResponseData data) => json.encode(data.toJson());

class IssueCertificateResponseData {
  IssueCertificateResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory IssueCertificateResponseData.fromJson(Map<String, dynamic> json) => IssueCertificateResponseData(
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

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'registrationDate': registrationDate,
        'status': status,
        'certificate': certificate,
      };
}
