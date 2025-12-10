import 'dart:convert';

import '../../common/error_response_data.dart';

ChargeStaticResponseData chargeStaticResponseDataFromJson(String str) =>
    ChargeStaticResponseData.fromJson(json.decode(str));

String chargeStaticResponseDataToJson(ChargeStaticResponseData data) => json.encode(data.toJson());

class ChargeStaticResponseData {
  ChargeStaticResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ChargeStaticResponseData.fromJson(Map<String, dynamic> json) => ChargeStaticResponseData(
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
    this.mciChargePlan,
    this.mtn3GChargePlan,
    this.mtnChargePlan,
    this.dataOperator,
    this.price,
    this.rightelChargePlan,
    this.shatelChargePlan,
  });

  MciChargePlan? mciChargePlan;
  MtnChargePlan? mtn3GChargePlan;
  MtnChargePlan? mtnChargePlan;
  List<String>? dataOperator;
  List<int>? price;
  RightelChargePlan? rightelChargePlan;
  ShatelChargePlan? shatelChargePlan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mciChargePlan: json['mci_charge_plan'] == null ? null : MciChargePlan.fromJson(json['mci_charge_plan']),
        mtn3GChargePlan: json['mtn_3g_charge_plan'] == null ? null : MtnChargePlan.fromJson(json['mtn_3g_charge_plan']),
        mtnChargePlan: json['mtn_charge_plan'] == null ? null : MtnChargePlan.fromJson(json['mtn_charge_plan']),
        dataOperator: json['operator'] == null ? null : List<String>.from(json['operator'].map((x) => x)),
        price: json['price'] == null ? null : List<int>.from(json['price'].map((x) => x)),
        rightelChargePlan:
            json['rightel_charge_plan'] == null ? null : RightelChargePlan.fromJson(json['rightel_charge_plan']),
        shatelChargePlan:
            json['shatel_charge_plan'] == null ? null : ShatelChargePlan.fromJson(json['shatel_charge_plan']),
      );

  Map<String, dynamic> toJson() => {
        'mci_charge_plan': mciChargePlan?.toJson(),
        'mtn_3g_charge_plan': mtn3GChargePlan?.toJson(),
        'mtn_charge_plan': mtnChargePlan?.toJson(),
        'operator': dataOperator == null ? null : List<dynamic>.from(dataOperator!.map((x) => x)),
        'price': price == null ? null : List<dynamic>.from(price!.map((x) => x)),
        'rightel_charge_plan': rightelChargePlan?.toJson(),
        'shatel_charge_plan': shatelChargePlan?.toJson(),
      };
}

class MciChargePlan {
  MciChargePlan({
    this.mciPlanData,
    this.price,
    this.title,
  });

  List<PlanDatum>? mciPlanData;
  List<int>? price;
  String? title;

  factory MciChargePlan.fromJson(Map<String, dynamic> json) => MciChargePlan(
    mciPlanData: json['mci_plan_data'] == null
            ? null
            : List<PlanDatum>.from(json['mci_plan_data'].map((x) => PlanDatum.fromJson(x))),
        price: json['price'] == null ? null : List<int>.from(json['price'].map((x) => x)),
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'mci_plan_data': mciPlanData == null ? null : List<dynamic>.from(mciPlanData!.map((x) => x.toJson())),
        'price': price == null ? null : List<dynamic>.from(price!.map((x) => x)),
        'title': title,
      };
}

class PlanDatum {
  PlanDatum({
    this.title,
    this.value,
  });

  String? title;
  int? value;

  factory PlanDatum.fromJson(Map<String, dynamic> json) => PlanDatum(
        title: json['title'],
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'value': value,
      };
}

class MtnChargePlan {
  MtnChargePlan({
    this.mtnPlanData,
    this.price,
    this.title,
  });

  List<PlanDatum>? mtnPlanData;
  List<int>? price;
  String? title;

  factory MtnChargePlan.fromJson(Map<String, dynamic> json) => MtnChargePlan(
    mtnPlanData: json['mtn_plan_data'] == null
            ? null
            : List<PlanDatum>.from(json['mtn_plan_data'].map((x) => PlanDatum.fromJson(x))),
        price: json['price'] == null ? null : List<int>.from(json['price'].map((x) => x)),
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'mtn_plan_data': mtnPlanData == null ? null : List<dynamic>.from(mtnPlanData!.map((x) => x.toJson())),
        'price': price == null ? null : List<dynamic>.from(price!.map((x) => x)),
        'title': title,
      };
}

class RightelChargePlan {
  RightelChargePlan({
    this.price,
    this.rightelPlanData,
    this.title,
  });

  List<int>? price;
  List<PlanDatum>? rightelPlanData;
  String? title;

  factory RightelChargePlan.fromJson(Map<String, dynamic> json) => RightelChargePlan(
        price: json['price'] == null ? null : List<int>.from(json['price'].map((x) => x)),
        rightelPlanData: json['rightel_plan_data'] == null
            ? null
            : List<PlanDatum>.from(json['rightel_plan_data'].map((x) => PlanDatum.fromJson(x))),
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'price': price == null ? null : List<dynamic>.from(price!.map((x) => x)),
        'rightel_plan_data':
            rightelPlanData == null ? null : List<dynamic>.from(rightelPlanData!.map((x) => x.toJson())),
        'title': title,
      };
}

class ShatelChargePlan {
  ShatelChargePlan({
    this.price,
    this.shatelPlanData,
    this.title,
  });

  List<int>? price;
  List<PlanDatum>? shatelPlanData;
  String? title;

  factory ShatelChargePlan.fromJson(Map<String, dynamic> json) => ShatelChargePlan(
        price: json['price'] == null ? null : List<int>.from(json['price'].map((x) => x)),
        shatelPlanData: json['shatel_plan_data'] == null
            ? null
            : List<PlanDatum>.from(json['shatel_plan_data'].map((x) => PlanDatum.fromJson(x))),
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'price': price == null ? null : List<dynamic>.from(price!.map((x) => x)),
        'shatel_plan_data': shatelPlanData == null ? null : List<dynamic>.from(shatelPlanData!.map((x) => x.toJson())),
        'title': title,
      };
}
