import 'dart:convert';

import '../../common/error_response_data.dart';

CustomerReferralsResponse customerReferralsResponseFromJson(String str) =>
    CustomerReferralsResponse.fromJson(json.decode(str));

String customerReferralsResponseToJson(CustomerReferralsResponse data) =>
    json.encode(data.toJson());

class CustomerReferralsResponse {
  CustomerReferralsResponse({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CustomerReferralsResponse.fromJson(Map<String, dynamic> json) => CustomerReferralsResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
      };
}

class Data {
  Data({
    this.trackingNumber,
    this.transactionId,
    this.registrationDate,
    this.status,
    this.message,
    this.errors,
    this.referrals,
  });

  String? trackingNumber;
  dynamic transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  List<Referral>? referrals;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        referrals:
            json['referrals'] == null ? null : List<Referral>.from(json['referrals'].map((x) => Referral.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'referrals': referrals == null ? null : List<dynamic>.from(referrals!.map((x) => x.toJson())),
      };
}

class Referral {
  Referral({
    this.nationalCode,
    this.firstName,
    this.lastName,
    this.gender,
    this.customerNumber,
    this.shahabCodeAcquired,
    this.loyaltyCode,
    this.customerStatus,
    this.referenceDate,
    this.rewardAmount,
  });

  String? nationalCode;
  String? firstName;
  String? lastName;
  int? gender;
  String? customerNumber;
  bool? shahabCodeAcquired;
  String? loyaltyCode;
  int? customerStatus;
  int? referenceDate;
  String? rewardAmount;

  factory Referral.fromJson(Map<String, dynamic> json) => Referral(
        nationalCode: json['nationalCode'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        customerNumber: json['customerNumber'],
        shahabCodeAcquired: json['shahabCodeAcquired'],
        loyaltyCode: json['loyaltyCode'],
        customerStatus: json['customerStatus'],
        referenceDate: json['referenceDate'],
        rewardAmount: json['rewardAmount'],
      );

  Map<String, dynamic> toJson() =>
      {
        'nationalCode': nationalCode,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'customerNumber': customerNumber,
        'shahabCodeAcquired': shahabCodeAcquired,
        'loyaltyCode': loyaltyCode,
        'customerStatus': customerStatus,
        'referenceDate': referenceDate,
        'rewardAmount': rewardAmount,
      };
}
