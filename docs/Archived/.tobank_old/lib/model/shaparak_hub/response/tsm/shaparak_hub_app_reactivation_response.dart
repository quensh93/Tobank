import 'dart:convert';

import '../../../common/error_response_data.dart';

ShaparakHubAppReactivationResponse shaparakHubAppReactivationResponseFromJson(String str) =>
    ShaparakHubAppReactivationResponse.fromJson(json.decode(str));

String shaparakHubAppReactivationResponseToJson(ShaparakHubAppReactivationResponse data) => json.encode(data.toJson());

class ShaparakHubAppReactivationResponse {
  ShaparakHubAppReactivationResponse({
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

  factory ShaparakHubAppReactivationResponse.fromJson(Map<String, dynamic> json) => ShaparakHubAppReactivationResponse(
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
    this.transactionId,
    this.status,
    this.trackingNumber,
    this.registrationDate,
    this.reactivationAddress,
  });

  String? transactionId;
  int? status;
  String? trackingNumber;
  int? registrationDate;
  String? reactivationAddress;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId: json['transactionId'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        registrationDate: json['registrationDate'],
        reactivationAddress: json['reactivationAddress'],
      );

  Map<String, dynamic> toJson() =>
      {
        'transactionId': transactionId,
        'status': status,
        'trackingNumber': trackingNumber,
        'registrationDate': registrationDate,
        'reactivationAddress': reactivationAddress,
      };
}
