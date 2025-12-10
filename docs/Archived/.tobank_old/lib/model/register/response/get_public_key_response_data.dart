import 'dart:convert';

import '../../common/error_response_data.dart';

GetPublicKeyResponseData getPublicKeyResponseDataFromJson(String str) =>
    GetPublicKeyResponseData.fromJson(json.decode(str));

String getPublicKeyResponseDataToJson(GetPublicKeyResponseData data) =>
    json.encode(data.toJson());

class GetPublicKeyResponseData {
  GetPublicKeyResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory GetPublicKeyResponseData.fromJson(Map<String, dynamic> json) => GetPublicKeyResponseData(
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
    this.customerPublicKey,
  });

  String? trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  String? customerPublicKey;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        customerPublicKey: json['customerPublicKey'],
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'customerPublicKey': customerPublicKey,
      };
}
