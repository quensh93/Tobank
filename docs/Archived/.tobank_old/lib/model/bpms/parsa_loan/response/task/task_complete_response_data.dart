// To parse this JSON data, do
//
//     final taskCompleteResponseData = taskCompleteResponseDataFromJson(jsonString);

import 'dart:convert';

import 'process_state_response_data.dart';

TaskCompleteResponseData taskCompleteResponseDataFromJson(String str) =>
    TaskCompleteResponseData.fromJson(json.decode(str));

String taskCompleteResponseDataToJson(TaskCompleteResponseData data) => json.encode(data.toJson());

class TaskCompleteResponseData {
  String? message;
  bool? success;
  Data? data;

  TaskCompleteResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory TaskCompleteResponseData.fromJson(Map<String, dynamic> json) => TaskCompleteResponseData(
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
  String? transactionId;
  int? registrationDate;
  String? status;
  String? message;
  dynamic errors;
  dynamic extraData;
  List<TaskList>? taskList;

  Data({
    this.trackingNumber,
    this.transactionId,
    this.registrationDate,
    this.status,
    this.message,
    this.errors,
    this.extraData,
    this.taskList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        extraData: json['extraData'],
        taskList:
            json['taskList'] == null ? [] : List<TaskList>.from(json['taskList']!.map((x) => TaskList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'extraData': extraData,
        'taskList': taskList == null ? [] : List<dynamic>.from(taskList!.map((x) => x.toJson())),
      };
}
