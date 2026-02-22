import 'dart:convert';

SecureResponseData secureResponseDataFromJson(String str) =>
    SecureResponseData.fromJson(json.decode(str));

String secureResponseDataToJson(SecureResponseData data) =>
    json.encode(data.toJson());

class SecureResponseData {
  SecureResponseData({
    this.statusCode,
    this.data,
    this.message,
    this.isSuccess,
  });

  int? statusCode;
  String? data;
  String? message;
  bool? isSuccess;

  factory SecureResponseData.fromJson(Map<String, dynamic> json) =>
      SecureResponseData(
        statusCode: json['statusCode'],
        data: json['data'],
        message: json['message'],
        isSuccess: json['isSuccess'],
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'data': data,
        'message': message,
        'isSuccess': isSuccess,
      };
}
