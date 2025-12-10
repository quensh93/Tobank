import 'dart:convert';

import '../error_response_pichak_data.dart';

ConfirmationResponse confirmationResponseFromJson(String str) => ConfirmationResponse.fromJson(json.decode(str));

String confirmationResponseToJson(ConfirmationResponse data) => json.encode(data.toJson());

class ConfirmationResponse {
  ConfirmationResponse({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponsePichakData errorResponsePichakData;

  factory ConfirmationResponse.fromJson(Map<String, dynamic> json) => ConfirmationResponse(
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
    this.trackingNumber,
    this.requestId,
    this.status,
    this.registrationDate,
  });

  String? trackingNumber;
  String? requestId;
  int? status;
  int? registrationDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        requestId: json['requestId'],
        status: json['status'],
        registrationDate: json['registrationDate'],
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'requestId': requestId,
        'status': status,
        'registrationDate': registrationDate,
      };
}
