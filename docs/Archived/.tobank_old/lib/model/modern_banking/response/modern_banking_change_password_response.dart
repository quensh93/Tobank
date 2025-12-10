import 'dart:convert';

import '../../common/error_response_data.dart';

ModernBankingChangePasswordResponse modernBankingChangePasswordResponseFromJson(
        String str) =>
    ModernBankingChangePasswordResponse.fromJson(json.decode(str));

String modernBankingChangePasswordResponseToJson(
        ModernBankingChangePasswordResponse data) =>
    json.encode(data.toJson());

class ModernBankingChangePasswordResponse {
  ModernBankingChangePasswordResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory ModernBankingChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ModernBankingChangePasswordResponse(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.status,
    this.trackingNumber,
    this.transactionId,
  });

  int? status;
  String? trackingNumber;
  String? transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
      );

  Map<String, dynamic> toJson() =>
      {
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
      };
}
