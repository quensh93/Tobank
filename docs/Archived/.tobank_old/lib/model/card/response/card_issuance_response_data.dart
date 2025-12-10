import 'dart:convert';

import '../../common/error_response_data.dart';

CardIssuanceResponse cardIssuanceResponseFromJson(String str) =>
    CardIssuanceResponse.fromJson(json.decode(str));

String cardIssuanceResponseToJson(CardIssuanceResponse data) =>
    json.encode(data.toJson());

class CardIssuanceResponse {
  CardIssuanceResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CardIssuanceResponse.fromJson(Map<String, dynamic> json) => CardIssuanceResponse(
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
    this.pan,
    this.cvv2,
    this.pin2,
    this.issueDate,
    this.expireDate,
    this.minPhysicalIssuanceBalance,
  });

  String? trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  String? pan;
  String? cvv2;
  String? pin2;
  int? issueDate;
  String? expireDate;
  int? minPhysicalIssuanceBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        pan: json['pan'],
        cvv2: json['cvv2'],
        pin2: json['pin2'],
        issueDate: json['issueDate'],
        expireDate: json['expireDate'],
        minPhysicalIssuanceBalance: json['minPhysicalIssuanceBalance'],
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'pan': pan,
        'cvv2': cvv2,
        'pin2': pin2,
        'issueDate': issueDate,
        'expireDate': expireDate,
        'minPhysicalIssuanceBalance': minPhysicalIssuanceBalance,
      };
}
