import 'dart:convert';

import '../../common/error_response_data.dart';
import '../enum_value_data.dart';

GetTaskDataResponse getTaskDataResponseFromJson(String str) => GetTaskDataResponse.fromJson(json.decode(str));

String getTaskDataResponseToJson(GetTaskDataResponse data) => json.encode(data.toJson());

class GetTaskDataResponse {
  GetTaskDataResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory GetTaskDataResponse.fromJson(Map<String, dynamic> json) => GetTaskDataResponse(
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
    this.formFields,
  });

  dynamic trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  List<TaskDataFormField>? formFields;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        formFields: json['formFields'] == null
            ? null
            : List<TaskDataFormField>.from(json['formFields'].map((x) => TaskDataFormField.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'formFields': formFields == null ? null : List<dynamic>.from(formFields!.map((x) => x.toJson())),
      };
}

class TaskDataFormField {
  TaskDataFormField({
    this.id,
    this.label,
    this.type,
    this.value,
    this.enumValues,
  });

  String? id;
  String? label;
  String? type;
  Value? value;
  List<EnumValue>? enumValues;

  factory TaskDataFormField.fromJson(Map<String, dynamic> json) => TaskDataFormField(
        id: json['id'],
        label: json['label'],
        type: json['type'],
        value: json['value'] == null ? null : Value.fromJson(json['value']),
        enumValues: json['enumValues'] == null
            ? null
            : (json['enumValues'] as Map<String, dynamic>)
                .entries
                .map((enumValue) => EnumValue(key: enumValue.key, title: enumValue.value))
                .toList(),
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'label': label,
        'type': type,
        'value': value?.toJson(),
        'enumValues': enumValues == null ? null : {for (final element in enumValues!) element.key: element.title},
      };
}

class Value {
  Value({
    this.subValue,
    this.type,
    this.transient,
  });

  dynamic subValue;
  ValueType? type;
  bool? transient;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        subValue: json['value'],
        type: json['type'] == null ? null : ValueType.fromJson(json['type']),
        transient: json['transient'],
      );

  Map<String, dynamic> toJson() => {
        'value': subValue,
        'type': type?.toJson(),
        'transient': transient,
      };
}

class SubValueDictionary {
  SubValueDictionary({
    this.additionalDocuments,
  });

  List<AdditionalDocument>? additionalDocuments;

  factory SubValueDictionary.fromJson(Map<String, dynamic> json) => SubValueDictionary(
        additionalDocuments: json['documents'] == null
            ? null
            : List<AdditionalDocument>.from(json['documents'].map((x) => AdditionalDocument.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'documents':
            additionalDocuments == null ? null : List<dynamic>.from(additionalDocuments!.map((x) => x.toJson())),
      };
}

class AdditionalDocument {
  AdditionalDocument({
    this.description,
    this.id,
    this.status,
    this.title,
  });

  dynamic description;
  String? id;
  int? status;
  String? title;
  int? index;

  factory AdditionalDocument.fromJson(Map<String, dynamic> json) => AdditionalDocument(
        description: json['description'],
        id: json['id'],
        status: json['status'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'id': id,
        'status': status,
        'title': title,
      };
}

class ValueType {
  ValueType({
    this.name,
    this.javaType,
    this.primitiveValueType,
    this.typeAbstract,
    this.parent,
  });

  String? name;
  String? javaType;
  bool? primitiveValueType;
  bool? typeAbstract;
  dynamic parent;

  factory ValueType.fromJson(Map<String, dynamic> json) => ValueType(
        name: json['name'],
        javaType: json['javaType'],
        primitiveValueType: json['primitiveValueType'],
        typeAbstract: json['abstract'],
        parent: json['parent'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'javaType': javaType,
        'primitiveValueType': primitiveValueType,
        'abstract': typeAbstract,
        'parent': parent,
      };
}
