import 'dart:convert';

import '../../common/error_response_data.dart';

RegistrationResponse registrationResponseDataFromJson(String str) =>
    RegistrationResponse.fromJson(json.decode(str));

String registrationResponseDataToJson(RegistrationResponse data) =>
    json.encode(data.toJson());

class RegistrationResponse {
  RegistrationResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) => RegistrationResponse(
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
    this.trackingNumber,
    this.transactionId,
    this.registrationDate,
    this.status,
    this.message,
    this.errors,
    this.nationalCode,
    this.firstName,
    this.lastName,
    this.gender,
    this.customerNumber,
    this.shahabCodeAcquired,
    this.customerStatus,
    this.digitalBankingCustomer,
  });

  String? trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  String? nationalCode;
  String? firstName;
  String? lastName;
  String? gender;
  String? customerNumber;
  bool? shahabCodeAcquired;
  int? customerStatus; // 0 inActive, 1 Active, 2 unConfirmed
  bool? digitalBankingCustomer;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        nationalCode: json['nationalCode'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        customerNumber: json['customerNumber'],
        shahabCodeAcquired: json['shahabCodeAcquired'],
        customerStatus: json['customerStatus'],
        digitalBankingCustomer: json['digitalBankingCustomer'],
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'nationalCode': nationalCode,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'customerNumber': customerNumber,
        'shahabCodeAcquired': shahabCodeAcquired,
        'customerStatus': customerStatus,
        'digitalBankingCustomer': digitalBankingCustomer,
      };
}
