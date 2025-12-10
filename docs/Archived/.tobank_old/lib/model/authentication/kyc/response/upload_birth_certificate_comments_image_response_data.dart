import 'dart:convert';

import '../../../common/error_response_data.dart';

UploadBirthCertificateCommentsImageResponseData uploadBirthCertificateCommentsImageResponseDataFromJson(String str) =>
    UploadBirthCertificateCommentsImageResponseData.fromJson(json.decode(str));

String uploadBirthCertificateCommentsImageResponseDataToJson(UploadBirthCertificateCommentsImageResponseData data) =>
    json.encode(data.toJson());

class UploadBirthCertificateCommentsImageResponseData {
  UploadBirthCertificateCommentsImageResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory UploadBirthCertificateCommentsImageResponseData.fromJson(Map<String, dynamic> json) =>
      UploadBirthCertificateCommentsImageResponseData(
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
  });

  String? trackingNumber;
  int? registrationDate;
  int? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        registrationDate: json['registrationDate'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'registrationDate': registrationDate,
        'status': status,
      };
}
