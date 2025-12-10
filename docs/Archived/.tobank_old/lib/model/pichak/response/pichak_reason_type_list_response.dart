import 'dart:convert';

import '../../common/error_response_data.dart';

PichakReasonTypeListResponse pichakReasonTypeListFromJson(String str) =>
    PichakReasonTypeListResponse.fromJson(json.decode(str));

String pichakReasonTypeListResponseToJson(PichakReasonTypeListResponse data) => json.encode(data.toJson());

class PichakReasonTypeListResponse {
  PichakReasonTypeListResponse({
    this.data,
    this.message,
    this.success,
  });

  List<ReasonType>? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PichakReasonTypeListResponse.fromJson(Map<String, dynamic> json) => PichakReasonTypeListResponse(
        data: json['data'] == null ? [] : List<ReasonType>.from(json['data']!.map((x) => ReasonType.fromJson(x))),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
        'success': success,
      };
}

class ReasonType {
  int? id;
  String? code;
  String? faTitle;

  ReasonType({
    this.id,
    this.code,
    this.faTitle,
  });

  factory ReasonType.fromJson(Map<String, dynamic> json) => ReasonType(
        id: json['id'],
        code: json['code'],
        faTitle: json['fa_title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'fa_title': faTitle,
      };
}
