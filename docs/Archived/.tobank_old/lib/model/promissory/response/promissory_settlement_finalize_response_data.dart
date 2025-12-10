import 'dart:convert';

import '../../common/error_response_data.dart';

PromissorySettlementFinalizeResponse promissorySettlementFinalizeResponseFromJson(String str) =>
    PromissorySettlementFinalizeResponse.fromJson(json.decode(str));

String promissorySettlementFinalizeResponseToJson(PromissorySettlementFinalizeResponse data) =>
    json.encode(data.toJson());

class PromissorySettlementFinalizeResponse {
  PromissorySettlementFinalizeResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissorySettlementFinalizeResponse.fromJson(Map<String, dynamic> json) =>
      PromissorySettlementFinalizeResponse(
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
