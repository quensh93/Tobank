import 'dart:convert';

import '../../../util/enums_constants.dart';
import '../../common/error_response_data.dart';

UpdateDepositDataResponse updateDepositDataResponseFromJson(String str) =>
    UpdateDepositDataResponse.fromJson(json.decode(str));

String updateDepositDataResponseToJson(UpdateDepositDataResponse data) => json.encode(data.toJson());

class UpdateDepositDataResponse {
  UpdateDepositDataResponse({
    this.data,
    this.message,
    this.success,
  });

  UpdateDepositDataModel? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory UpdateDepositDataResponse.fromJson(Map<String, dynamic> json) => UpdateDepositDataResponse(
        data: json['data'] == null ? null : UpdateDepositDataModel.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class UpdateDepositDataModel {
  UpdateDepositDataModel({
    this.id,
    this.title,
    this.iban,
    this.accountNumber,
    this.createdAt,
    this.type,
  });

  int? id;
  String? title;
  String? iban;
  String? accountNumber;
  String? createdAt;
  DestinationType? type;

  factory UpdateDepositDataModel.fromJson(Map<String, dynamic> json) => UpdateDepositDataModel(
        id: json['id'],
        title: json['title'],
        iban: json['iban'],
        accountNumber: json['account_number'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'iban': iban,
        'account_number': accountNumber,
        'created_at': createdAt,
      };
}
