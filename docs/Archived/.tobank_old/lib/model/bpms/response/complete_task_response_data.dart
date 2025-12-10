import 'dart:convert';

import '../../common/error_response_data.dart';

CompleteTaskResponse completeTaskResponseFromJson(String str) => CompleteTaskResponse.fromJson(json.decode(str));

String completeTaskResponseToJson(CompleteTaskResponse data) => json.encode(data.toJson());

class CompleteTaskResponse {
  CompleteTaskResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CompleteTaskResponse.fromJson(Map<String, dynamic> json) => CompleteTaskResponse(
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
  });

  String? trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  String? processInstanceId;
  String? businessKey;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        processInstanceId: json['processInstanceId'],
        businessKey: json['businessKey'],
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
      };
}
