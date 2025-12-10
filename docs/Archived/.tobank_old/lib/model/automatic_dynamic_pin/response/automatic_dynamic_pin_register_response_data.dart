import 'dart:convert';

import '../../common/error_response_data.dart';

AutomaticDynamicPinRegisterResponse automaticDynamicPinRegisterResponseFromJson(String str) =>
    AutomaticDynamicPinRegisterResponse.fromJson(json.decode(str));

String automaticDynamicPinRegisterResponseToJson(AutomaticDynamicPinRegisterResponse data) =>
    json.encode(data.toJson());

class AutomaticDynamicPinRegisterResponse {
  AutomaticDynamicPinRegisterResponse({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory AutomaticDynamicPinRegisterResponse.fromJson(Map<String, dynamic> json) =>
      AutomaticDynamicPinRegisterResponse(
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
  Data({
    this.keyId,
  });

  String? keyId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    keyId: json['keyId'],
      );

  Map<String, dynamic> toJson() =>
      {
        'keyId': keyId,
      };
}
