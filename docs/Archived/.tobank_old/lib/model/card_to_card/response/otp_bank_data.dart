import 'dart:convert';

OtpBankResponse otpBankResponseFromJson(String str) => OtpBankResponse.fromJson(json.decode(str));

String otpBankResponseToJson(OtpBankResponse data) => json.encode(data.toJson());

class OtpBankResponse {
  OtpBankResponse({
    this.msg,
    this.success,
  });

  String? msg;
  bool? success;
  int? statusCode;

  factory OtpBankResponse.fromJson(Map<String, dynamic> json) => OtpBankResponse(
        msg: json['msg'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'msg': msg,
        'success': success,
      };
}
