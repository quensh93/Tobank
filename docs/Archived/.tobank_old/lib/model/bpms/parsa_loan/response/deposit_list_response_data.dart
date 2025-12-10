import 'dart:convert';

import '../../../deposit/response/customer_deposits_response_data.dart';

DepositListResponseData depositListResponseDataFromJson(String str) =>
    DepositListResponseData.fromJson(json.decode(str));

String depositListResponseDataToJson(DepositListResponseData data) => json.encode(data.toJson());

class DepositListResponseData {
  String? message;
  bool? success;
  Data? data;

  DepositListResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory DepositListResponseData.fromJson(Map<String, dynamic> json) => DepositListResponseData(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  List<Deposit>? depositList;

  Data({
    this.depositList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        depositList: json['deposit_list'] == null
            ? []
            : List<Deposit>.from(json['deposit_list']!.map((x) => Deposit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'deposit_list': depositList == null ? [] : List<dynamic>.from(depositList!.map((x) => x.toJson())),
      };
}
