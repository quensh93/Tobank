import 'dart:convert';

import '../../common/error_response_data.dart';

BranchListResponseData branchListResponseDataFromJson(String str) => BranchListResponseData.fromJson(json.decode(str));

String branchListResponseDataToJson(BranchListResponseData data) => json.encode(data.toJson());

class BranchListResponseData {
  BranchListResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory BranchListResponseData.fromJson(Map<String, dynamic> json) => BranchListResponseData(
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
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<BranchResult>? results;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: json['results'] == null
            ? null
            : List<BranchResult>.from(json['results'].map((x) => BranchResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
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

  BranchResult? branch;
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
        branch: json['branch'] == null ? null : BranchResult.fromJson(json['branch']),
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

class BranchResult {
  BranchResult({
    this.address,
    this.city,
    this.code,
    this.createdAt,
    this.funds,
    this.id,
    this.isActive,
    this.phone,
    this.title,
  });

  String? address;
  City? city;
  int? code;
  DateTime? createdAt;
  List<Fund>? funds;
  int? id;
  bool? isActive;
  String? phone;
  String? title;

  factory BranchResult.fromJson(Map<String, dynamic> json) => BranchResult(
        address: json['address'],
        city: json['city'] == null ? null : City.fromJson(json['city']),
        code: json['code'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        funds: json['funds'] == null ? null : List<Fund>.from(json['funds'].map((x) => Fund.fromJson(x))),
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
        'funds': funds == null ? null : List<dynamic>.from(funds!.map((x) => x.toJson())),
        'id': id,
        'is_active': isActive,
        'phone': phone,
        'title': title,
      };

  String toSearch() {
    return '${title!} $code';
  }
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
