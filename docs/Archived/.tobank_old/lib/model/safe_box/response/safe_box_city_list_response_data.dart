import 'dart:convert';

import '../../common/error_response_data.dart';

SafeBoxCityListResponseData safeBoxCityListResponseDataFromJson(String str) =>
    SafeBoxCityListResponseData.fromJson(json.decode(str));

String safeBoxCityListResponseDataToJson(SafeBoxCityListResponseData data) => json.encode(data.toJson());

class SafeBoxCityListResponseData {
  SafeBoxCityListResponseData({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<SafeBoxCityData>? data;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory SafeBoxCityListResponseData.fromJson(Map<String, dynamic> json) => SafeBoxCityListResponseData(
        success: json['success'],
        data: json['data'] == null
            ? null
            : List<SafeBoxCityData>.from(json['data'].map((x) => SafeBoxCityData.fromJson(x))),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
      };
}

class SafeBoxCityData {
  SafeBoxCityData({
    this.id,
    this.name,
    this.depositFundSupport,
    this.province,
  });

  int? id;
  String? name;
  bool? depositFundSupport;
  Province? province;

  factory SafeBoxCityData.fromJson(Map<String, dynamic> json) => SafeBoxCityData(
        id: json['id'],
        name: json['name'],
        depositFundSupport: json['deposit_fund_support'],
        province: json['province'] == null ? null : Province.fromJson(json['province']),
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'deposit_fund_support': depositFundSupport,
        'province': province?.toJson(),
      };
}

class Province {
  Province({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
