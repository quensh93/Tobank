import 'dart:convert';

import '../../common/error_response_data.dart';

InternetStaticDataModel internetStaticDataModelFromJson(String str) =>
    InternetStaticDataModel.fromJson(json.decode(str));

String internetStaticDataModelToJson(InternetStaticDataModel data) => json.encode(data.toJson());

class InternetStaticDataModel {
  InternetStaticDataModel({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory InternetStaticDataModel.fromJson(Map<String, dynamic> json) => InternetStaticDataModel(
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
    this.dataPlanType,
  });

  DataPlanType? dataPlanType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dataPlanType: json['data_plan_type'] == null ? null : DataPlanType.fromJson(json['data_plan_type']),
      );

  Map<String, dynamic> toJson() => {
        'data_plan_type': dataPlanType?.toJson(),
      };
}

class DataPlanType {
  DataPlanType({
    this.mci,
    this.mtn,
    this.rightel,
    this.shatel,
    this.title,
  });

  List<SimType>? mci;
  List<SimType>? mtn;
  List<SimType>? rightel;
  List<SimType>? shatel;
  String? title;

  factory DataPlanType.fromJson(Map<String, dynamic> json) => DataPlanType(
        mci: json['mci'] == null ? null : List<SimType>.from(json['mci'].map((x) => SimType.fromJson(x))),
        mtn: json['mtn'] == null ? null : List<SimType>.from(json['mtn'].map((x) => SimType.fromJson(x))),
        rightel: json['rightel'] == null ? null : List<SimType>.from(json['rightel'].map((x) => SimType.fromJson(x))),
        shatel: json['shatel'] == null ? null : List<SimType>.from(json['shatel'].map((x) => SimType.fromJson(x))),
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'mci': mci == null ? null : List<dynamic>.from(mci!.map((x) => x.toJson())),
        'mtn': mtn == null ? null : List<dynamic>.from(mtn!.map((x) => x.toJson())),
        'rightel': rightel == null ? null : List<dynamic>.from(rightel!.map((x) => x.toJson())),
        'shatel': shatel == null ? null : List<dynamic>.from(shatel!.map((x) => x.toJson())),
        'title': title,
      };
}

class SimType {
  SimType({
    this.title,
    this.value,
  });

  String? title;
  int? value;

  factory SimType.fromJson(Map<String, dynamic> json) => SimType(
        title: json['title'],
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'value': value,
      };
}
