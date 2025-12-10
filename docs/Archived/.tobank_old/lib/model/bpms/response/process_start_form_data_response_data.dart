import 'dart:convert';

import '../../common/error_response_data.dart';
import '../enum_value_data.dart';

ProcessStartFormDataResponse processStartFormDataResponseFromJson(String str) =>
    ProcessStartFormDataResponse.fromJson(json.decode(str));

String processStartFormDataResponseToJson(ProcessStartFormDataResponse data) => json.encode(data.toJson());

class ProcessStartFormDataResponse {
  ProcessStartFormDataResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory ProcessStartFormDataResponse.fromJson(Map<String, dynamic> json) => ProcessStartFormDataResponse(
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
  List<FormField>? formFields;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        formFields: json['formFields'] == null
            ? null
            : List<FormField>.from(json['formFields'].map((x) => FormField.fromJson(x))),
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

class FormField {
  FormField({
    this.id,
    this.label,
    this.type,
    this.value,
    this.properties,
    this.enumValues,
  });

  String? id;
  String? label;
  String? type;
  Value? value;
  Properties? properties;
  List<EnumValue>? enumValues;

  factory FormField.fromJson(Map<String, dynamic> json) => FormField(
        id: json['id'],
        label: json['label'],
        value: json['value'] == null ? null : Value.fromJson(json['value']),
        properties: json['properties'] == null ? null : Properties.fromJson(json['properties']),
        type: json['type'],
        enumValues: json['enumValues'] == null
            ? null
            : (json['enumValues'] as Map<String, dynamic>)
                .entries
                .map((enumValue) => EnumValue(key: enumValue.key, title: enumValue.value))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'type': type,
        'value': value?.toJson(),
        'properties': properties?.toJson(),
        'enumValues': enumValues == null ? null : {for (final element in enumValues!) element.key: element.title},
      };
}

class Properties {
  Properties();

  factory Properties.fromJson(Map<String, dynamic> json) => Properties();

  Map<String, dynamic> toJson() => {};
}

class Value {
  Value({
    this.value,
    this.type,
    this.transient,
  });

  dynamic value;
  ValueType? type;
  bool? transient;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        value: json['value'],
        type: json['type'] == null ? null : ValueType.fromJson(json['type']),
        transient: json['transient'],
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'type': type?.toJson(),
        'transient': transient,
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
