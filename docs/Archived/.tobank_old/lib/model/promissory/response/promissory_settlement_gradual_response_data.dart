import 'dart:convert';

import '../../common/error_response_data.dart';

PromissorySettlementGradualResponse promissorySettlementGradualResponseFromJson(String str) =>
    PromissorySettlementGradualResponse.fromJson(json.decode(str));

String promissorySettlementGradualResponseToJson(PromissorySettlementGradualResponse data) =>
    json.encode(data.toJson());

class PromissorySettlementGradualResponse {
  PromissorySettlementGradualResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissorySettlementGradualResponse.fromJson(Map<String, dynamic> json) =>
      PromissorySettlementGradualResponse(
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
    this.id,
    this.requestId,
    this.unSignedPdf,
  });

  int? id;
  String? requestId;
  String? unSignedPdf;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        requestId: json['requestId'],
        unSignedPdf: json['unSignedPdf'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'requestId': requestId,
        'unSignedPdf': unSignedPdf,
      };
}
