import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../service/core/api_request_model.dart';

class PhysicalGiftCardDataRequest extends ApiRequestModel {
  PhysicalGiftCardDataRequest({
    this.cards,
    this.wallet,
    this.receiverFullname,
    this.receiverMobile,
    this.receiverPostcode,
    this.receiverAddress,
    this.receiverLatitude,
    this.receiverLongitude,
    this.deliveryDate,
    this.deliveryTime,
    this.event,
    this.title,
    this.alternativeTitle,
    this.design,
    this.customImage,
    this.city,
    this.province,
    this.token,
  });

  List<CardInfo>? cards;
  int? wallet;
  String? receiverFullname;
  String? receiverMobile;
  String? receiverPostcode;
  String? receiverAddress;
  double? receiverLatitude;
  double? receiverLongitude;
  int? deliveryDate;
  int? deliveryTime;
  int? event;
  String? title;
  String? alternativeTitle;
  int? design;
  String? customImage;
  String? date;
  String? time;
  LatLng? selectedLocation;
  int? city;
  int? province;
  String? token;  // Added nullable token field

  @override
  Map<String, dynamic> toJson() => {
        'cards': List<dynamic>.from(cards!.map((x) => x.toJson())),
        'wallet': wallet,
        'receiver_fullname': receiverFullname,
        'receiver_mobile': receiverMobile,
        'receiver_postcode': receiverPostcode,
        'receiver_address': receiverAddress,
        'receiver_latitude': receiverLatitude,
        'receiver_longitude': receiverLongitude,
        'delivery_date': deliveryDate,
        'delivery_time': deliveryTime,
        'event': event,
        'title': title,
        'alternative_title': alternativeTitle,
        'design': design,
        'custom_image': customImage,
        'city': city,
        'province': province,
        'token': token,  // Added token to the JSON payload
      };
}

class CardInfo {
  CardInfo({
    this.quantity,
    this.balance,
  });

  int? quantity;
  int? balance;
  bool isShow = false;
  TextEditingController amountController = TextEditingController();

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'balance': balance,
      };
}