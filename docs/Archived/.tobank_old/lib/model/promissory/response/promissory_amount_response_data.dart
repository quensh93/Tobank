import 'dart:convert';

import '../../common/error_response_data.dart';

PromissoryAmountResponseData promissoryAmountResponseDataFromJson(String str) =>
    PromissoryAmountResponseData.fromJson(json.decode(str));

String promissoryAmountResponseDataToJson(PromissoryAmountResponseData data) => json.encode(data.toJson());

class PromissoryAmountResponseData {
  PromissoryAmountResponseData({
    this.data,
    this.messages,
    this.success,
  });

  Data? data;
  String? messages;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissoryAmountResponseData.fromJson(Map<String, dynamic> json) => PromissoryAmountResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        messages: json['messages'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'messages': messages,
        'success': success,
      };
}

class Data {
  Data({
    this.stampFee,
    this.totalAmount,
    this.wage,
    this.gssToYektaFee,
  });

  int? stampFee;
  int? totalAmount;
  int? wage;
  int? gssToYektaFee;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stampFee: json['stamp_fee'],
        totalAmount: json['total_amount'],
        wage: json['wage'],
        gssToYektaFee: json['gss_to_yekta_fee'],
      );

  Map<String, dynamic> toJson() =>
      {
        'stamp_fee': stampFee,
        'total_amount': totalAmount,
        'wage': wage,
        'gss_to_yekta_fee': gssToYektaFee,
      };
}
