import 'dart:convert';

import '../../common/error_response_data.dart';

CustomerClubWebViewResponseData customerClubWebViewResponseDataFromJson(String str) =>
    CustomerClubWebViewResponseData.fromJson(json.decode(str));

String customerClubWebViewResponseDataToJson(CustomerClubWebViewResponseData data) => json.encode(data.toJson());

class CustomerClubWebViewResponseData {
  CustomerClubWebViewResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory CustomerClubWebViewResponseData.fromJson(Map<String, dynamic> json) => CustomerClubWebViewResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.link,
  });

  String? link;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        link: json['link'],
      );

  Map<String, dynamic> toJson() => {
        'link': link,
      };
}
