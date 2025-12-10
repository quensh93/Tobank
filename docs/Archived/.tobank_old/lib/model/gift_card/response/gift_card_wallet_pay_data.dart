import 'dart:convert';

import '../../transaction/response/transaction_data.dart';

GiftCardWalletPayData giftCardWalletPayDataFromJson(String str) => GiftCardWalletPayData.fromJson(json.decode(str));

String giftCardWalletPayDataToJson(GiftCardWalletPayData data) => json.encode(data.toJson());

class GiftCardWalletPayData {
  GiftCardWalletPayData({
    this.data,
    this.message,
    this.success,
  });

  TransactionData? data;
  String? message;
  bool? success;
  int? statusCode;

  factory GiftCardWalletPayData.fromJson(Map<String, dynamic> json) => GiftCardWalletPayData(
        data: TransactionData.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'message': message,
        'success': success,
      };
}
