import 'dart:convert';

BankListData bankListDataFromJson(String str) => BankListData.fromJson(json.decode(str));

String bankListDataToJson(BankListData data) => json.encode(data.toJson());

class BankListData {
  List<BankDataItem>? data;

  BankListData({
    this.data,
  });

  factory BankListData.fromJson(Map<String, dynamic> json) => BankListData(
    data: json['data'] == null ? [] : List<BankDataItem>.from(json['data']!.map((x) => BankDataItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BankDataItem {
  int? id;
  String? title;
  String? preCode;
  String? startColor;
  String? endColor;
  String? enTitle;
  String? symbol;
  String? logo;
  String? logoPng;
  String? background;

  BankDataItem({
    this.id,
    this.title,
    this.preCode,
    this.startColor,
    this.endColor,
    this.enTitle,
    this.symbol,
    this.logo,
    this.logoPng,
    this.background,
  });

  factory BankDataItem.fromJson(Map<String, dynamic> json) => BankDataItem(
        id: json['id'],
        title: json['title'],
        preCode: json['pre_code'],
        startColor: json['start_color'],
        endColor: json['end_color'],
        enTitle: json['en_title'],
        symbol: json['symbol'],
        logo: json['logo'],
        logoPng: json['logo_png'],
        background: json['background'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'pre_code': preCode,
        'start_color': startColor,
        'end_color': endColor,
        'en_title': enTitle,
        'symbol': symbol,
        'logo': logo,
        'logo_png': logoPng,
        'background': background,
      };
}
