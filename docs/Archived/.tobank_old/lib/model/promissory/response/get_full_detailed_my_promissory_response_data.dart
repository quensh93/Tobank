import 'dart:convert';

import '../../common/error_response_data.dart';
import '../promissory_list_info_detailed.dart';
import 'promissory_request_history_response_data.dart';

GetMyFullDeatiledPromissoryResponse getMyFullDeatiledPromissoryResponseFromJson(String str) =>
    GetMyFullDeatiledPromissoryResponse.fromJson(json.decode(str));

class GetMyFullDeatiledPromissoryResponse {
  GetMyFullDeatiledPromissoryResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory GetMyFullDeatiledPromissoryResponse.fromJson(Map<String, dynamic> json) =>
      GetMyFullDeatiledPromissoryResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.publishedFinalized,
    this.publishOpenRequest,
  });

  PublishedFinalized? publishedFinalized;
  PublishRequest? publishOpenRequest;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        publishedFinalized:
            json['publish_finalized'] == null ? null : PublishedFinalized.fromJson(json['publish_finalized']),
        publishOpenRequest:
            json['publish_open_request'] == null ? null : PublishRequest.fromJson(json['publish_open_request']),
      );
}

class PublishedFinalized {
  PublishedFinalized({
    this.promissoryInfoDetailList,
    this.count,
    this.hasNext,
  });

  List<PromissoryListInfoDetail>? promissoryInfoDetailList;
  int? count;
  bool? hasNext;

  factory PublishedFinalized.fromJson(Map<String, dynamic> json) => PublishedFinalized(
        promissoryInfoDetailList: json['list'] == null
            ? null
            : List<PromissoryListInfoDetail>.from(json['list'].map((x) => PromissoryListInfoDetail.fromJson(x))),
        count: json['count'],
        hasNext: json['hasNext'],
      );
}
