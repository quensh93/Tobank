import 'dart:convert';

import '../../../common/error_response_data.dart';

UploadNationalIdFrontImageResponseData uploadNationalIdFrontImageResponseDataFromJson(String str) =>
    UploadNationalIdFrontImageResponseData.fromJson(json.decode(str));

String uploadNationalIdFrontImageResponseDataToJson(UploadNationalIdFrontImageResponseData data) =>
    json.encode(data.toJson());

class UploadNationalIdFrontImageResponseData {
  UploadNationalIdFrontImageResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory UploadNationalIdFrontImageResponseData.fromJson(Map<String, dynamic> json) =>
      UploadNationalIdFrontImageResponseData(
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
    this.birthDate,
    this.city,
    this.expirationDate,
    this.facePhoto,
    this.fatherName,
    this.firstName,
    this.lastName,
    this.nationalCode,
    this.province,
    this.registrationDate,
    this.status,
    this.trackingNumber,
  });

  String? birthDate;
  String? city;
  String? expirationDate;
  String? facePhoto;
  String? fatherName;
  String? firstName;
  String? lastName;
  String? nationalCode;
  String? province;
  int? registrationDate;
  int? status;
  String? trackingNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        birthDate: json['birthDate'],
        city: json['city'],
        expirationDate: json['expirationDate'],
        facePhoto: json['facePhoto'],
        fatherName: json['fatherName'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        nationalCode: json['nationalCode'],
        province: json['province'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
      );

  Map<String, dynamic> toJson() =>
      {
        'birthDate': birthDate,
        'city': city,
        'expirationDate': expirationDate,
        'facePhoto': facePhoto,
        'fatherName': fatherName,
        'firstName': firstName,
        'lastName': lastName,
        'nationalCode': nationalCode,
        'province': province,
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
      };
}
