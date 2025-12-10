import 'dart:convert';

import '../../common/error_response_data.dart';

CreditInquiryOrderIdResponseData creditInquiryOrderIdResponseDataFromJson(String str) =>
    CreditInquiryOrderIdResponseData.fromJson(json.decode(str));

class CreditInquiryOrderIdResponseData {
  String? message;
  bool? success;
  Data? data;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  CreditInquiryOrderIdResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory CreditInquiryOrderIdResponseData.fromJson(Map<String, dynamic> json) => CreditInquiryOrderIdResponseData(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  int? status;
  String? orderId;
  bool? success;
  String? fullname;
  String? pdfFile;
  String? referenceCode;
  String? message;

  Data({
    this.status,
    this.orderId,
    this.success,
    this.fullname,
    this.pdfFile,
    this.referenceCode,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json['status'],
        orderId: json['order_id'],
        success: json['success'],
        fullname: json['fullname'],
        pdfFile: json['pdf_file'],
        referenceCode: json['reference_code'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'order_id': orderId,
        'success': success,
        'fullname': fullname,
        'pdf_file': pdfFile,
        'reference_code': referenceCode,
        'message': message,
      };
}
