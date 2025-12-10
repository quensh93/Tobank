import 'dart:convert';

import '../../../common/error_response_data.dart';

ShaparakHubGetKeyResponse shaparakHubGetKeyResponseFromJson(String str) =>
    ShaparakHubGetKeyResponse.fromJson(json.decode(str));

String shaparakHubGetKeyResponseToJson(ShaparakHubGetKeyResponse data) => json.encode(data.toJson());

class ShaparakHubGetKeyResponse {
  ShaparakHubGetKeyResponse({
    this.transactionId,
    this.status,
    this.keyData,
    this.keySpec,
  });

  String? transactionId;
  int? status;
  String? keyData;
  int? keySpec;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ShaparakHubGetKeyResponse.fromJson(Map<String, dynamic> json) => ShaparakHubGetKeyResponse(
        transactionId: json['transactionId'],
        status: json['status'],
        keyData: json['keyData'],
        keySpec: json['keySpec'],
      );

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'status': status,
        'keyData': keyData,
        'keySpec': keySpec,
      };
}
