import 'dart:convert';

import '../../service/core/api_error_response_model.dart';

ErrorResponseData errorResponseDataFromJson(String str) => ErrorResponseData.fromJson(json.decode(str));

String errorResponseDataToJson(ErrorResponseData data) => json.encode(data.toJson());

class ErrorResponseData extends ApiErrorResponseModel {
  ErrorResponseData({
    this.message,
    this.success,
  });

  String? message;
  bool? success;

  factory ErrorResponseData.fromJson(Map<String, dynamic> json) => ErrorResponseData(
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
      };

  @override
  String? parseErrorMessage() {
    return message;
  }
}
