import 'dart:convert';

import '../../common/error_response_data.dart';

PayBillData payBillDataFromJson(String str) => PayBillData.fromJson(json.decode(str));

String payBillDataToJson(PayBillData data) => json.encode(data.toJson());

class PayBillData {
  PayBillData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PayBillData.fromJson(Map<String, dynamic> json) => PayBillData(
        data: Data.fromJson(json['data']),
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data!.toJson(),
        'success': success,
      };
}

class Data {
  Data({
    this.transactionId,
    this.url,
  });

  int? transactionId;
  String? url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId: json['transaction_id'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() =>
      {
        'transaction_id': transactionId,
        'url': url,
      };
}
