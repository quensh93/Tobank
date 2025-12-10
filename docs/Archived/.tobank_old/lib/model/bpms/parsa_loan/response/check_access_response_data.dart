import 'dart:convert';

CheckAccessResponseData checkAccessResponseDataFromJson(String str) =>
    CheckAccessResponseData.fromJson(json.decode(str));

String checkAccessResponseDataToJson(CheckAccessResponseData data) => json.encode(data.toJson());

class CheckAccessResponseData {
  String? message;
  bool? success;
  Data? data;

  CheckAccessResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory CheckAccessResponseData.fromJson(Map<String, dynamic> json) => CheckAccessResponseData(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  bool? access;

  Data({
    this.access,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        access: json['access'],
      );

  Map<String, dynamic> toJson() => {
        'access': access,
      };
}
