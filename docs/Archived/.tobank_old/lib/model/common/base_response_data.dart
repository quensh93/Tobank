import 'dart:convert';

BaseResponseData baseResponseDataFromJson(String str) => BaseResponseData.fromJson(json.decode(str));

String baseResponseDataToJson(BaseResponseData data) => json.encode(data.toJson());

class BaseResponseData {
  BaseResponseData({
    this.message,
    this.success,
  });

  String? message;
  bool? success;

  factory BaseResponseData.fromJson(Map<String, dynamic> json) => BaseResponseData(
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
      };
}
