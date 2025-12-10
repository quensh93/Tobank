import 'dart:convert';

import '../../common/error_response_data.dart';

ApplicantTaskListResponse applicantTaskListResponseFromJson(String str) =>
    ApplicantTaskListResponse.fromJson(json.decode(str));

String applicantTaskListResponseToJson(ApplicantTaskListResponse data) => json.encode(data.toJson());

class ApplicantTaskListResponse {
  ApplicantTaskListResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory ApplicantTaskListResponse.fromJson(Map<String, dynamic> json) => ApplicantTaskListResponse(
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
    this.taskList,
  });

  dynamic trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  List<Task>? taskList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        taskList: json['taskList'] == null ? null : List<Task>.from(json['taskList'].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'taskList': taskList == null ? null : List<dynamic>.from(taskList!.map((x) => x.toJson())),
      };
}

class Task {
  Task({
    this.id,
    this.assignee,
    this.name,
    this.description,
    this.createTime,
    this.dueDate,
    this.followUpDate,
    this.executionId,
    this.processInstanceId,
    this.processDefinitionId,
    this.taskDefinitionKey,
    this.isDeleted,
    this.deleteReason,
    this.formKey,
    this.variables,
  });

  String? id;
  String? assignee;
  String? name;
  dynamic description;
  int? createTime;
  dynamic dueDate;
  dynamic followUpDate;
  String? executionId;
  String? processInstanceId;
  String? processDefinitionId;
  String? taskDefinitionKey;
  bool? isDeleted;
  dynamic deleteReason;
  dynamic formKey;
  dynamic variables;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        assignee: json['assignee'],
        name: json['name'],
        description: json['description'],
        createTime: json['createTime'],
        dueDate: json['dueDate'],
        followUpDate: json['followUpDate'],
        executionId: json['executionId'],
        processInstanceId: json['processInstanceId'],
        processDefinitionId: json['processDefinitionId'],
        taskDefinitionKey: json['taskDefinitionKey'],
        isDeleted: json['isDeleted'],
        deleteReason: json['deleteReason'],
        formKey: json['formKey'],
        variables: json['variables'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'assignee': assignee,
        'name': name,
        'description': description,
        'createTime': createTime,
        'dueDate': dueDate,
        'followUpDate': followUpDate,
        'executionId': executionId,
        'processInstanceId': processInstanceId,
        'processDefinitionId': processDefinitionId,
        'taskDefinitionKey': taskDefinitionKey,
        'isDeleted': isDeleted,
        'deleteReason': deleteReason,
        'formKey': formKey,
        'variables': variables,
      };
}
