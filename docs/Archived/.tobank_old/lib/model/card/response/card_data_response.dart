import 'dart:convert';

import '../../common/error_response_data.dart';
import '../card_data_model.dart';

CardDataResponse cardDataResponseFromJson(String str) => CardDataResponse.fromJson(json.decode(str));

String cardDataResponseToJson(CardDataResponse data) => json.encode(data.toJson());

class CardDataResponse {
  CardDataResponse({
    this.data,
    this.message,
    this.success,
  });

  CardDataModel? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory CardDataResponse.fromJson(Map<String, dynamic> json) => CardDataResponse(
        data: CardDataModel.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'message': message,
        'success': success,
      };
}
