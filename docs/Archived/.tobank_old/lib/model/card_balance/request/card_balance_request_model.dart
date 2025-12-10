import 'dart:convert';

import '../../../service/core/api_request_model.dart';

CardBalanceRequestModel cardBalanceRequestModelFromJson(String str) =>
    CardBalanceRequestModel.fromJson(json.decode(str));

String cardBalanceRequestModelToJson(CardBalanceRequestModel data) => json.encode(data.toJson());

class CardBalanceRequestModel extends ApiRequestModel {
  CardBalanceRequestModel({
    this.cardId,
    this.pin2,
    this.cvv2,
    this.expireDate,
    this.platform,
    this.imei,
    this.isManaToken,
    this.nationalId,
  });

  String? cardId;
  String? pin2;
  String? cvv2;
  String? imei;
  String? platform;
  String? expireDate;
  bool? isManaToken;
  String? nationalId;

  factory CardBalanceRequestModel.fromJson(Map<String, dynamic> json) => CardBalanceRequestModel(
        cardId: json['cardId'],
        pin2: json['pin2'],
        cvv2: json['cvv2'],
        expireDate: json['expireDate'],
        imei: json['imei'],
        platform: json['platform'],
        isManaToken: json['isManaToken'],
        nationalId: json['nationalId'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'cardId': cardId,
        'pin2': pin2,
        'cvv2': cvv2,
        'expireDate': expireDate,
        'imei': imei,
        'platform': platform,
        'isManaToken': isManaToken,
        'nationalId': nationalId,
      };
}
