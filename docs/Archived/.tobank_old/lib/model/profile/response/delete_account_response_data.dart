import 'dart:convert';

import '../../common/error_response_data.dart';

DeleteAccountResponseData deleteAccountResponseDataFromJson(String str) =>
    DeleteAccountResponseData.fromJson(json.decode(str));

String deleteAccountResponseDataToJson(DeleteAccountResponseData data) => json.encode(data.toJson());

class DeleteAccountResponseData {
  DeleteAccountResponseData({
    this.data,
    this.message,
    this.success,
  });

  List<dynamic>? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory DeleteAccountResponseData.fromJson(Map<String, dynamic> json) => DeleteAccountResponseData(
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
