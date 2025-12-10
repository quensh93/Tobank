import 'dart:convert';

import '../../common/error_response_data.dart';

ListPhysicalGiftCardAmountData listPhysicalGiftCardAmountDataFromJson(String str) =>
    ListPhysicalGiftCardAmountData.fromJson(json.decode(str));

String listPhysicalGiftCardAmountDataToJson(ListPhysicalGiftCardAmountData data) => json.encode(data.toJson());

class ListPhysicalGiftCardAmountData {
  ListPhysicalGiftCardAmountData({
    this.data,
    this.success,
  });

  List<PhysicalGiftCardAmount>? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ListPhysicalGiftCardAmountData.fromJson(Map<String, dynamic> json) => ListPhysicalGiftCardAmountData(
        data: List<PhysicalGiftCardAmount>.from(json['data'].map((x) => PhysicalGiftCardAmount.fromJson(x))),
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'success': success,
      };
}

class PhysicalGiftCardAmount {
  PhysicalGiftCardAmount({
    this.balance,
    this.id,
    this.title,
  });

  int? balance;
  int? id;
  String? title;

  factory PhysicalGiftCardAmount.fromJson(Map<String, dynamic> json) => PhysicalGiftCardAmount(
        balance: json['balance'],
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'balance': balance,
        'id': id,
        'title': title,
      };
}
