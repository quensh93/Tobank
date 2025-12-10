import 'dart:convert';

import '../../common/error_response_data.dart';

ListContactMatchResponseData listContactMatchResponseDataFromJson(String str) =>
    ListContactMatchResponseData.fromJson(json.decode(str));

String listContactMatchResponseDataToJson(ListContactMatchResponseData data) => json.encode(data.toJson());

class ListContactMatchResponseData {
  ListContactMatchResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ListContactMatchResponseData.fromJson(Map<String, dynamic> json) => ListContactMatchResponseData(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.match,
  });

  List<String>? match;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    match: List<String>.from(json['match'].map((x) => x)),
      );

  Map<String, dynamic> toJson() =>
      {
        'match': List<dynamic>.from(match!.map((x) => x)),
      };
}
