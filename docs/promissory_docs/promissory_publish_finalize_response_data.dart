import 'dart:convert';

import '../../common/error_response_data.dart';

PromissoryPublishFinalizeResponse promissoryPublishFinalizeResponseFromJson(
        String str) =>
    PromissoryPublishFinalizeResponse.fromJson(json.decode(str));

String promissoryPublishFinalizeResponseToJson(
        PromissoryPublishFinalizeResponse data) =>
    json.encode(data.toJson());

class PromissoryPublishFinalizeResponse {
  PromissoryPublishFinalizeResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissoryPublishFinalizeResponse.fromJson(
          Map<String, dynamic> json) =>
      PromissoryPublishFinalizeResponse(
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
    this.promissoryId,
    this.multiSignedPdf,
  });

  String? promissoryId;
  String? multiSignedPdf;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        promissoryId: json['promissoryId'],
        multiSignedPdf: json['multiSignedPdf'],
      );

  Map<String, dynamic> toJson() => {
        'promissoryId': promissoryId,
        'multiSignedPdf': multiSignedPdf,
      };
}
