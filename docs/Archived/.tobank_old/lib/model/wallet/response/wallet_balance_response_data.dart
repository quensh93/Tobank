import 'dart:convert';

import '../../common/error_response_data.dart';

WalletBalanceResponseData walletBalanceResponseDataFromJson(String str) =>
    WalletBalanceResponseData.fromJson(json.decode(str));

String walletBalanceResponseDataToJson(WalletBalanceResponseData data) => json.encode(data.toJson());

class WalletBalanceResponseData {
  WalletBalanceResponseData({
    this.data,
    this.success,
    this.message,
    this.code,
  });

  Data? data;
  bool? success;
  String? message;
  int? code;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory WalletBalanceResponseData.fromJson(Map<String, dynamic> json) => WalletBalanceResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
        'code': code,
      };
}

class Data {
  Data({
    this.amount,
  });

  int? amount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    amount: json['amount'],
      );

  Map<String, dynamic> toJson() =>
      {
        'amount': amount,
      };
}
