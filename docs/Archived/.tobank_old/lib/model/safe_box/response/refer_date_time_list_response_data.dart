import 'dart:convert';

import '../../common/error_response_data.dart';

ReferDateTimeListResponseData referDateTimeListResponseDataFromJson(String str) =>
    ReferDateTimeListResponseData.fromJson(json.decode(str));

String referDateTimeListResponseDataToJson(ReferDateTimeListResponseData data) => json.encode(data.toJson());

class ReferDateTimeListResponseData {
  ReferDateTimeListResponseData({
    this.data,
    this.message,
    this.success,
  });

  List<ReferDateTime>? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory ReferDateTimeListResponseData.fromJson(Map<String, dynamic> json) => ReferDateTimeListResponseData(
        data:
            json['data'] == null ? null : List<ReferDateTime>.from(json['data'].map((x) => ReferDateTime.fromJson(x))),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
        'success': success,
      };
}

class ReferDateTime {
  ReferDateTime({
    this.branch,
    this.createdAt,
    this.date,
    this.id,
    this.isActive,
    this.times,
  });

  int? branch;
  DateTime? createdAt;
  String? date;
  int? id;
  bool? isActive;
  List<Time>? times;

  factory ReferDateTime.fromJson(Map<String, dynamic> json) => ReferDateTime(
        branch: json['branch'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        date: json['date'],
        id: json['id'],
        isActive: json['is_active'],
        times: json['times'] == null ? null : List<Time>.from(json['times'].map((x) => Time.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'branch': branch,
        'created_at': createdAt?.toIso8601String(),
        'date': date,
        'id': id,
        'is_active': isActive,
        'times': times == null ? null : List<dynamic>.from(times!.map((x) => x.toJson())),
      };
}

class Time {
  Time({
    this.createdAt,
    this.date,
    this.fromHour,
    this.id,
    this.isActive,
    this.toHour,
  });

  DateTime? createdAt;
  int? date;
  int? fromHour;
  int? id;
  bool? isActive;
  int? toHour;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        date: json['date'],
        fromHour: json['from_hour'],
        id: json['id'],
        isActive: json['is_active'],
        toHour: json['to_hour'],
      );

  Map<String, dynamic> toJson() => {
        'created_at': createdAt?.toIso8601String(),
        'date': date,
        'from_hour': fromHour,
        'id': id,
        'is_active': isActive,
        'to_hour': toHour,
      };
}
