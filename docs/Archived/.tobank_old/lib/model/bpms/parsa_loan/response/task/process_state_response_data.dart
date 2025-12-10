// To parse this JSON data, do
//
//     final processStateResponseData = processStateResponseDataFromJson(jsonString);

import 'dart:convert';

ProcessStateResponseData processStateResponseDataFromJson(String str) =>
    ProcessStateResponseData.fromJson(json.decode(str));

String processStateResponseDataToJson(ProcessStateResponseData data) => json.encode(data.toJson());

class ProcessStateResponseData {
  String? message;
  bool? success;
  Data? data;

  ProcessStateResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory ProcessStateResponseData.fromJson(Map<String, dynamic> json) => ProcessStateResponseData(
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
  String? state;
  List<TaskList>? taskList;

  Data({
    this.state,
    this.taskList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        state: json['state'],
        taskList:
            json['taskList'] == null ? [] : List<TaskList>.from(json['taskList']!.map((x) => TaskList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'state': state,
        'taskList': taskList == null ? [] : List<dynamic>.from(taskList!.map((x) => x.toJson())),
      };
}

class TaskList {
  int? id;
  String? name;
  String? key;
  String? description;
  int? processId;
  String? processKey;
  String? processName;
  int? type;
  String? typeName;
  List<MetaDatum>? metaData;
  dynamic extraData;
  int? dueDate;
  DateTime? createdAt;

  TaskList({
    this.id,
    this.name,
    this.key,
    this.description,
    this.processId,
    this.processKey,
    this.processName,
    this.type,
    this.typeName,
    this.metaData,
    this.extraData,
    this.dueDate,
    this.createdAt,
  });

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
        id: json['id'],
        name: json['name'],
        key: json['key'],
        description: json['description'],
        processId: json['processId'],
        processKey: json['processKey'],
        processName: json['processName'],
        type: json['type'],
        typeName: json['typeName'],
        metaData:
            json['metaData'] == null ? [] : List<MetaDatum>.from(json['metaData']!.map((x) => MetaDatum.fromJson(x))),
        extraData: json['extraData'],
        dueDate: json['dueDate'],
        createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'key': key,
        'description': description,
        'processId': processId,
        'processKey': processKey,
        'processName': processName,
        'type': type,
        'typeName': typeName,
        'metaData': metaData == null ? [] : List<dynamic>.from(metaData!.map((x) => x.toJson())),
        'extraData': extraData,
        'dueDate': dueDate,
        'createdAt': createdAt?.toIso8601String(),
      };
}

class MetaDatum {
  String? name;
  String? value;
  String? valueExp;
  String? type;
  dynamic conditions;
  List<String>? tags;
  List<dynamic>? enums;
  String? description;

  MetaDatum({
    this.name,
    this.value,
    this.valueExp,
    this.type,
    this.conditions,
    this.tags,
    this.enums,
    this.description,
  });

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        name: json['name'],
        value: json['value'],
        valueExp: json['valueExp'],
        type: json['type'],
        conditions: json['conditions'],
        tags: json['tags'] == null ? [] : List<String>.from(json['tags']!.map((x) => x)),
        enums: json['enums'] == null ? [] : List<dynamic>.from(json['enums']!.map((x) => x)),
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
        'valueExp': valueExp,
        'type': type,
        'conditions': conditions,
        'tags': tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        'enums': enums == null ? [] : List<dynamic>.from(enums!.map((x) => x)),
        'description': description,
      };
}
