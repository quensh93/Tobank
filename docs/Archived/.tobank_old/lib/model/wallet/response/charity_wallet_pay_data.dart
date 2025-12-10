import 'dart:convert';

import '../../transaction/response/transaction_data.dart';

CharityWalletPayData charityWalletPayDataFromJson(String str) => CharityWalletPayData.fromJson(json.decode(str));

String charityWalletPayDataToJson(CharityWalletPayData data) => json.encode(data.toJson());

class CharityWalletPayData {
  bool? status;
  String? message;
  TransactionData? trans;
  int? statusCode;

  CharityWalletPayData({
    this.status,
    this.message,
    this.trans,
  });

  factory CharityWalletPayData.fromJson(Map<String, dynamic> json) => CharityWalletPayData(
        status: json['status'],
        message: json['message'],
        trans: TransactionData.fromJson(json['trans']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'trans': trans!.toJson(),
      };
}
