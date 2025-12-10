import 'dart:convert';

import '../../common/error_response_data.dart';

CustomerCardResponseData customerCardResponseDataFromJson(String str) =>
    CustomerCardResponseData.fromJson(json.decode(str));

String customerCardResponseDataToJson(CustomerCardResponseData data) => json.encode(data.toJson());

class CustomerCardResponseData {
  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  CustomerCardResponseData({
    this.data,
    this.success,
    this.message,
  });

  factory CustomerCardResponseData.fromJson(Map<String, dynamic> json) => CustomerCardResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
      };
}

class Data {
  List<BankInfo>? bankInfo;
  List<CustomerCard>? cards;

  Data({
    this.bankInfo,
    this.cards,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bankInfo:
            json['bank_info'] == null ? [] : List<BankInfo>.from(json['bank_info']!.map((x) => BankInfo.fromJson(x))),
        cards:
            json['cards'] == null ? [] : List<CustomerCard>.from(json['cards']!.map((x) => CustomerCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'bank_info': bankInfo == null ? [] : List<dynamic>.from(bankInfo!.map((x) => x.toJson())),
        'cards': cards == null ? [] : List<dynamic>.from(cards!.map((x) => x.toJson())),
      };
}

class BankInfo {
  int? id;
  String? title;
  String? enTitle;
  String? preCode;
  String? startColor;
  String? endColor;
  String? symbol;
  String? logo;
  String? logoPng;
  String? background;
  dynamic faraboomHeader;
  bool? isTransfer;
  bool? inShaparakHub;
  bool? needPassword;
  String? shaparakHubBank;
  bool? showable;

  BankInfo({
    this.id,
    this.title,
    this.enTitle,
    this.preCode,
    this.startColor,
    this.endColor,
    this.symbol,
    this.logo,
    this.logoPng,
    this.background,
    this.faraboomHeader,
    this.isTransfer,
    this.inShaparakHub,
    this.needPassword,
    this.shaparakHubBank,
    this.showable,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        id: json['id'],
        title: json['title'],
        enTitle: json['en_title'],
        preCode: json['pre_code'],
        startColor: json['start_color'],
        endColor: json['end_color'],
        symbol: json['symbol'],
        logo: json['logo'],
        logoPng: json['logo_png'],
        background: json['background'],
        faraboomHeader: json['faraboom_header'],
        isTransfer: json['is_transfer'],
        inShaparakHub: json['in_shaparak_hub'],
        needPassword: json['need_password'],
        shaparakHubBank: json['shaparak_hub_bank'],
        showable: json['showable'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'en_title': enTitle,
        'pre_code': preCode,
        'start_color': startColor,
        'end_color': endColor,
        'symbol': symbol,
        'logo': logo,
        'logo_png': logoPng,
        'background': background,
        'faraboom_header': faraboomHeader,
        'is_transfer': isTransfer,
        'in_shaparak_hub': inShaparakHub,
        'need_password': needPassword,
        'shaparak_hub_bank': shaparakHubBank,
        'showable': showable,
      };
}

class CustomerCard {
  int? id;
  String? title;
  String? cardNumber;
  bool? isDefault;
  String? cardExpMonth;
  String? cardExpYear;
  bool? isMine;
  String? status;
  int? bankId;
  GardeshgaryCardData? gardeshgaryCardData;
  HubCardData? hubCardData;
  String? owner;

  CustomerCard({
    this.id,
    this.title,
    this.cardNumber,
    this.isDefault,
    this.cardExpMonth,
    this.cardExpYear,
    this.isMine,
    this.status,
    this.bankId,
    this.gardeshgaryCardData,
    this.hubCardData,
    this.owner,
  });

  factory CustomerCard.fromJson(Map<String, dynamic> json) => CustomerCard(
        id: json['id'],
        title: json['title'],
        cardNumber: json['card_number'],
        isDefault: json['is_default'],
        cardExpMonth: json['card_exp_month'],
        cardExpYear: json['card_exp_year'],
        isMine: json['is_mine'],
        status: json['status'],
        bankId: json['bank_id'],
        gardeshgaryCardData:
            json['gardeshgary_card_data'] == null ? null : GardeshgaryCardData.fromJson(json['gardeshgary_card_data']),
        hubCardData: json['hub_card_data'] == null ? null : HubCardData.fromJson(json['hub_card_data']),
        owner: json['owner'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'card_number': cardNumber,
        'is_default': isDefault,
        'card_exp_month': cardExpMonth,
        'card_exp_year': cardExpYear,
        'is_mine': isMine,
        'status': status,
        'bank_id': bankId,
        'gardeshgary_card_data': gardeshgaryCardData?.toJson(),
        'hub_card_data': hubCardData?.toJson(),
        'owner': owner,
      };

  Map<String, dynamic> toSearchJson() => {
        '_c': cardNumber,
        '_t': title,
      };
}

class GardeshgaryCardData {
  int? cardType;
  int? status;
  String? depositNumber;
  int? balance;

  GardeshgaryCardData({
    this.cardType,
    this.status,
    this.depositNumber,
    this.balance,
  });

  factory GardeshgaryCardData.fromJson(Map<String, dynamic> json) => GardeshgaryCardData(
        cardType: json['card_type'],
        status: json['status'],
        depositNumber: json['deposit_number'],
      );

  Map<String, dynamic> toJson() => {
        'card_type': cardType,
        'status': status,
        'deposit_number': depositNumber,
      };
}

class HubCardData {
  String? hubCardId;
  String? hubRefExpDate;
  String? hubPanExpDate;
  String? hubAssurLevel;

  HubCardData({
    this.hubCardId,
    this.hubRefExpDate,
    this.hubPanExpDate,
    this.hubAssurLevel,
  });

  factory HubCardData.fromJson(Map<String, dynamic> json) => HubCardData(
        hubCardId: json['hub_card_id'],
        hubRefExpDate: json['hub_ref_exp_date'],
        hubPanExpDate: json['hub_pan_exp_date'],
        hubAssurLevel: json['hub_assur_level'],
      );

  Map<String, dynamic> toJson() => {
        'hub_card_id': hubCardId,
        'hub_ref_exp_date': hubRefExpDate,
        'hub_pan_exp_date': hubPanExpDate,
        'hub_assur_level': hubAssurLevel,
      };
}
