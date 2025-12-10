import 'dart:convert';

import '../../common/error_response_data.dart';

CostsData costsDataFromJson(String str) => CostsData.fromJson(json.decode(str));

String costsDataToJson(CostsData data) => json.encode(data.toJson());

class CostsData {
  CostsData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;
  ErrorResponseData? errorResponseData;

  factory CostsData.fromJson(Map<String, dynamic> json) => CostsData(
        data: Data.fromJson(json['data']),
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'success': success,
      };
}

class Data {
  Data({
    this.chargeAmount,
    this.deliveryCost,
    this.hasAnyCard,
    this.orderQuantity,
    this.maxPayableAmount,
    this.minPayableAmount,
    this.enableOrderCustomDesign,
  });

  int? chargeAmount;
  int? deliveryCost;
  bool? hasAnyCard;
  int? orderQuantity;
  int? maxPayableAmount;
  int? minPayableAmount;
  bool? enableOrderCustomDesign;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        chargeAmount: json['charge_amount'],
        deliveryCost: json['delivery_cost'],
        hasAnyCard: json['has_any_card'],
        orderQuantity: json['order_quantity'],
        maxPayableAmount: json['max_payable_amount'],
        minPayableAmount: json['min_payable_amount'],
        enableOrderCustomDesign: json['enable_order_custom_design'],
      );

  Map<String, dynamic> toJson() => {
        'charge_amount': chargeAmount,
        'delivery_cost': deliveryCost,
        'has_any_card': hasAnyCard,
        'order_quantity': orderQuantity,
        'max_payable_amount': maxPayableAmount,
        'min_payable_amount': minPayableAmount,
        'enable_order_custom_design': enableOrderCustomDesign,
      };
}
