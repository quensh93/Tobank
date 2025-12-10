import 'dart:convert';

import '../../common/error_response_data.dart';

ChangeCardPinResponse changeCardPinResponseFromJson(String str) =>
    ChangeCardPinResponse.fromJson(json.decode(str));

String changeCardPinResponseToJson(ChangeCardPinResponse data) =>
    json.encode(data.toJson());

class ChangeCardPinResponse {
  ChangeCardPinResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory ChangeCardPinResponse.fromJson(Map<String, dynamic> json) => ChangeCardPinResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.trackingNumber,
    this.transactionId,
    this.registrationDate,
    this.status,
    this.message,
    this.errors,
    this.pin1,
    this.pin2,
  });

  String? trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  String? pin1;
  String? pin2;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        pin1: json['pin1'],
        pin2: json['pin2'],
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'pin1': pin1,
        'pin2': pin2,
      };
}
