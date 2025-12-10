import 'dart:convert';

import 'error_response_data.dart';

GatewayPayData gatewayPayDataFromJson(String str) => GatewayPayData.fromJson(json.decode(str));

String gatewayPayDataToJson(GatewayPayData data) => json.encode(data.toJson());

class GatewayPayData {
  GatewayPayData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory GatewayPayData.fromJson(Map<String, dynamic> json) => GatewayPayData(
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
