import 'dart:convert';

import '../../common/error_response_data.dart';

CheckUserResponseData checkUserResponseDataFromJson(String str) => CheckUserResponseData.fromJson(json.decode(str));

String checkUserResponseDataToJson(CheckUserResponseData data) => json.encode(data.toJson());

class CheckUserResponseData {
  CheckUserResponseData({
    this.data,
    this.avalaible,
    this.success,
    this.message,
  });

  Data? data;
  bool? avalaible;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory CheckUserResponseData.fromJson(Map<String, dynamic> json) => CheckUserResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        avalaible: json['avalaible'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'avalaible': avalaible,
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
    this.nationalCode,
    this.firstName,
    this.lastName,
    this.gender,
    this.customerNumber,
    this.shahabCodeAcquired,
    this.digitalBankingCustomer,
    this.loyaltyCode,
    this.customerStatus,
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
  int? gender;
  String? customerNumber;
  bool? shahabCodeAcquired;
  bool? digitalBankingCustomer;
  String? loyaltyCode;
  int? customerStatus;

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
        digitalBankingCustomer: json['digitalBankingCustomer'],
        loyaltyCode: json['loyaltyCode'],
        customerStatus: json['customerStatus'],
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
        'digitalBankingCustomer': digitalBankingCustomer,
        'loyaltyCode': loyaltyCode,
        'customerStatus': customerStatus,
      };
}
