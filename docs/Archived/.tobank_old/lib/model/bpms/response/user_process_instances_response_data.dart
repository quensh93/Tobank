import 'dart:convert';

import '../../common/error_response_data.dart';

UserProcessInstancesResponse userProcessInstancesResponseFromJson(String str) =>
    UserProcessInstancesResponse.fromJson(json.decode(str));

String userProcessInstancesResponseToJson(UserProcessInstancesResponse data) =>
    json.encode(data.toJson());

class UserProcessInstancesResponse {
  UserProcessInstancesResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory UserProcessInstancesResponse.fromJson(Map<String, dynamic> json) => UserProcessInstancesResponse(
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

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.trackingNumber,
    this.transactionId,
    this.registrationDate,
    this.status,
    this.message,
    this.errors,
    this.processInstances,
  });

  dynamic trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  List<ProcessInstance>? processInstances;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        processInstances: json['processInstances'] == null
            ? null
            : List<ProcessInstance>.from(json['processInstances'].map((x) => ProcessInstance.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'processInstances':
            processInstances == null ? null : List<dynamic>.from(processInstances!.map((x) => x.toJson())),
      };
}

class ProcessInstance {
  ProcessInstance({
    this.id,
    this.eventType,
    this.startTime,
    this.endTime,
    this.processInstanceId,
    this.processDefinitionId,
    this.processDefinitionKey,
    this.processDefinitionVersion,
    this.processDefinitionName,
    this.businessKey,
    this.startUserId,
    this.state,
    this.variables,
  });

  String? id;
  dynamic eventType;
  int? startTime;
  dynamic endTime;
  String? processInstanceId;
  String? processDefinitionId;
  String? processDefinitionKey;
  int? processDefinitionVersion;
  String? processDefinitionName;
  String? businessKey;
  String? startUserId;
  String? state;
  dynamic variables;

  factory ProcessInstance.fromJson(Map<String, dynamic> json) =>
      ProcessInstance(
        id: json['id'],
        eventType: json['eventType'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        processInstanceId: json['processInstanceId'],
        processDefinitionId: json['processDefinitionId'],
        processDefinitionKey: json['processDefinitionKey'],
        processDefinitionVersion: json['processDefinitionVersion'],
        processDefinitionName: json['processDefinitionName'],
        businessKey: json['businessKey'],
        startUserId: json['startUserId'],
        state: json['state'],
        variables: json['variables'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'eventType': eventType,
        'startTime': startTime,
        'endTime': endTime,
        'processInstanceId': processInstanceId,
        'processDefinitionId': processDefinitionId,
        'processDefinitionKey': processDefinitionKey,
        'processDefinitionVersion': processDefinitionVersion,
        'processDefinitionName': processDefinitionName,
        'businessKey': businessKey,
        'startUserId': startUserId,
        'state': state,
        'variables': variables,
      };
}
