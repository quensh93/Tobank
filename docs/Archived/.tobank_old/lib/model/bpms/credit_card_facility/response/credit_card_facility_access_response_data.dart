import 'dart:convert';

import '../../../common/error_response_data.dart';

CreditCardFacilityAccessResponseData creditCardFacilityAccessResponseDataFromJson(String str) =>
    CreditCardFacilityAccessResponseData.fromJson(json.decode(str));

String creditCardFacilityAccessResponseDataToJson(CreditCardFacilityAccessResponseData data) =>
    json.encode(data.toJson());

class CreditCardFacilityAccessResponseData {
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  CreditCardFacilityAccessResponseData({
    this.success,
    this.message,
  });

  factory CreditCardFacilityAccessResponseData.fromJson(Map<String, dynamic> json) =>
      CreditCardFacilityAccessResponseData(
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
