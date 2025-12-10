import 'dart:convert';

String automaticDynamicPinRegisterRequestToJson(AutomaticDynamicPinRegisterRequest data) => json.encode(data.toJson());

class AutomaticDynamicPinRegisterRequest {
  AutomaticDynamicPinRegisterRequest({
    required this.keyData,
    required this.otp,
    required this.mobile,
  });

  String keyData;
  String otp;
  String mobile;

  factory AutomaticDynamicPinRegisterRequest.fromJson(Map<String, dynamic> json) => AutomaticDynamicPinRegisterRequest(
        keyData: json['keyData'],
        otp: json['otp'],
        mobile: json['mobile'],
      );

  Map<String, dynamic> toJson() => {
        'keyData': keyData,
        'otp': otp,
        'mobile': mobile,
      };
}
