import 'dart:convert';

import '../../common/error_response_data.dart';

CheckPersonalInfoResponseData checkPersonalInfoResponseDataFromJson(String str) =>
    CheckPersonalInfoResponseData.fromJson(json.decode(str));

String checkPersonalInfoResponseDataToJson(CheckPersonalInfoResponseData data) => json.encode(data.toJson());

class CheckPersonalInfoResponseData {
  CheckPersonalInfoResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CheckPersonalInfoResponseData.fromJson(Map<String, dynamic> json) => CheckPersonalInfoResponseData(
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
    this.transactionId,
    this.registrationDate,
    this.status,
    this.message,
    this.errors,
    this.customerNumber,
    this.birthDate,
    this.nationalCode,
    this.firstName,
    this.lastName,
    this.fatherName,
    this.gender,
    this.officeCode,
    this.officeName,
    this.birthCertificateNumber,
    this.birthCertificateSeries,
    this.birthCertificateSerial,
  });

  String? trackingNumber;
  dynamic transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  String? customerNumber;
  int? birthDate;
  String? nationalCode;
  String? firstName;
  String? lastName;
  String? fatherName;
  int? gender;
  int? officeCode;
  String? officeName;
  String? birthCertificateNumber;
  String? birthCertificateSeries;
  String? birthCertificateSerial;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        customerNumber: json['customerNumber'],
        birthDate: json['birthDate'],
        nationalCode: json['nationalCode'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        fatherName: json['fatherName'],
        gender: json['gender'],
        officeCode: json['officeCode'],
        officeName: json['officeName'],
        birthCertificateNumber: json['birthCertificateNumber'],
        birthCertificateSeries: json['birthCertificateSeries'],
        birthCertificateSerial: json['birthCertificateSerial'],
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'customerNumber': customerNumber,
        'birthDate': birthDate,
        'nationalCode': nationalCode,
        'firstName': firstName,
        'lastName': lastName,
        'fatherName': fatherName,
        'gender': gender,
        'officeCode': officeCode,
        'officeName': officeName,
        'birthCertificateNumber': birthCertificateNumber,
        'birthCertificateSeries': birthCertificateSeries,
        'birthCertificateSerial': birthCertificateSerial,
      };
}
