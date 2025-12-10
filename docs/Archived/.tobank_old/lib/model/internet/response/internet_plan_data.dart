import 'dart:convert';

import '../../common/error_response_data.dart';

InternetPlanData internetPlanDataFromJson(String str) => InternetPlanData.fromJson(json.decode(str));

String internetPlanDataToJson(InternetPlanData data) => json.encode(data.toJson());

class InternetPlanData {
  InternetPlanData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory InternetPlanData.fromJson(Map<String, dynamic> json) => InternetPlanData(
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
    this.dataPlanLists,
    this.responseCode,
    this.responseMessage,
  });

  List<DataPlanList>? dataPlanLists;
  int? responseCode;
  List<String>? responseMessage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dataPlanLists: List<DataPlanList>.from(json['data_plan_lists'].map((x) => DataPlanList.fromJson(x))),
        responseCode: json['response_code'],
        responseMessage: List<String>.from(json['response_message'].map((x) => x)),
      );

  Map<String, dynamic> toJson() =>
      {
        'data_plan_lists': List<dynamic>.from(dataPlanLists!.map((x) => x.toJson())),
        'response_code': responseCode,
        'response_message': List<dynamic>.from(responseMessage!.map((x) => x)),
      };
}

class DataPlanList {
  DataPlanList({
    this.dataPlanType,
    this.fddAndTdd,
    this.id,
    this.dataPlanListOperator,
    this.period,
    this.priceWithTax,
    this.priceWithoutTax,
    this.title,
    this.durationInHours,
  });

  int? dataPlanType;
  dynamic fddAndTdd;
  int? id;
  int? dataPlanListOperator;
  int? period;
  int? priceWithTax;
  int? priceWithoutTax;
  String? title;
  int? durationInHours;

  factory DataPlanList.fromJson(Map<String, dynamic> json) => DataPlanList(
        dataPlanType: json['data_plan_type'],
        fddAndTdd: json['fdd_and_tdd'],
        id: json['id'],
        dataPlanListOperator: json['operator'],
        period: json['period'],
        priceWithTax: json['price_with_tax'],
        priceWithoutTax: json['price_without_tax'],
        title: json['title'],
        durationInHours: json['duration_in_hours'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data_plan_type': dataPlanType,
        'fdd_and_tdd': fddAndTdd,
        'id': id,
        'operator': dataPlanListOperator,
        'period': period,
        'price_with_tax': priceWithTax,
        'price_without_tax': priceWithoutTax,
        'title': title,
        'duration_in_hours': durationInHours,
      };
}
