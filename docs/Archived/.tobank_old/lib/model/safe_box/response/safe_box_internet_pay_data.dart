import 'dart:convert';

import '../../common/error_response_data.dart';

SafeBoxInternetPayData safeBoxInternetPayDataFromJson(String str) =>
    SafeBoxInternetPayData.fromJson(json.decode(str));

String safeBoxInternetPayDataToJson(SafeBoxInternetPayData data) =>
    json.encode(data.toJson());

class SafeBoxInternetPayData {
  SafeBoxInternetPayData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory SafeBoxInternetPayData.fromJson(Map<String, dynamic> json) => SafeBoxInternetPayData(
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
