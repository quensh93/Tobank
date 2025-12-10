import 'dart:convert';

import '../../common/error_response_data.dart';

CBSFetchDocumentResponse cbsFetchDocumentResponseFromJson(String str) =>
    CBSFetchDocumentResponse.fromJson(json.decode(str));

String cbsFetchDocumentResponseToJson(CBSFetchDocumentResponse data) => json.encode(data.toJson());

class CBSFetchDocumentResponse {
  CBSFetchDocumentResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory CBSFetchDocumentResponse.fromJson(Map<String, dynamic> json) => CBSFetchDocumentResponse(
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
    this.fullName,
    this.pdfFile,
    this.referenceCode,
  });

  String? fullName;
  String? pdfFile;
  String? referenceCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fullName: json['fullname'],
        pdfFile: json['pdf_file'],
        referenceCode: json['reference_code'],
      );

  Map<String, dynamic> toJson() =>
      {
        'fullname': fullName,
        'pdf_file': pdfFile,
        'reference_code': referenceCode,
      };
}
