import 'dart:convert';

import '../../common/error_response_data.dart';

PromissoryPublishResponseData promissoryPublishResponseDataFromJson(String str) =>
    PromissoryPublishResponseData.fromJson(json.decode(str));

String promissoryPublishResponseDataToJson(PromissoryPublishResponseData data) => json.encode(data.toJson());

class PromissoryPublishResponseData {
  PromissoryPublishResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissoryPublishResponseData.fromJson(Map<String, dynamic> json) => PromissoryPublishResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.id,
    this.requestId,
    this.unSignedPdf,
    this.promissoryId,
  });

  int? id;
  String? requestId;
  String? unSignedPdf;
  String? promissoryId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        requestId: json['requestId'],
        unSignedPdf: json['unSignedPdf'],
        promissoryId: json['promissoryId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'requestId': requestId,
        'unSignedPdf': unSignedPdf,
        'promissoryId': promissoryId,
      };
}
