import 'dart:convert';

import '../../common/error_response_data.dart';

VisitDateTimeListResponseData visitDateTimeListResponseDataFromJson(String str) =>
    VisitDateTimeListResponseData.fromJson(json.decode(str));

String visitDateTimeListResponseDataToJson(VisitDateTimeListResponseData data) => json.encode(data.toJson());

class VisitDateTimeListResponseData {
  VisitDateTimeListResponseData({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory VisitDateTimeListResponseData.fromJson(Map<String, dynamic> json) => VisitDateTimeListResponseData(
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
      );

  Map<String, dynamic> toJson() =>
      {
        'success': success,
        'data': data?.toJson(),
        'message': message,
      };
}

class Data {
  Data({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<VisitDateTime>? results;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: json['results'] == null
            ? null
            : List<VisitDateTime>.from(json['results'].map((x) => VisitDateTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class VisitDateTime {
  VisitDateTime({
    this.id,
    this.date,
    this.times,
    this.isActive,
    this.createdAt,
  });

  int? id;
  String? date;
  List<Time>? times;
  bool? isActive;
  DateTime? createdAt;

  factory VisitDateTime.fromJson(Map<String, dynamic> json) => VisitDateTime(
        id: json['id'],
        date: json['date'],
        times: json['times'] == null ? null : List<Time>.from(json['times'].map((x) => Time.fromJson(x))),
        isActive: json['is_active'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'times': times == null ? null : List<dynamic>.from(times!.map((x) => x.toJson())),
        'is_active': isActive,
        'created_at': createdAt?.toIso8601String(),
      };
}

class Time {
  Time({
    this.id,
    this.date,
    this.isActive,
    this.fromHour,
    this.toHour,
    this.createdAt,
  });

  int? id;
  String? date;
  bool? isActive;
  int? fromHour;
  int? toHour;
  DateTime? createdAt;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        id: json['id'],
        date: json['date'],
        isActive: json['is_active'],
        fromHour: json['from_hour'],
        toHour: json['to_hour'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'is_active': isActive,
        'from_hour': fromHour,
        'to_hour': toHour,
        'created_at': createdAt?.toIso8601String(),
      };
}
