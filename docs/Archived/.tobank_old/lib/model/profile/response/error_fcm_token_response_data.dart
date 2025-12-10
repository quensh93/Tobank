import '../../../service/core/api_error_response_model.dart';

class ErrorFcmTokenResponseData extends ApiErrorResponseModel {
  ErrorFcmTokenResponseData({
    this.message,
    this.code,
    this.success,
  });

  String? message;
  int? code;
  bool? success;

  factory ErrorFcmTokenResponseData.fromJson(Map<String, dynamic> json) => ErrorFcmTokenResponseData(
        message: json['message'],
        code: json['code'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'success': success,
      };

  @override
  String? parseErrorMessage() {
    return message;
  }
}
