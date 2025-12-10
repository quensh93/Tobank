import '../../util/enums_constants.dart';

class CardDataModel {
  CardDataModel({
    this.bankinfo,
    this.cardCvv, // only hub
    this.cardExpMonth,
    this.cardExpYear,
    this.cardNumber,
    this.id,
    this.isMine,
    this.owner,
    this.title,
    this.hubAssurLevel, // only hub
    this.hubCardId, // only hub
    this.hubPanExpDate, // only hub
    this.hubRefExpDate, // only hub
    this.isDefault,
  });

  Bankinfo? bankinfo;
  dynamic cardCvv;
  String? cardExpMonth;
  String? cardExpYear;
  String? cardNumber;
  int? id;
  bool? isMine;
  String? owner;
  String? title;
  int? statusCode;
  CardStatus currentCardStatus = CardStatus.close;
  String? hubAssurLevel;
  String? hubCardId;
  String? hubPanExpDate;
  String? hubRefExpDate;
  bool? isDefault;

  factory CardDataModel.fromJson(Map<String, dynamic> json) => CardDataModel(
        bankinfo: json['bankinfo'] == null ? null : Bankinfo.fromJson(json['bankinfo']),
        cardCvv: json['card_cvv'],
        cardExpMonth: json['card_exp_month'],
        cardExpYear: json['card_exp_year'],
        cardNumber: json['card_number'],
        id: json['id'],
        isMine: json['is_mine'],
        owner: json['owner'],
        title: json['title'],
        hubCardId: json['hub_card_id'],
        hubAssurLevel: json['hub_assur_level'],
        hubPanExpDate: json['hub_pan_exp_date'],
        hubRefExpDate: json['hub_ref_exp_date'],
        isDefault: json['is_default'],
      );

  Map<String, dynamic> toJson() =>
      {
        'bankinfo': bankinfo?.toJson(),
        'card_cvv': cardCvv,
        'card_exp_month': cardExpMonth,
        'card_exp_year': cardExpYear,
        'card_number': cardNumber,
        'id': id,
        'is_mine': isMine,
        'owner': owner,
        'title': title,
        'hub_assur_level': hubAssurLevel,
        'hub_card_id': hubCardId,
        'hub_pan_exp_date': hubPanExpDate,
        'hub_ref_exp_date': hubRefExpDate,
        'is_default': isDefault,
      };

  Map<String, dynamic> toSearchJson() =>
      {
        '_c': cardNumber,
        '_t': title,
      };
}

class Bankinfo {
  Bankinfo({
    this.background,
    this.enTitle,
    this.endColor,
    this.id,
    this.isTransfer,
    this.logo,
    this.logoPng,
    this.startColor,
    this.symbol,
    this.title,
    this.isShaparakHub,
    this.shaparakHubBank,
  });

  String? background;
  String? enTitle;
  String? endColor;
  int? id;
  bool? isTransfer;
  String? logo;
  String? logoPng;
  String? startColor;
  String? symbol;
  String? title;
  bool? isShaparakHub;
  String? shaparakHubBank;

  factory Bankinfo.fromJson(Map<String, dynamic> json) => Bankinfo(
        background: json['background'],
        enTitle: json['en_title'],
        endColor: json['end_color'],
        id: json['id'],
        isTransfer: json['is_transfer'],
        logo: json['logo'],
        logoPng: json['logo_png'],
        startColor: json['start_color'],
        symbol: json['symbol'],
        title: json['title'],
        isShaparakHub: json['in_shaparak_hub'],
        shaparakHubBank: json['shaparak_hub_bank'],
      );

  Map<String, dynamic> toJson() =>
      {
        'background': background,
        'en_title': enTitle,
        'end_color': endColor,
        'id': id,
        'is_transfer': isTransfer,
        'logo': logo,
        'logo_png': logoPng,
        'start_color': startColor,
        'symbol': symbol,
        'title': title,
        'in_shaparak_hub': isShaparakHub,
        'shaparak_hub_bank': shaparakHubBank,
      };
}
