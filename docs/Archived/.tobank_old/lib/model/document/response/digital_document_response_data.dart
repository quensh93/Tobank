import 'dart:convert';

import '../../common/error_response_data.dart';

DigitalDocumentResponseData digitalDocumentResponseDataFromJson(String str) =>
    DigitalDocumentResponseData.fromJson(json.decode(str));

String digitalDocumentResponseDataToJson(DigitalDocumentResponseData data) => json.encode(data.toJson());

class DigitalDocumentResponseData {
  DigitalDocumentResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory DigitalDocumentResponseData.fromJson(Map<String, dynamic> json) => DigitalDocumentResponseData(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.documentData,
    this.registrationDate,
    this.status,
    this.trackingNumber,
    this.transactionId,
    this.message,
    this.errors,
  });

  String? documentData;
  int? registrationDate;
  int? status;
  String? trackingNumber;
  String? transactionId;
  dynamic message;
  dynamic errors;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        documentData: json['documentData'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        message: json['message'],
        errors: json['errors'],
      );

  Map<String, dynamic> toJson() => {
        'documentData': documentData,
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'message': message,
        'errors': errors,
      };
}
