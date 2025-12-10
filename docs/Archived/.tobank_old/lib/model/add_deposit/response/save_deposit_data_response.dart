import 'dart:convert';

import '../../common/error_response_data.dart';

SaveDepositDataResponse saveDepositDataResponseFromJson(String str) =>
    SaveDepositDataResponse.fromJson(json.decode(str));

String saveDepositDataResponseToJson(SaveDepositDataResponse data) => json.encode(data.toJson());

class SaveDepositDataResponse {
  SaveDepositDataResponse({
    this.data,
    this.message,
    this.success,
  });

  List<dynamic>? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory SaveDepositDataResponse.fromJson(Map<String, dynamic> json) => SaveDepositDataResponse(
        data: json['data'] == null ? null : List<dynamic>.from(json['data'].map((x) => x)),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? null : List<dynamic>.from(data!.map((x) => x)),
        'message': message,
        'success': success,
      };
}
