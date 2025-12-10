import 'dart:convert';

import '../../../common/error_response_data.dart';

ShaparakHubRenewCardIdResponse shaparakHubRenewCardIdResponseFromJson(String str) =>
    ShaparakHubRenewCardIdResponse.fromJson(json.decode(str));

String shaparakHubRenewCardIdResponseToJson(ShaparakHubRenewCardIdResponse data) => json.encode(data.toJson());

class ShaparakHubRenewCardIdResponse {
  ShaparakHubRenewCardIdResponse({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ShaparakHubRenewCardIdResponse.fromJson(Map<String, dynamic> json) => ShaparakHubRenewCardIdResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
      };
}

class Data {
  Data({
    this.cardId,
    this.maskedPan,
    this.referenceExpiryDate,
    this.panExpiryDate,
    this.assuranceLevel,
  });

  String? cardId;
  String? maskedPan;
  String? referenceExpiryDate;
  String? panExpiryDate;
  String? assuranceLevel;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cardId: json['cardId'],
        maskedPan: json['maskedPan'],
        referenceExpiryDate: json['referenceExpiryDate'],
        panExpiryDate: json['panExpiryDate'],
        assuranceLevel: json['assuranceLevel'],
      );

  Map<String, dynamic> toJson() =>
      {
        'cardId': cardId,
        'maskedPan': maskedPan,
        'referenceExpiryDate': referenceExpiryDate,
        'panExpiryDate': panExpiryDate,
        'assuranceLevel': assuranceLevel,
      };
}
