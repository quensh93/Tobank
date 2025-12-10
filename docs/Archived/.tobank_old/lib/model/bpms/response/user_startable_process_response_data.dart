import 'dart:convert';

import '../../common/error_response_data.dart';

UserStartableProcessResponse userStartableProcessResponseFromJson(String str) =>
    UserStartableProcessResponse.fromJson(json.decode(str));

String userStartableProcessResponseToJson(UserStartableProcessResponse data) =>
    json.encode(data.toJson());

class UserStartableProcessResponse {
  UserStartableProcessResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory UserStartableProcessResponse.fromJson(Map<String, dynamic> json) => UserStartableProcessResponse(
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
    this.processDefinitions,
  });

  String? trackingNumber;
  dynamic transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  List<ProcessDefinitionData>? processDefinitions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        processDefinitions: json['processDefinitions'] == null
            ? null
            : List<ProcessDefinitionData>.from(
                json['processDefinitions'].map((x) => ProcessDefinitionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'processDefinitions': processDefinitions,
      };
}

class ProcessDefinitionData {
  ProcessDefinitionData({
    this.id,
    this.name,
    this.description,
    this.key,
    this.version,
    this.category,
    this.deploymentId,
    this.startFormDefinition,
    this.hasStartFormKey,
    this.versionTag,
  });

  String? id;
  String? name;
  String? description;
  String? key;
  int? version;
  String? category;
  String? deploymentId;
  dynamic startFormDefinition;
  bool? hasStartFormKey;
  String? versionTag;

  factory ProcessDefinitionData.fromJson(Map<String, dynamic> json) =>
      ProcessDefinitionData(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        key: json['key'],
        version: json['version'],
        category: json['category'],
        deploymentId: json['deploymentId'],
        startFormDefinition: json['startFormDefinition'],
        hasStartFormKey: json['hasStartFormKey'],
        versionTag: json['versionTag'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'description': description,
        'key': key,
        'version': version,
        'category': category,
        'deploymentId': deploymentId,
        'startFormDefinition': startFormDefinition,
        'hasStartFormKey': hasStartFormKey,
        'versionTag': versionTag,
      };
}
