import 'dart:convert';

import '../../common/error_response_data.dart';

ListDeliveryDateData listDeliveryDateDataFromJson(String str) => ListDeliveryDateData.fromJson(json.decode(str));

String listDeliveryDateDataToJson(ListDeliveryDateData data) => json.encode(data.toJson());

class ListDeliveryDateData {
  ListDeliveryDateData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ListDeliveryDateData.fromJson(Map<String, dynamic> json) => ListDeliveryDateData(
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
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<DeliveryDate>? results;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: List<DeliveryDate>.from(json['results'].map((x) => DeliveryDate.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        'count': count,
        'next': next,
        'previous': previous,
        'results': List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class DeliveryDate {
  DeliveryDate({
    this.deliveryDate,
    this.id,
    this.isActive,
    this.times,
  });

  String? deliveryDate;
  int? id;
  bool? isActive;
  List<DeliveryTime>? times;

  factory DeliveryDate.fromJson(Map<String, dynamic> json) => DeliveryDate(
        deliveryDate: json['delivery_date'],
        id: json['id'],
        isActive: json['is_active'],
        times: List<DeliveryTime>.from(json['times'].map((x) => DeliveryTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        'delivery_date': deliveryDate,
        'id': id,
        'is_active': isActive,
        'times': List<dynamic>.from(times!.map((x) => x.toJson())),
      };
}

class DeliveryTime {
  DeliveryTime({
    this.date,
    this.fromHour,
    this.id,
    this.toHour,
  });

  int? date;
  int? fromHour;
  int? id;
  int? toHour;

  factory DeliveryTime.fromJson(Map<String, dynamic> json) => DeliveryTime(
        date: json['date'],
        fromHour: json['from_hour'],
        id: json['id'],
        toHour: json['to_hour'],
      );

  Map<String, dynamic> toJson() =>
      {
        'date': date,
        'from_hour': fromHour,
        'id': id,
        'to_hour': toHour,
      };
}
