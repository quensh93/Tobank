import 'dart:convert';

import '../../common/error_response_data.dart';
import '../promissory_list_info.dart';

MyPromissoryInquiryResponse myPromissoryInquiryResponseFromJson(String str) =>
    MyPromissoryInquiryResponse.fromJson(json.decode(str));

class MyPromissoryInquiryResponse {
  MyPromissoryInquiryResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory MyPromissoryInquiryResponse.fromJson(Map<String, dynamic> json) => MyPromissoryInquiryResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.promissoryInfoList,
    this.count,
    this.hasNext,
  });

  List<PromissoryListInfo>? promissoryInfoList;
  int? count;
  bool? hasNext;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        promissoryInfoList: json['list'] == null
            ? null
            : List<PromissoryListInfo>.from(json['list'].map((x) => PromissoryListInfo.fromJson(x))),
        count: json['count'],
        hasNext: json['hasNext'],
      );
}

class OpenRequests {
  OpenRequests({
    this.id,
    this.serviceName,
    this.faServiceName,
    this.activation,
    this.createdAt,
    this.updatedAt,
    this.requestId,
    this.promissoryId,
  });

  int? id;
  String? serviceName;
  String? faServiceName;
  bool? activation;
  String? createdAt;
  String? updatedAt;
  String? requestId;
  String? promissoryId;

  factory OpenRequests.fromJson(Map<String, dynamic> json) => OpenRequests(
        id: json['id'],
        serviceName: json['service_name'],
        faServiceName: json['fa_service_name'],
        activation: json['activation'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        requestId: json['request_id'],
        promissoryId: json['promissory_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'service_name': serviceName,
        'fa_service_name': faServiceName,
        'activation': activation,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'request_id': requestId,
        'promissory_id': promissoryId,
      };
}
