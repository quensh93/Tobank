import 'dart:convert';

import '../../common/error_response_data.dart';

CompleteGuarantorDeleteResponse completeGuarantorDeleteResponseFromJson(String str) =>
    CompleteGuarantorDeleteResponse.fromJson(json.decode(str));

String completeGuarantorDeleteResponseToJson(CompleteGuarantorDeleteResponse data) => json.encode(data.toJson());

class CompleteGuarantorDeleteResponse {
  CompleteGuarantorDeleteResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CompleteGuarantorDeleteResponse.fromJson(Map<String, dynamic> json) => CompleteGuarantorDeleteResponse(
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
  });

  String? trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
      };
}
