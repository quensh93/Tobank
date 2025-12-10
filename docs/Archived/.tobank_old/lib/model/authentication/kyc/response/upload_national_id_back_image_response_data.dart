import 'dart:convert';

import '../../../common/error_response_data.dart';

UploadNationalIdBackImageResponseData uploadNationalIdBackImageResponseDataFromJson(String str) =>
    UploadNationalIdBackImageResponseData.fromJson(json.decode(str));

String uploadNationalIdBackImageResponseDataToJson(UploadNationalIdBackImageResponseData data) =>
    json.encode(data.toJson());

class UploadNationalIdBackImageResponseData {
  UploadNationalIdBackImageResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory UploadNationalIdBackImageResponseData.fromJson(Map<String, dynamic> json) =>
      UploadNationalIdBackImageResponseData(
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
    this.nationalIdSerial,
    this.trackingNumber,
    this.registrationDate,
    this.status,
    this.nationalCode,
  });

  String? nationalIdSerial;
  String? trackingNumber;
  int? registrationDate;
  int? status;
  String? nationalCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nationalIdSerial: json['nationalIdSerial'],
        trackingNumber: json['trackingNumber'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        nationalCode: json['nationalCode'],
      );

  Map<String, dynamic> toJson() =>
      {
        'nationalIdSerial': nationalIdSerial,
        'trackingNumber': trackingNumber,
        'registrationDate': registrationDate,
        'status': status,
        'nationalCode': nationalCode,
      };
}
