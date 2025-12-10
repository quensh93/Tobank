// To parse this JSON data, do
//
//     final startProcessResponseData = startProcessResponseDataFromJson(jsonString);

import 'dart:convert';

import 'process_state_response_data.dart';

ParsaLendingStartProcessResponseData startProcessResponseDataFromJson(String str) =>
    ParsaLendingStartProcessResponseData.fromJson(json.decode(str));

String startProcessResponseDataToJson(ParsaLendingStartProcessResponseData data) => json.encode(data.toJson());

class ParsaLendingStartProcessResponseData {
  String? message;
  bool? success;
  Data? data;

  ParsaLendingStartProcessResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory ParsaLendingStartProcessResponseData.fromJson(Map<String, dynamic> json) =>
      ParsaLendingStartProcessResponseData(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  String? trackingNumber;
  List<TaskList>? taskList;
  dynamic extraData;

  Data({
    this.trackingNumber,
    this.taskList,
    this.extraData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        taskList:
            json['taskList'] == null ? [] : List<TaskList>.from(json['taskList']!.map((x) => TaskList.fromJson(x))),
        extraData: json['extraData'],
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'taskList': taskList == null ? [] : List<dynamic>.from(taskList!.map((x) => x.toJson())),
        'extraData': extraData,
      };
}
