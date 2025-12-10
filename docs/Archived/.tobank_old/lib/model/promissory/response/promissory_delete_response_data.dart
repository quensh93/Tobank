import 'dart:convert';

import '../../common/error_response_data.dart';

PromissoryDeleteResponseData promissoryDeleteResponseDataFromJson(String str) =>
    PromissoryDeleteResponseData.fromJson(json.decode(str));

String promissoryDeleteResponseDataToJson(PromissoryDeleteResponseData data) => json.encode(data.toJson());

class PromissoryDeleteResponseData {
  PromissoryDeleteResponseData({
    this.message,
    this.success,
  });

  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissoryDeleteResponseData.fromJson(Map<String, dynamic> json) => PromissoryDeleteResponseData(
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
      };
}
