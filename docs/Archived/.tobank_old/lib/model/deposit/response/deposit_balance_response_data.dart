import 'dart:convert';

import '../../common/error_response_data.dart';

DepositBalanceResponseData depositBalanceResponseDataFromJson(String str) =>
    DepositBalanceResponseData.fromJson(json.decode(str));

String depositBalanceResponseDataToJson(DepositBalanceResponseData data) =>
    json.encode(data.toJson());

class DepositBalanceResponseData {
  DepositBalanceResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory DepositBalanceResponseData.fromJson(Map<String, dynamic> json) => DepositBalanceResponseData(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.balance,
    this.registrationDate,
    this.status,
    this.trackingNumber,
    this.transactionId,
    this.withdrawableBalance,
  });

  int? balance;
  int? registrationDate;
  int? status;
  String? trackingNumber;
  String? transactionId;
  int? withdrawableBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        balance: json['balance'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        withdrawableBalance: json['withdrawableBalance'],
      );

  Map<String, dynamic> toJson() =>
      {
        'balance': balance,
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'withdrawableBalance': withdrawableBalance,
      };
}
