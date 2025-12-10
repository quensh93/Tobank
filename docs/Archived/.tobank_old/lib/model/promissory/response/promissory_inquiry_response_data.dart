import 'dart:convert';

import '../../common/error_response_data.dart';
import '../promissory_single_info.dart';

PromissoryInquiryResponseData promissoryInquiryResponseDataFromJson(String str) =>
    PromissoryInquiryResponseData.fromJson(json.decode(str));

class PromissoryInquiryResponseData {
  PromissoryInquiryResponseData({
    this.data,
    this.message,
    this.success,
  });

  PromissorySingleInfo? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissoryInquiryResponseData.fromJson(Map<String, dynamic> json) => PromissoryInquiryResponseData(
        data: json['data'] == null ? null : PromissorySingleInfo.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}
