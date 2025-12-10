import 'dart:convert';

import '../../common/error_response_data.dart';

CardUnBlockResponseData cardUnBlockResponseDataFromJson(String str) =>
    CardUnBlockResponseData.fromJson(json.decode(str));

String cardUnBlockResponseDataToJson(CardUnBlockResponseData data) =>
    json.encode(data.toJson());

class CardUnBlockResponseData {
  CardUnBlockResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CardUnBlockResponseData.fromJson(Map<String, dynamic> json) => CardUnBlockResponseData(
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
    this.transactionId,
    this.registrationDate,
    this.status,
    this.message,
    this.errors,
  });

  String? trackingNumber;
  dynamic transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
      };
}
