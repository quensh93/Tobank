import 'dart:convert';

import 'transaction_data.dart';

ListTransactionData listTransactionDataFromJson(String str) => ListTransactionData.fromJson(json.decode(str));

String listTransactionDataToJson(ListTransactionData data) => json.encode(data.toJson());

class ListTransactionData {
  ListTransactionData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;

  factory ListTransactionData.fromJson(Map<String, dynamic> json) => ListTransactionData(
        data: Data.fromJson(json['data']),
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'success': success,
      };
}

class Data {
  Data({
    this.count,
    this.items,
    this.next,
    this.previous,
  });

  int? count;
  List<TransactionData>? items;
  String? next;
  dynamic previous;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'],
        items: List<TransactionData>.from(json['items'].map((x) => TransactionData.fromJson(x))),
        next: json['next'],
        previous: json['previous'],
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'items': List<dynamic>.from(items!.map((x) => x.toJson())),
        'next': next,
        'previous': previous,
      };
}
