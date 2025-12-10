import 'dart:convert';

import '../../common/error_response_data.dart';

AuthorizedApiTokenResponse authorizedApiTokenResponseFromJson(String str) =>
    AuthorizedApiTokenResponse.fromJson(json.decode(str));

String authorizedApiTokenResponseToJson(AuthorizedApiTokenResponse data) => json.encode(data.toJson());

class AuthorizedApiTokenResponse {
  AuthorizedApiTokenResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory AuthorizedApiTokenResponse.fromJson(Map<String, dynamic> json) => AuthorizedApiTokenResponse(
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
    this.errors,
    this.message,
    this.orderId,
    this.registrationDate,
    this.status,
    this.token,
    this.trackingNumber,
    this.transactionId,
    this.digitalBankingCustomer,
    this.tokenExpiryDate,
  });

  dynamic errors;
  String? message;
  String? orderId;
  int? registrationDate;
  int? status;
  String? token;
  String? trackingNumber;
  String? transactionId;
  bool? digitalBankingCustomer;
  int? tokenExpiryDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        errors: json['errors'],
        message: json['message'],
        orderId: json['orderId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        token: json['token'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        digitalBankingCustomer: json['digitalBankingCustomer'],
        tokenExpiryDate: json['tokenExpiryDate'],
      );

  Map<String, dynamic> toJson() => {
        'errors': errors,
        'message': message,
        'orderId': orderId,
        'registrationDate': registrationDate,
        'status': status,
        'token': token,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'digitalBankingCustomer': digitalBankingCustomer,
        'tokenExpiryDate': tokenExpiryDate,
      };
}
