import 'dart:convert';

import '../../common/error_response_data.dart';

SubmitVisitSafeBoxResponseData submitVisitSafeBoxResponseDataFromJson(String str) =>
    SubmitVisitSafeBoxResponseData.fromJson(json.decode(str));

String submitVisitSafeBoxResponseDataToJson(SubmitVisitSafeBoxResponseData data) => json.encode(data.toJson());

class SubmitVisitSafeBoxResponseData {
  SubmitVisitSafeBoxResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory SubmitVisitSafeBoxResponseData.fromJson(Map<String, dynamic> json) => SubmitVisitSafeBoxResponseData(
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
    this.id,
    this.createdAt,
    this.userFund,
    this.visitTime,
  });

  int? id;
  DateTime? createdAt;
  int? userFund;
  int? visitTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        userFund: json['user_fund'],
        visitTime: json['visit_time'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'user_fund': userFund,
        'visit_time': visitTime,
      };
}
