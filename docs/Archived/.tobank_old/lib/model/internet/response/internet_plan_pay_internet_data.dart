import 'dart:convert';

import '../../common/error_response_data.dart';
import '../../transaction/response/transaction_data_response.dart';

InternetPlanPayInternetData internetPlanPayInternetDataFromJson(String str) =>
    InternetPlanPayInternetData.fromJson(json.decode(str));

String internetPlanPayInternetDataToJson(InternetPlanPayInternetData data) => json.encode(data.toJson());

class InternetPlanPayInternetData {
  InternetPlanPayInternetData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  TransactionDataResponse? transactionDataResponse;
  late ErrorResponseData errorResponseData;

  factory InternetPlanPayInternetData.fromJson(Map<String, dynamic> json) => InternetPlanPayInternetData(
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
