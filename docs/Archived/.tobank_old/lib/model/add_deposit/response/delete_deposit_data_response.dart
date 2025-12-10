import 'dart:convert';

import '../../common/error_response_data.dart';

DeleteDepositDataResponse deleteDepositDataResponseFromJson(String str) =>
    DeleteDepositDataResponse.fromJson(json.decode(str));

String deleteDepositDataResponseToJson(DeleteDepositDataResponse data) => json.encode(data.toJson());

class DeleteDepositDataResponse {
  DeleteDepositDataResponse({
    this.data,
    this.message,
    this.success,
  });

  List<dynamic>? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory DeleteDepositDataResponse.fromJson(Map<String, dynamic> json) => DeleteDepositDataResponse(
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
