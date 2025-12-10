import 'dart:convert';

import '../../common/error_response_data.dart';
import 'applicant_task_list_response_data.dart';

StartProcessResponse startProcessResponseFromJson(String str) => StartProcessResponse.fromJson(json.decode(str));

String startProcessResponseToJson(StartProcessResponse data) => json.encode(data.toJson());

class StartProcessResponse {
  StartProcessResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory StartProcessResponse.fromJson(Map<String, dynamic> json) => StartProcessResponse(
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
    this.trackingNumber,
    this.transactionId,
    this.registrationDate,
    this.status,
    this.message,
    this.errors,
    this.processInstanceId,
    this.businessKey,
    this.taskList,
  });

  String? trackingNumber;
  dynamic transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  String? processInstanceId;
  String? businessKey;
  List<Task>? taskList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        processInstanceId: json['processInstanceId'],
        businessKey: json['businessKey'],
        taskList: json['taskList'] == null ? [] : List<Task>.from(json['taskList']!.map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'processInstanceId': processInstanceId,
        'businessKey': businessKey,
        'taskList': taskList == null ? [] : List<dynamic>.from(taskList!.map((x) => x.toJson())),
      };
}
