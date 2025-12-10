import 'dart:convert';

import '../../common/error_response_data.dart';

UploadCustomerPublicKeyResponse uploadCustomerPublicKeyResponseFromJson(
        String str) =>
    UploadCustomerPublicKeyResponse.fromJson(json.decode(str));

class UploadCustomerPublicKeyResponse {
  UploadCustomerPublicKeyResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory UploadCustomerPublicKeyResponse.fromJson(Map<String, dynamic> json) => UploadCustomerPublicKeyResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.errors,
    this.message,
    this.registrationDate,
    this.status,
    this.trackingNumber,
    this.transactionId,
  });

  dynamic errors;
  dynamic message;
  int? registrationDate;
  int? status;
  String? trackingNumber;
  dynamic transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        errors: json['errors'],
        message: json['message'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
      );

  Map<String, dynamic> toJson() =>
      {
        'errors': errors,
        'message': message,
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
      };
}
