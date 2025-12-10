import 'dart:convert';

import '../../common/error_response_data.dart';

PromissoryInternetPaymentResponseData promissoryInternetPaymentResponseDataFromJson(String str) =>
    PromissoryInternetPaymentResponseData.fromJson(json.decode(str));

String promissoryInternetPaymentResponseDataToJson(PromissoryInternetPaymentResponseData data) =>
    json.encode(data.toJson());

class PromissoryInternetPaymentResponseData {
  PromissoryInternetPaymentResponseData({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissoryInternetPaymentResponseData.fromJson(Map<String, dynamic> json) =>
      PromissoryInternetPaymentResponseData(
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    this.url,
    this.transactionId,
  });

  String? url;
  int? transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json['url'],
        transactionId: json['transaction_id'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'transaction_id': transactionId,
      };
}
