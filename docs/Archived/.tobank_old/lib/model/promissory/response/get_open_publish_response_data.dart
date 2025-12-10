import 'dart:convert';

import '../../common/error_response_data.dart';
import 'promissory_request_history_response_data.dart';

GetOpenPublishResponse getOpenPublishResponseFromJson(String str) =>
    GetOpenPublishResponse.fromJson(json.decode(str));

class GetOpenPublishResponse {
  GetOpenPublishResponse({
    this.data,
    this.message,
    this.success,
  });

  PublishRequest? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory GetOpenPublishResponse.fromJson(Map<String, dynamic> json) => GetOpenPublishResponse(
        data: json['data'] == null ? null : PublishRequest.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}
