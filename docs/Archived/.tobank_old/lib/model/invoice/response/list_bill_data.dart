import 'dart:convert';

import '../../common/error_response_data.dart';
import 'bill_data_response.dart';

ListBillData listBillDataFromJson(String str) => ListBillData.fromJson(json.decode(str));

String listBillDataToJson(ListBillData data) => json.encode(data.toJson());

class ListBillData {
  ListBillData({
    this.data,
    this.message,
    this.success,
  });

  List<BillData>? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ListBillData.fromJson(Map<String, dynamic> json) => ListBillData(
        data: List<BillData>.from(json['data'].map((x) => BillData.fromJson(x))),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
        'success': success,
      };
}
