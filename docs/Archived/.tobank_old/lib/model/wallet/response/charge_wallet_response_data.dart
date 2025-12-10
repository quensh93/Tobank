import 'dart:convert';

import '../../common/error_response_data.dart';

ChargeWalletInternetResponseData chargeWalletResponseDataFromJson(String str) =>
    ChargeWalletInternetResponseData.fromJson(json.decode(str));

String chargeWalletResponseDataToJson(ChargeWalletInternetResponseData data) => json.encode(data.toJson());

class ChargeWalletInternetResponseData {
  ChargeWalletInternetResponseData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ChargeWalletInternetResponseData.fromJson(Map<String, dynamic> json) => ChargeWalletInternetResponseData(
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

  Map<String, dynamic> toJson() => {
        'transaction_id': transactionId,
        'url': url,
      };
}
