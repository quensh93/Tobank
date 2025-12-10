import 'dart:convert';

import '../../common/error_response_data.dart';

ListCharityData listCharityDataFromJson(String str) => ListCharityData.fromJson(json.decode(str));

String listCharityDataToJson(ListCharityData data) => json.encode(data.toJson());

class ListCharityData {
  ListCharityData({
    this.data,
    this.message,
    this.success,
  });

  List<CharityData>? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ListCharityData.fromJson(Map<String, dynamic> json) => ListCharityData(
        data: List<CharityData>.from(json['data'].map((x) => CharityData.fromJson(x))),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
        'success': success,
      };
}

class CharityData {
  CharityData({
    this.description,
    this.id,
    this.needAmount,
    this.paidAmount,
    this.title,
    this.instituteName,
  });

  String? description;
  int? id;
  int? needAmount;
  int? paidAmount;
  String? title;
  String? instituteName;

  factory CharityData.fromJson(Map<String, dynamic> json) => CharityData(
        description: json['description'],
        id: json['id'],
        needAmount: json['need_amount'],
        paidAmount: json['paid_amount'],
        title: json['title'],
        instituteName: json['institute_name'],
      );

  Map<String, dynamic> toJson() =>
      {
        'description': description,
        'id': id,
        'need_amount': needAmount,
        'paid_amount': paidAmount,
        'title': title,
        'institute_name': instituteName
      };
}
