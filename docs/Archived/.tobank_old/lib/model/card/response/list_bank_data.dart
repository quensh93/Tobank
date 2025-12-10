import 'dart:convert';

ListBankData listBankDataFromJson(String str) => ListBankData.fromJson(json.decode(str));

String listBankDataToJson(ListBankData data) => json.encode(data.toJson());

class ListBankData {
  ListBankData({
    this.data,
    this.message,
    this.success,
  });

  List<BankInfoData>? data;
  String? message;
  bool? success;
  int? statusCode;

  factory ListBankData.fromJson(Map<String, dynamic> json) => ListBankData(
        data: List<BankInfoData>.from(json['data'].map((x) => BankInfoData.fromJson(x))),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
        'success': success,
      };
}

class BankInfoData {
  BankInfoData({
    this.background,
    this.enTitle,
    this.endColor,
    this.id,
    this.isTransfer,
    this.logo,
    this.logoPng,
    this.preCode,
    this.startColor,
    this.symbol,
    this.title,
  });

  String? background;
  String? enTitle;
  String? endColor;
  int? id;
  bool? isTransfer;
  String? logo;
  String? logoPng;
  String? preCode;
  String? startColor;
  String? symbol;
  String? title;

  factory BankInfoData.fromJson(Map<String, dynamic> json) => BankInfoData(
        background: json['background'],
        enTitle: json['en_title'],
        endColor: json['end_color'],
        id: json['id'],
        isTransfer: json['is_transfer'],
        logo: json['logo'],
        logoPng: json['logo_png'],
        preCode: json['pre_code'],
        startColor: json['start_color'],
        symbol: json['symbol'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'background': background,
        'en_title': enTitle,
        'end_color': endColor,
        'id': id,
        'is_transfer': isTransfer,
        'logo': logo,
        'logo_png': logoPng,
        'pre_code': preCode,
        'start_color': startColor,
        'symbol': symbol,
        'title': title,
      };
}
