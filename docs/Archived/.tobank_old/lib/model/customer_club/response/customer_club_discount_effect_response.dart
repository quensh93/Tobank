import 'dart:convert';

import '../../common/error_response_data.dart';

CustomerClubDiscountEffectResponse customerClubDiscountEffectResponseFromJson(String str) =>
    CustomerClubDiscountEffectResponse.fromJson(json.decode(str));

String customerClubDiscountEffectResponseToJson(CustomerClubDiscountEffectResponse data) => json.encode(data.toJson());

class CustomerClubDiscountEffectResponse {
  CustomerClubDiscountEffectResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory CustomerClubDiscountEffectResponse.fromJson(Map<String, dynamic> json) => CustomerClubDiscountEffectResponse(
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
    this.discount,
    this.discountPrsentage,
    this.lastAmount,
    this.lastPoint,
    this.newAmount,
    this.pointsLost,
    this.remainingPoints,
    this.wallet,
  });

  String? discount;
  String? discountPrsentage;
  int? lastAmount;
  String? lastPoint;
  int? newAmount;
  String? pointsLost;
  String? remainingPoints;
  int? wallet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        discount: json['discount'],
        discountPrsentage: json['discount_prsentage'],
        lastAmount: json['last_amount'],
        lastPoint: json['last_point'],
        newAmount: json['new_amount'],
        pointsLost: json['points_lost'],
        remainingPoints: json['remaining_points'],
        wallet: json['wallet'],
      );

  Map<String, dynamic> toJson() =>
      {
        'discount': discount,
        'discount_prsentage': discountPrsentage,
        'last_amount': lastAmount,
        'last_point': lastPoint,
        'new_amount': newAmount,
        'points_lost': pointsLost,
        'remaining_points': remainingPoints,
        'wallet': wallet,
      };
}
