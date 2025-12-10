import 'dart:convert';

import 'error_response_data.dart';

ConfigByTitleResponse configByTitleResponseFromJson(String str) => ConfigByTitleResponse.fromJson(json.decode(str));

String configByTitleResponseToJson(ConfigByTitleResponse data) => json.encode(data.toJson());

class ConfigByTitleResponse {
  Data? data;
  bool? success;
  String? message;
  int? code;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  ConfigByTitleResponse({
    this.data,
    this.success,
    this.message,
    this.code,
  });

  factory ConfigByTitleResponse.fromJson(Map<String, dynamic> json) => ConfigByTitleResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
        'code': code,
      };
}

class Data {
  int? id;
  String? faTitle;
  String? title;
  String? data;
  dynamic category;
  dynamic jsonData;
  String? type;

  Data({
    this.id,
    this.faTitle,
    this.title,
    this.data,
    this.category,
    this.jsonData,
    this.type,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        faTitle: json['fa_title'],
        title: json['title'],
        data: json['data'],
        category: json['category'],
        jsonData: json['json_data'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'fa_title': faTitle,
        'title': title,
        'data': data,
        'category': category,
        'json_data': jsonData,
        'type': type,
      };
}
