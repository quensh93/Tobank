import 'dart:convert';

import '../../common/error_response_data.dart';

PromissorySettlementGradualFinalizeResponse promissorySettlementGradualFinalizeResponseFromJson(String str) =>
    PromissorySettlementGradualFinalizeResponse.fromJson(json.decode(str));

String promissorySettlementGradualFinalizeResponseToJson(PromissorySettlementGradualFinalizeResponse data) =>
    json.encode(data.toJson());

class PromissorySettlementGradualFinalizeResponse {
  PromissorySettlementGradualFinalizeResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissorySettlementGradualFinalizeResponse.fromJson(Map<String, dynamic> json) =>
      PromissorySettlementGradualFinalizeResponse(
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
    this.multiSignedPdf,
  });

  String? multiSignedPdf;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        multiSignedPdf: json['multiSignedPdf'],
      );

  Map<String, dynamic> toJson() => {
        'multiSignedPdf': multiSignedPdf,
      };
}
