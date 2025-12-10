import 'dart:convert';

import '../../../common/error_response_data.dart';

ShaparakHubGetCardInfoResponse shaparakHubGetCardInfoResponseFromJson(String str) =>
    ShaparakHubGetCardInfoResponse.fromJson(json.decode(str));

String shaparakHubGetCardInfoResponseToJson(ShaparakHubGetCardInfoResponse data) => json.encode(data.toJson());

class ShaparakHubGetCardInfoResponse {
  ShaparakHubGetCardInfoResponse({
    this.data,
    this.success,
    this.message,
    this.deviceUUID,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;
  String? deviceUUID;

  factory ShaparakHubGetCardInfoResponse.fromJson(Map<String, dynamic> json) => ShaparakHubGetCardInfoResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
        deviceUUID: json['device_uuid'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
        'device_uuid': deviceUUID,
      };
}

class Data {
  Data({
    this.cardId,
    this.maskedPan,
    this.referenceExpiryDate,
    this.panExpiryDate,
    this.assuranceLevel,
    this.deviceUUID,
  });

  String? cardId;
  String? maskedPan;
  String? referenceExpiryDate;
  String? panExpiryDate;
  String? assuranceLevel;
  String? deviceUUID;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cardId: json['cardId'],
        maskedPan: json['maskedPan'],
        panExpiryDate: json['panExpiryDate'],
        assuranceLevel: json['assuranceLevel'],
        referenceExpiryDate: json['referenceExpiryDate'],
        deviceUUID: json['device_uuid'],
      );

  Map<String, dynamic> toJson() => {
        'cardId': cardId,
        'maskedPan': maskedPan,
        'panExpiryDate': panExpiryDate,
        'assuranceLevel': assuranceLevel,
        'referenceExpiryDate': referenceExpiryDate,
        'device_uuid': deviceUUID,
      };
}
