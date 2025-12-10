import 'dart:convert';

import '../../common/error_response_data.dart';

PromissoryFetchUnsignedDocumentResponse promissoryFetchUnsignedDocumentResponseFromJson(String str) =>
    PromissoryFetchUnsignedDocumentResponse.fromJson(json.decode(str));

class PromissoryFetchUnsignedDocumentResponse {
  PromissoryFetchUnsignedDocumentResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissoryFetchUnsignedDocumentResponse.fromJson(Map<String, dynamic> json) =>
      PromissoryFetchUnsignedDocumentResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.unSignedPdf,
  });

  String? unSignedPdf;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        unSignedPdf: json['unSignedPdf'],
      );
}
