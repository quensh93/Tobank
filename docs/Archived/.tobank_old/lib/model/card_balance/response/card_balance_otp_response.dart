import '../../common/error_response_data.dart';

class CardBalanceOTPResponseModel {
  CardBalanceOTPResponseModel({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory CardBalanceOTPResponseModel.fromJson(Map<String, dynamic> json) => CardBalanceOTPResponseModel(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.description,
    this.responseCode,
    this.result,
    this.status,
  });

  String? description;
  String? responseCode;
  DataResult? result;
  bool? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        description: json['description'],
        responseCode: json['responseCode'],
        result: json['result'] == null ? null : DataResult.fromJson(json['result']),
        status: json['status'],
      );
}

class DataResult {
  DataResult({
    this.errors,
    this.result,
    this.success,
  });

  dynamic errors;
  ResultResult? result;
  bool? success;

  factory DataResult.fromJson(Map<String, dynamic> json) => DataResult(
        errors: json['errors'],
        result: json['result'] == null ? null : ResultResult.fromJson(json['result']),
        success: json['success'],
      );
}

class ResultResult {
  ResultResult({
    this.correlationId,
    this.trace,
  });

  String? correlationId;
  String? trace;

  factory ResultResult.fromJson(Map<String, dynamic> json) => ResultResult(
        correlationId: json['correlationId'],
        trace: json['trace'],
      );
}
