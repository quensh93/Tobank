import 'dart:convert';

import 'error_fcm_token_response_data.dart';

FirebaseTokenResponse firebaseTokenResponseFromJson(String str) => FirebaseTokenResponse.fromJson(json.decode(str));

String firebaseTokenResponseToJson(FirebaseTokenResponse data) => json.encode(data.toJson());

class FirebaseTokenResponse {
  FirebaseTokenResponse({
    this.message,
    this.code,
    this.success,
  });

  String? message;
  int? code;
  bool? success;
  int? statusCode;
  late ErrorFcmTokenResponseData errorFcmTokenResponseData;

  factory FirebaseTokenResponse.fromJson(Map<String, dynamic> json) => FirebaseTokenResponse(
        message: json['message'],
        code: json['code'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'success': success,
      };
}
