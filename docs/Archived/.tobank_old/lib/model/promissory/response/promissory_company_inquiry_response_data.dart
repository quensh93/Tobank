import 'dart:convert';

import '../../common/error_response_data.dart';

PromissoryCompanyInquiryResponseData
    promissoryCompanyInquiryResponseDataFromJson(String str) =>
        PromissoryCompanyInquiryResponseData.fromJson(json.decode(str));

String promissoryCompanyInquiryResponseDataToJson(
        PromissoryCompanyInquiryResponseData? data) =>
    json.encode(data!.toJson());

class PromissoryCompanyInquiryResponseData {
  PromissoryCompanyInquiryResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissoryCompanyInquiryResponseData.fromJson(Map<String, dynamic> json) =>
      PromissoryCompanyInquiryResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data,
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.address,
    this.companyTitle,
    this.status,
    this.zipcode,
  });

  String? address;
  String? companyTitle;
  String? status;
  String? zipcode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        address: json['address'],
        companyTitle: json['company_title'],
        status: json['status'],
        zipcode: json['zipcode'],
      );

  Map<String, dynamic> toJson() =>
      {
        'address': address,
        'company_title': companyTitle,
        'status': status,
        'zipcode': zipcode,
      };
}
