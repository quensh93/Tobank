import 'dart:convert';

import '../../common/error_response_data.dart';

PhysicalGiftCardInternetPayData physicalGiftCardInternetPayDataFromJson(String str) =>
    PhysicalGiftCardInternetPayData.fromJson(json.decode(str));

String physicalGiftCardInternetPayDataToJson(PhysicalGiftCardInternetPayData data) => json.encode(data.toJson());

class PhysicalGiftCardInternetPayData {
  PhysicalGiftCardInternetPayData({
    this.transactionId,
    this.url,
  });

  int? transactionId;
  String? url;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PhysicalGiftCardInternetPayData.fromJson(Map<String, dynamic> json) => PhysicalGiftCardInternetPayData(
        transactionId: json['transactionId'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'url': url,
      };
}
