import 'dart:convert';

import '../../../common/error_response_data.dart';

ValidateOtpResponseData validateOtpResponseDataFromJson(String str) =>
    ValidateOtpResponseData.fromJson(json.decode(str));

String validateOtpResponseDataToJson(ValidateOtpResponseData data) => json.encode(data.toJson());

class ValidateOtpResponseData {
  ValidateOtpResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory ValidateOtpResponseData.fromJson(Map<String, dynamic> json) => ValidateOtpResponseData(
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
    this.orderId,
    this.firstName,
    this.lastName,
    this.fatherName,
    this.gender,
    this.birthCertificateNumber,
    this.birthCertificateSeries,
    this.birthCertificateSerial,
    this.birthPlaceName,
    this.registrationPlaceName,
  });

  String? trackingNumber;
  int? registrationDate;
  int? status;
  String? token;
  String? orderId;
  String? firstName;
  String? lastName;
  String? fatherName;
  int? gender;
  String? birthCertificateNumber;
  String? birthCertificateSeries;
  String? birthCertificateSerial;
  String? birthPlaceName;
  String? registrationPlaceName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        token: json['token'],
        orderId: json['orderId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        fatherName: json['fatherName'],
        gender: json['gender'],
        birthCertificateNumber: json['birthCertificateNumber'],
        birthCertificateSeries: json['birthCertificateSeries'],
        birthCertificateSerial: json['birthCertificateSerial'],
        birthPlaceName: json['birthPlaceName'],
        registrationPlaceName: json['registrationPlaceName'],
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'registrationDate': registrationDate,
        'status': status,
        'token': token,
        'orderId': orderId,
        'firstName': firstName,
        'lastName': lastName,
        'fatherName': fatherName,
        'gender': gender,
        'birthCertificateNumber': birthCertificateNumber,
        'birthCertificateSeries': birthCertificateSeries,
        'birthCertificateSerial': birthCertificateSerial,
        'birthPlaceName': birthPlaceName,
        'registrationPlaceName': registrationPlaceName,
      };
}
