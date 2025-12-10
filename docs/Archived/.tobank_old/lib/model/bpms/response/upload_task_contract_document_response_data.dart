import 'dart:convert';

import '../../common/error_response_data.dart';

UploadTaskContractDocumentResponse uploadTaskContractDocumentResponseFromJson(
        String str) =>
    UploadTaskContractDocumentResponse.fromJson(json.decode(str));

String uploadTaskContractDocumentResponseToJson(
        UploadTaskContractDocumentResponse data) =>
    json.encode(data.toJson());

class UploadTaskContractDocumentResponse {
  UploadTaskContractDocumentResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory UploadTaskContractDocumentResponse.fromJson(Map<String, dynamic> json) => UploadTaskContractDocumentResponse(
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
