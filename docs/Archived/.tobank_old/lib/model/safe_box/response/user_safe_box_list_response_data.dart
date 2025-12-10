import 'dart:convert';

import '../../common/error_response_data.dart';

UserSafeBoxListResponseData userSafeBoxListResponseDataFromJson(String str) =>
    UserSafeBoxListResponseData.fromJson(json.decode(str));

String userSafeBoxListResponseDataToJson(UserSafeBoxListResponseData data) => json.encode(data.toJson());

class UserSafeBoxListResponseData {
  UserSafeBoxListResponseData({
    this.data,
    this.message,
    this.success,
  });

  List<SafeBoxData>? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory UserSafeBoxListResponseData.fromJson(Map<String, dynamic> json) => UserSafeBoxListResponseData(
        data: json['data'] == null ? null : List<SafeBoxData>.from(json['data'].map((x) => SafeBoxData.fromJson(x))),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
        'success': success,
      };
}

class SafeBoxData {
  SafeBoxData({
    this.confirmationDate,
    this.createdAt,
    this.fund,
    this.id,
    this.referDate,
    this.status,
    this.statusFa,
    this.trackingCode,
    this.updatedAt,
    this.user,
  });

  dynamic confirmationDate;
  DateTime? createdAt;
  Fund? fund;
  int? id;
  ReferDate? referDate;
  String? status;
  String? statusFa;
  int? trackingCode;
  DateTime? updatedAt;
  int? user;

  factory SafeBoxData.fromJson(Map<String, dynamic> json) => SafeBoxData(
        confirmationDate: json['confirmation_date'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        fund: json['fund'] == null ? null : Fund.fromJson(json['fund']),
        id: json['id'],
        referDate: json['refer_date'] == null ? null : ReferDate.fromJson(json['refer_date']),
        status: json['status'],
        statusFa: json['status_fa'],
        trackingCode: json['tracking_code'],
        updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
        user: json['user'],
      );

  Map<String, dynamic> toJson() => {
        'confirmation_date': confirmationDate,
        'created_at': createdAt?.toIso8601String(),
        'fund': fund?.toJson(),
        'id': id,
        'refer_date': referDate?.toJson(),
        'status': status,
        'status_fa': statusFa,
        'tracking_code': trackingCode,
        'updated_at': updatedAt?.toIso8601String(),
        'user': user,
      };
}

class Fund {
  Fund({
    this.branch,
    this.code,
    this.count,
    this.createdAt,
    this.fee,
    this.id,
    this.isActive,
    this.paymentAmount,
    this.rent,
    this.title,
    this.trust,
    this.type,
    this.updatedAt,
    this.volume,
  });

  Branch? branch;
  int? code;
  int? count;
  DateTime? createdAt;
  int? fee;
  int? id;
  bool? isActive;
  int? paymentAmount;
  int? rent;
  String? title;
  int? trust;
  Type? type;
  DateTime? updatedAt;
  String? volume;

  factory Fund.fromJson(Map<String, dynamic> json) => Fund(
        branch: json['branch'] == null ? null : Branch.fromJson(json['branch']),
        code: json['code'],
        count: json['count'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        fee: json['fee'],
        id: json['id'],
        isActive: json['is_active'],
        paymentAmount: json['payment_amount'],
        rent: json['rent'],
        title: json['title'],
        trust: json['trust'],
        type: json['type'] == null ? null : Type.fromJson(json['type']),
        updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
        volume: json['volume'],
      );

  Map<String, dynamic> toJson() => {
        'branch': branch?.toJson(),
        'code': code,
        'count': count,
        'created_at': createdAt?.toIso8601String(),
        'fee': fee,
        'id': id,
        'is_active': isActive,
        'payment_amount': paymentAmount,
        'rent': rent,
        'title': title,
        'trust': trust,
        'type': type?.toJson(),
        'updated_at': updatedAt?.toIso8601String(),
        'volume': volume,
      };
}

class Branch {
  Branch({
    this.address,
    this.city,
    this.code,
    this.createdAt,
    this.id,
    this.isActive,
    this.phone,
    this.title,
  });

  String? address;
  City? city;
  int? code;
  DateTime? createdAt;
  int? id;
  bool? isActive;
  String? phone;
  String? title;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        address: json['address'],
        city: json['city'] == null ? null : City.fromJson(json['city']),
        code: json['code'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        id: json['id'],
        isActive: json['is_active'],
        phone: json['phone'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'city': city?.toJson(),
        'code': code,
        'created_at': createdAt?.toIso8601String(),
        'id': id,
        'is_active': isActive,
        'phone': phone,
        'title': title,
      };
}

class City {
  City({
    this.depositFundSupport,
    this.id,
    this.name,
    this.province,
  });

  bool? depositFundSupport;
  int? id;
  String? name;
  Province? province;

  factory City.fromJson(Map<String, dynamic> json) => City(
        depositFundSupport: json['deposit_fund_support'],
        id: json['id'],
        name: json['name'],
        province: json['province'] == null ? null : Province.fromJson(json['province']),
      );

  Map<String, dynamic> toJson() => {
        'deposit_fund_support': depositFundSupport,
        'id': id,
        'name': name,
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

class Type {
  Type({
    this.id,
    this.title,
    this.titleFa,
  });

  int? id;
  String? title;
  String? titleFa;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json['id'],
        title: json['title'],
        titleFa: json['title_fa'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'title_fa': titleFa,
      };
}

class ReferDate {
  ReferDate({
    this.createdAt,
    this.date,
    this.fromHour,
    this.id,
    this.isActive,
    this.toHour,
  });

  DateTime? createdAt;
  String? date;
  int? fromHour;
  int? id;
  bool? isActive;
  int? toHour;

  factory ReferDate.fromJson(Map<String, dynamic> json) => ReferDate(
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        date: json['date'],
        fromHour: json['from_hour'],
        id: json['id'],
        isActive: json['is_active'],
        toHour: json['to_hour'],
      );

  Map<String, dynamic> toJson() => {
        'created_at': createdAt?.toIso8601String(),
        'date': date,
        'from_hour': fromHour,
        'id': id,
        'is_active': isActive,
        'to_hour': toHour,
      };
}
