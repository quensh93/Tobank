import 'dart:convert';

import '../../common/error_response_data.dart';

AutomaticDynamicPinTransferResponse automaticDynamicPinTransferResponseFromJson(String str) =>
    AutomaticDynamicPinTransferResponse.fromJson(json.decode(str));

String automaticDynamicPinTransferResponseToJson(AutomaticDynamicPinTransferResponse data) =>
    json.encode(data.toJson());

class AutomaticDynamicPinTransferResponse {
  AutomaticDynamicPinTransferResponse({
    this.data,
    this.success,
    this.message,
  });

  TransferData? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory AutomaticDynamicPinTransferResponse.fromJson(Map<String, dynamic> json) =>
      AutomaticDynamicPinTransferResponse(
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

class TransferData {
  TransferData({
    this.mobileNumber,
    this.otpTimeout,
    this.otp,
  });

  String? mobileNumber;
  String? otpTimeout;
  String? otp;

  factory TransferData.fromJson(Map<String, dynamic> json) => TransferData(
        mobileNumber: json['mobileNumber'],
        otpTimeout: json['otpTimeout'],
        otp: json['otp'],
      );

  Map<String, dynamic> toJson() =>
      {
        'mobileNumber': mobileNumber,
        'otpTimeout': otpTimeout,
        'otp': otp,
      };
}
