import 'dart:convert';

import '../../common/error_response_data.dart';

CustomerCardsResponse customerCardsResponseFromJson(String str) => CustomerCardsResponse.fromJson(json.decode(str));

String customerCardsResponseToJson(CustomerCardsResponse data) => json.encode(data.toJson());

class CustomerCardsResponse {
  CustomerCardsResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CustomerCardsResponse.fromJson(Map<String, dynamic> json) => CustomerCardsResponse(
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
    this.cards,
    this.errors,
    this.message,
    this.registrationDate,
    this.status,
    this.trackingNumber,
    this.transactionId,
  });

  List<CardData>? cards;
  dynamic errors;
  dynamic message;
  int? registrationDate;
  int? status;
  String? trackingNumber;
  String? transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cards: json['cards'] == null ? null : List<CardData>.from(json['cards'].map((x) => CardData.fromJson(x))),
        errors: json['errors'],
        message: json['message'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
      );

  Map<String, dynamic> toJson() => {
        'cards': cards == null ? null : List<dynamic>.from(cards!.map((x) => x.toJson())),
        'errors': errors,
        'message': message,
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
      };
}

class CardData {
  CardData({
    this.cardType,
    this.depositNumber,
    this.pan,
    this.status,
  });

  int? cardType;
  String? depositNumber;
  String? pan;
  int? status;
  int? balance;

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
        cardType: json['cardType'],
        depositNumber: json['depositNumber'],
        pan: json['pan'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'cardType': cardType,
        'depositNumber': depositNumber,
        'pan': pan,
        'status': status,
      };
}
