import 'dart:convert';

import '../../common/error_response_data.dart';

CardBalanceResponseModel cardBalanceResponseModelFromJson(String str) =>
    CardBalanceResponseModel.fromJson(json.decode(str));

class CardBalanceResponseModel {
  CardBalanceResponseModel({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CardBalanceResponseModel.fromJson(Map<String, dynamic> json) => CardBalanceResponseModel(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.manaId,
    this.description,
    this.responseCode,
    this.result,
    this.status,
  });

  String? manaId;
  String? description;
  String? responseCode;
  Result? result;
  bool? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        manaId: json['manaId'],
        description: json['description'],
        responseCode: json['responseCode'],
        result: json['result'] == null ? null : Result.fromJson(json['result']),
        status: json['status'],
      );
}

class Result {
  Result({
    this.availableBalance,
    this.consumableBalance,
    this.responseCode,
    this.rrn,
    this.stan,
  });

  String? availableBalance;
  String? consumableBalance;
  int? responseCode;
  String? rrn;
  String? stan;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        availableBalance: json['availableBalance'],
        consumableBalance: json['consumableBalance'],
        responseCode: json['responseCode'],
        rrn: json['rrn'],
        stan: json['stan'],
      );
}
