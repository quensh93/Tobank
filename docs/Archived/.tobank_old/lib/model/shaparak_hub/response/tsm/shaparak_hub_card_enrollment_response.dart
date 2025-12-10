import 'dart:convert';

import '../../../common/error_response_data.dart';

ShaparakHubCardEnrollmentResponse shaparakHubCardEnrollmentResponseFromJson(String str) =>
    ShaparakHubCardEnrollmentResponse.fromJson(json.decode(str));

String shaparakHubCardEnrollmentResponseToJson(ShaparakHubCardEnrollmentResponse data) => json.encode(data.toJson());

class ShaparakHubCardEnrollmentResponse {
  ShaparakHubCardEnrollmentResponse({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ShaparakHubCardEnrollmentResponse.fromJson(Map<String, dynamic> json) => ShaparakHubCardEnrollmentResponse(
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
    this.transactionId,
    this.status,
    this.trackingNumber,
    this.registrationDate,
    this.registrationAddress,
  });

  String? transactionId;
  int? status;
  String? trackingNumber;
  int? registrationDate;
  String? registrationAddress;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId: json['transactionId'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        registrationDate: json['registrationDate'],
        registrationAddress: json['registrationAddress'],
      );

  Map<String, dynamic> toJson() =>
      {
        'transactionId': transactionId,
        'status': status,
        'trackingNumber': trackingNumber,
        'registrationDate': registrationDate,
        'registrationAddress': registrationAddress,
      };
}
