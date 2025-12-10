import 'dart:convert';

import '../../common/error_response_data.dart';

AutomaticDynamicPinPreRegisterResponse automaticDynamicPinPreRegisterResponseFromJson(String str) =>
    AutomaticDynamicPinPreRegisterResponse.fromJson(json.decode(str));

String automaticDynamicPinPreRegisterResponseToJson(AutomaticDynamicPinPreRegisterResponse data) =>
    json.encode(data.toJson());

class AutomaticDynamicPinPreRegisterResponse {
  AutomaticDynamicPinPreRegisterResponse({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory AutomaticDynamicPinPreRegisterResponse.fromJson(Map<String, dynamic> json) =>
      AutomaticDynamicPinPreRegisterResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data?.toJson(),
        'success': success,
        'message': message,
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
