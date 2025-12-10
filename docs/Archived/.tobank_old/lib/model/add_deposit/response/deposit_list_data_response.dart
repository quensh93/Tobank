import 'dart:convert';

import '../../../util/enums_constants.dart';
import '../../common/error_response_data.dart';

DepositListDataResponse depositListDataResponseFromJson(String str) =>
    DepositListDataResponse.fromJson(json.decode(str));

String depositListDataResponseToJson(DepositListDataResponse data) => json.encode(data.toJson());

class DepositListDataResponse {
  List<DepositDataModel>? data;
  bool? success;
  String? message;
  int? code;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  DepositListDataResponse({
    this.data,
    this.success,
    this.message,
    this.code,
  });

  factory DepositListDataResponse.fromJson(Map<String, dynamic> json) => DepositListDataResponse(
        data: json['data'] == null
            ? []
            : List<DepositDataModel>.from(json['data']!.map((x) => DepositDataModel.fromJson(x))),
        success: json['success'],
        message: json['message'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        'success': success,
        'message': message,
        'code': code,
      };
}

class DepositDataModel {
  int? id;
  String? title;
  String? iban;
  String? accountNumber;
  DateTime? createdAt;
  BankInfo? bankInfo;
  DestinationType? type;

  DepositDataModel({
    this.id,
    this.title,
    this.iban,
    this.accountNumber,
    this.createdAt,
    this.bankInfo,
    this.type,
  });

  factory DepositDataModel.fromJson(Map<String, dynamic> json) => DepositDataModel(
        id: json['id'],
        title: json['title'],
        iban: json['iban'],
        accountNumber: json['account_number'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        bankInfo: json['bank_info'] == null ? null : BankInfo.fromJson(json['bank_info']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'iban': iban,
        'account_number': accountNumber,
        'created_at': createdAt?.toIso8601String(),
        'bank_info': bankInfo?.toJson(),
      };
}

class BankInfo {
  int? id;
  String? title;
  String? preCode;
  String? startColor;
  String? endColor;
  String? enTitle;
  bool? isTransfer;
  String? symbol;
  String? logo;
  String? logoPng;
  String? background;
  bool? inShaparakHub;
  String? shaparakHubBank;

  BankInfo({
    this.id,
    this.title,
    this.preCode,
    this.startColor,
    this.endColor,
    this.enTitle,
    this.isTransfer,
    this.symbol,
    this.logo,
    this.logoPng,
    this.background,
    this.inShaparakHub,
    this.shaparakHubBank,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        id: json['id'],
        title: json['title'],
        preCode: json['pre_code'],
        startColor: json['start_color'],
        endColor: json['end_color'],
        enTitle: json['en_title'],
        isTransfer: json['is_transfer'],
        symbol: json['symbol'],
        logo: json['logo'],
        logoPng: json['logo_png'],
        background: json['background'],
        inShaparakHub: json['in_shaparak_hub'],
        shaparakHubBank: json['shaparak_hub_bank'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'pre_code': preCode,
        'start_color': startColor,
        'end_color': endColor,
        'en_title': enTitle,
        'is_transfer': isTransfer,
        'symbol': symbol,
        'logo': logo,
        'logo_png': logoPng,
        'background': background,
        'in_shaparak_hub': inShaparakHub,
        'shaparak_hub_bank': shaparakHubBank,
      };
}
