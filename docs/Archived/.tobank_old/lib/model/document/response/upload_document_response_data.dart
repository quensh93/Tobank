import 'dart:convert';

import '../../common/error_response_data.dart';

UploadDocumentResponseData uploadDocumentResponseDataFromJson(String str) =>
    UploadDocumentResponseData.fromJson(json.decode(str));

String uploadDocumentResponseDataToJson(UploadDocumentResponseData data) =>
    json.encode(data.toJson());

class UploadDocumentResponseData {
  UploadDocumentResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory UploadDocumentResponseData.fromJson(Map<String, dynamic> json) => UploadDocumentResponseData(
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
    this.documentId,
    this.registrationDate,
    this.status,
    this.trackingNumber,
    this.transactionId,
  });

  String? documentId;
  int? registrationDate;
  int? status;
  String? trackingNumber;
  String? transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        documentId: json['documentId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
      );

  Map<String, dynamic> toJson() =>
      {
        'documentId': documentId,
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
      };
}
