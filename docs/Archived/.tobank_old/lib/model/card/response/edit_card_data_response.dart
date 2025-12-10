import 'dart:convert';

import '../../common/error_response_data.dart';

EditCardDataResponse editCardDataResponseFromJson(String str) => EditCardDataResponse.fromJson(json.decode(str));

String editCardDataResponseToJson(EditCardDataResponse data) => json.encode(data.toJson());

class EditCardDataResponse {
  EditCardDataResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory EditCardDataResponse.fromJson(Map<String, dynamic> json) => EditCardDataResponse(
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
    this.cardExpMonth,
    this.cardExpYear,
    this.cardNumber,
    this.id,
    this.owner,
    this.title,
  });

  String? cardExpMonth;
  String? cardExpYear;
  String? cardNumber;
  int? id;
  String? owner;
  String? title;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cardExpMonth: json['card_exp_month'],
        cardExpYear: json['card_exp_year'],
        cardNumber: json['card_number'],
        id: json['id'],
        owner: json['owner'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() =>
      {
        'card_exp_month': cardExpMonth,
        'card_exp_year': cardExpYear,
        'card_number': cardNumber,
        'id': id,
        'owner': owner,
        'title': title,
      };
}
