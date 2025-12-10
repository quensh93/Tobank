import 'dart:convert';

import '../../common/error_response_data.dart';

UserVisitListResponseData userVisitListResponseDataFromJson(String str) =>
    UserVisitListResponseData.fromJson(json.decode(str));

String userVisitListResponseDataToJson(UserVisitListResponseData data) => json.encode(data.toJson());

class UserVisitListResponseData {
  UserVisitListResponseData({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory UserVisitListResponseData.fromJson(Map<String, dynamic> json) => UserVisitListResponseData(
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
      );

  Map<String, dynamic> toJson() =>
      {
        'success': success,
        'data': data?.toJson(),
        'message': message,
      };
}

class Data {
  Data({
    this.fund,
    this.referDate,
    this.confirmationDate,
    this.status,
    this.trackingCode,
    this.user,
    this.visitTimes,
  });

  Fund? fund;
  ReferDate? referDate;
  dynamic confirmationDate;
  String? status;
  dynamic trackingCode;
  dynamic user;
  List<VisitTime>? visitTimes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fund: json['fund'] == null ? null : Fund.fromJson(json['fund']),
        referDate: json['refer_date'] == null ? null : ReferDate.fromJson(json['refer_date']),
        confirmationDate: json['confirmation_date'],
        status: json['status'],
        trackingCode: json['tracking_code'],
        user: json['user'],
        visitTimes: json['visit_times'] == null
            ? null
            : List<VisitTime>.from(json['visit_times'].map((x) => VisitTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'fund': fund?.toJson(),
        'refer_date': referDate?.toJson(),
        'confirmation_date': confirmationDate,
        'status': status,
        'tracking_code': trackingCode,
        'user': user,
        'visit_times': visitTimes == null ? null : List<dynamic>.from(visitTimes!.map((x) => x.toJson())),
      };
}

class Fund {
  Fund({
    this.branch,
    this.type,
    this.title,
    this.code,
    this.volume,
    this.isActive,
    this.trust,
    this.fee,
    this.rent,
    this.count,
  });

  Branch? branch;
  Type? type;
  String? title;
  int? code;
  String? volume;
  bool? isActive;
  int? trust;
  int? fee;
  int? rent;
  int? count;

  factory Fund.fromJson(Map<String, dynamic> json) => Fund(
        branch: json['branch'] == null ? null : Branch.fromJson(json['branch']),
        type: json['type'] == null ? null : Type.fromJson(json['type']),
        title: json['title'],
        code: json['code'],
        volume: json['volume'],
        isActive: json['is_active'],
        trust: json['trust'],
        fee: json['fee'],
        rent: json['rent'],
        count: json['count'],
      );

  Map<String, dynamic> toJson() => {
        'branch': branch?.toJson(),
        'type': type?.toJson(),
        'title': title,
        'code': code,
        'volume': volume,
        'is_active': isActive,
        'trust': trust,
        'fee': fee,
        'rent': rent,
        'count': count,
      };
}

class Branch {
  Branch({
    this.city,
    this.title,
    this.code,
    this.isActive,
    this.address,
    this.phone,
  });

  City? city;
  String? title;
  int? code;
  bool? isActive;
  String? address;
  String? phone;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        city: json['city'] == null ? null : City.fromJson(json['city']),
        title: json['title'],
        code: json['code'],
        isActive: json['is_active'],
        address: json['address'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'city': city?.toJson(),
        'title': title,
        'code': code,
        'is_active': isActive,
        'address': address,
        'phone': phone,
      };
}

class City {
  City({
    this.name,
    this.depositFundSupport,
  });

  String? name;
  bool? depositFundSupport;

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json['name'],
        depositFundSupport: json['deposit_fund_support'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'deposit_fund_support': depositFundSupport,
      };
}

class Type {
  Type({
    this.title,
    this.titleFa,
  });

  String? title;
  String? titleFa;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        title: json['title'],
        titleFa: json['title_fa'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'title_fa': titleFa,
      };
}

class ReferDate {
  ReferDate({
    this.isActive,
    this.fromHour,
    this.toHour,
  });

  bool? isActive;
  int? fromHour;
  int? toHour;

  factory ReferDate.fromJson(Map<String, dynamic> json) => ReferDate(
        isActive: json['is_active'],
        fromHour: json['from_hour'],
        toHour: json['to_hour'],
      );

  Map<String, dynamic> toJson() => {
        'is_active': isActive,
        'from_hour': fromHour,
        'to_hour': toHour,
      };
}

class VisitTime {
  VisitTime({
    this.id,
    this.date,
    this.isActive,
    this.fromHour,
    this.toHour,
    this.createdAt,
  });

  int? id;
  String? date;
  bool? isActive;
  int? fromHour;
  int? toHour;
  DateTime? createdAt;

  factory VisitTime.fromJson(Map<String, dynamic> json) => VisitTime(
        id: json['id'],
        date: json['date'],
        isActive: json['is_active'],
        fromHour: json['from_hour'],
        toHour: json['to_hour'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'is_active': isActive,
        'from_hour': fromHour,
        'to_hour': toHour,
        'created_at': createdAt?.toIso8601String(),
      };
}
