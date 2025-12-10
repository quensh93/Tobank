import 'dart:convert';

import '../../common/error_response_data.dart';

TransferStatusResponseData transferStatusResponseDataFromJson(String str) =>
    TransferStatusResponseData.fromJson(json.decode(str));

String transferStatusResponseDataToJson(TransferStatusResponseData data) =>
    json.encode(data.toJson());

class TransferStatusResponseData {
  TransferStatusResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory TransferStatusResponseData.fromJson(Map<String, dynamic> json) => TransferStatusResponseData(
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
    this.financialTransactionDate,
    this.financialTransactionStatus,
    this.message,
    this.registrationDate,
    this.status,
    this.trackingNumber,
    this.transactionId,
  });

  int? financialTransactionDate;
  int? financialTransactionStatus;
  String? message;
  int? registrationDate;
  int? status;
  String? trackingNumber;
  String? transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        financialTransactionDate: json['financialTransactionDate'],
        financialTransactionStatus: json['financialTransactionStatus'],
        message: json['message'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
      );

  Map<String, dynamic> toJson() =>
      {
        'financialTransactionDate': financialTransactionDate,
        'financialTransactionStatus': financialTransactionStatus,
        'message': message,
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
      };
}
