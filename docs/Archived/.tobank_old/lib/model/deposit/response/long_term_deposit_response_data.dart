import 'dart:convert';

import '../../common/error_response_data.dart';

LongTermDepositResponseData longTermDepositResponseDataFromJson(String str) =>
    LongTermDepositResponseData.fromJson(json.decode(str));

String longTermDepositResponseDataToJson(LongTermDepositResponseData data) =>
    json.encode(data.toJson());

class LongTermDepositResponseData {
  LongTermDepositResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory LongTermDepositResponseData.fromJson(Map<String, dynamic> json) => LongTermDepositResponseData(
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
    this.transactionDate,
    this.depositId,
    this.currentBalance,
    this.currentWithdrawableBalance,
  });

  String? trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  int? transactionDate;
  String? depositId;
  int? currentBalance;
  int? currentWithdrawableBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        transactionDate: json['transactionDate'],
        depositId: json['depositId'],
        currentBalance: json['currentBalance'],
        currentWithdrawableBalance: json['currentWithdrawableBalance'],
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'transactionDate': transactionDate,
        'depositId': depositId,
        'currentBalance': currentBalance,
        'currentWithdrawableBalance': currentWithdrawableBalance,
      };
}
