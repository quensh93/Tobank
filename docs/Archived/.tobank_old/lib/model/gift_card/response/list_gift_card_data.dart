import 'dart:convert';

import '../../common/error_response_data.dart';

ListPhysicalGiftCardData listPhysicalGiftCardDataFromJson(String str) =>
    ListPhysicalGiftCardData.fromJson(json.decode(str));

String listPhysicalGiftCardDataToJson(ListPhysicalGiftCardData data) => json.encode(data.toJson());

class ListPhysicalGiftCardData {
  ListPhysicalGiftCardData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;
  ErrorResponseData? errorResponseData;

  factory ListPhysicalGiftCardData.fromJson(Map<String, dynamic> json) => ListPhysicalGiftCardData(
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
  String? next;
  dynamic previous;
  List<PhysicalGiftCardData>? results;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: List<PhysicalGiftCardData>.from(json['results'].map((x) => PhysicalGiftCardData.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        'count': count,
        'next': next,
        'previous': previous,
        'results': List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class PhysicalGiftCardData {
  PhysicalGiftCardData({
    this.alternativeImage,
    this.alternativeTitle,
    this.balance,
    this.chargeAmount,
    this.createdAt,
    this.delivery,
    this.deliveryCost,
    this.deliveryDate,
    this.deliveryTime,
    this.event,
    this.eventTitle,
    this.id,
    this.image,
    this.owner,
    this.quantity,
    this.receiverAddress,
    this.receiverFullname,
    this.receiverLatitude,
    this.receiverLongitude,
    this.receiverMobile,
    this.receiverPostcode,
    this.status,
    this.title,
    this.updatedAt,
    this.statusColor,
    this.statusFa,
    this.province,
    this.city,
  });

  String? alternativeImage;
  String? alternativeTitle;
  int? balance;
  int? chargeAmount;
  String? createdAt;
  Delivery? delivery;
  int? deliveryCost;
  int? deliveryDate;
  int? deliveryTime;
  int? event;
  String? eventTitle;
  int? id;
  String? image;
  int? owner;
  int? quantity;
  String? receiverAddress;
  String? receiverFullname;
  String? receiverLatitude;
  String? receiverLongitude;
  String? receiverMobile;
  String? receiverPostcode;
  String? status;
  String? title;
  DateTime? updatedAt;
  String? statusColor;
  String? statusFa;
  int? province;
  int? city;

  int getAllCost() {
    final int sumCost = deliveryCost! + chargeAmount! + balance!;
    return sumCost;
  }

  factory PhysicalGiftCardData.fromJson(Map<String, dynamic> json) => PhysicalGiftCardData(
        alternativeImage: json['alternative_image'],
        alternativeTitle: json['alternative_title'],
        balance: json['balance'],
        chargeAmount: json['charge_amount'],
        createdAt: json['created_at'],
        delivery: Delivery.fromJson(json['delivery']),
        deliveryCost: json['delivery_cost'],
        deliveryDate: json['delivery_date'],
        deliveryTime: json['delivery_time'],
        event: json['event'],
        eventTitle: json['event_title'],
        id: json['id'],
        image: json['image'],
        owner: json['owner'],
        quantity: json['quantity'],
        receiverAddress: json['receiver_address'],
        receiverFullname: json['receiver_fullname'],
        receiverLatitude: json['receiver_latitude'],
        receiverLongitude: json['receiver_longitude'],
        receiverMobile: json['receiver_mobile'],
        receiverPostcode: json['receiver_postcode'],
        status: json['status'],
        title: json['title'],
        updatedAt: DateTime.parse(json['updated_at']),
        statusColor: json['status_color'],
        statusFa: json['status_fa'],
        province: json['province'],
        city: json['city'],
      );

  Map<String, dynamic> toJson() => {
        'alternative_image': alternativeImage,
        'alternative_title': alternativeTitle,
        'balance': balance,
        'charge_amount': chargeAmount,
        'created_at': createdAt,
        'delivery': delivery!.toJson(),
        'delivery_cost': deliveryCost,
        'delivery_date': deliveryDate,
        'delivery_time': deliveryTime,
        'event': event,
        'event_title': eventTitle,
        'id': id,
        'image': image,
        'owner': owner,
        'quantity': quantity,
        'receiver_address': receiverAddress,
        'receiver_fullname': receiverFullname,
        'receiver_latitude': receiverLatitude,
        'receiver_longitude': receiverLongitude,
        'receiver_mobile': receiverMobile,
        'receiver_postcode': receiverPostcode,
        'status': status,
        'title': title,
        'updated_at': updatedAt!.toIso8601String(),
        'status_color': statusColor,
        'status_fa': statusFa,
        'province': province,
        'city': city,
      };
}

class Delivery {
  Delivery({
    this.date,
    this.time,
  });

  Date? date;
  Time? time;

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        date: Date.fromJson(json['date']),
        time: Time.fromJson(json['time']),
      );

  Map<String, dynamic> toJson() =>
      {
        'date': date!.toJson(),
        'time': time!.toJson(),
      };
}

class Date {
  Date({
    this.deliveryDate,
    this.id,
    this.isActive,
  });

  DateTime? deliveryDate;
  int? id;
  bool? isActive;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        deliveryDate: DateTime.parse(json['delivery_date']),
        id: json['id'],
        isActive: json['is_active'],
      );

  Map<String, dynamic> toJson() =>
      {
        'delivery_date':
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        'id': id,
        'is_active': isActive,
      };
}

class Time {
  Time({
    this.date,
    this.fromHour,
    this.id,
    this.toHour,
  });

  int? date;
  int? fromHour;
  int? id;
  int? toHour;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
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
