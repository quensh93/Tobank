import 'dart:convert';

import '../../common/error_response_data.dart';
import '../../transaction/response/transaction_data_response.dart';

SimChargeInternetData simChargeInternetDataFromJson(String str) => SimChargeInternetData.fromJson(json.decode(str));

String simChargeInternetDataToJson(SimChargeInternetData data) => json.encode(data.toJson());

class SimChargeInternetData {
  SimChargeInternetData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;
  TransactionDataResponse? transactionDataResponse;
  late ErrorResponseData errorResponseData;

  factory SimChargeInternetData.fromJson(Map<String, dynamic> json) => SimChargeInternetData(
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
