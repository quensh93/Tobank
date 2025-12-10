import 'dart:convert';

import '../../common/error_response_data.dart';

TransferResponseData transferResponseDataFromJson(String str) => TransferResponseData.fromJson(json.decode(str));

String transferResponseDataToJson(TransferResponseData data) => json.encode(data.toJson());

class TransferResponseData {
  TransferResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory TransferResponseData.fromJson(Map<String, dynamic> json) => TransferResponseData(
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
    this.financialTransactionId,
    this.externalTransactionId,
    this.transferStatus,
    this.externalTransactionDate,
    this.financialTransactionDate,
    this.transferMessage,
  });

  String? trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  String? message;
  List<Error>? errors;
  String? financialTransactionId;
  String? externalTransactionId;
  int? externalTransactionDate;
  int? financialTransactionDate;
  int? transferStatus;
  String? transferMessage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'] == null ? null : List<Error>.from(json['errors'].map((x) => Error.fromJson(x))),
        financialTransactionId: json['financialTransactionId'],
        externalTransactionId: json['externalTransactionId'],
        externalTransactionDate: json['externalTransactionDate'],
        financialTransactionDate: json['financialTransactionDate'],
        transferStatus: json['transfer_status'],
        transferMessage: json['transfer_message'],
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors == null ? null : List<dynamic>.from(errors!.map((x) => x.toJson())),
        'financialTransactionId': financialTransactionId,
        'externalTransactionId': externalTransactionId,
        'transfer_status': transferStatus,
        'externalTransactionDate': externalTransactionDate,
        'financialTransactionDate': financialTransactionDate,
        'transfer_message': transferMessage,
      };
}

class Error {
  Error({
    this.errorCode,
    this.errorDescription,
    this.referenceName,
  });

  int? errorCode;
  String? errorDescription;
  String? referenceName;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorCode: json['errorCode'],
        errorDescription: json['errorDescription'],
        referenceName: json['referenceName'],
      );

  Map<String, dynamic> toJson() => {
        'errorCode': errorCode,
        'errorDescription': errorDescription,
        'referenceName': referenceName,
      };
}
