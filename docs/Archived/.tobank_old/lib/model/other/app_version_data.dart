import 'dart:convert';

import '../common/error_response_data.dart';

AppVersionData appVersionDataFromJson(String str) => AppVersionData.fromJson(json.decode(str));

String appVersionDataToJson(AppVersionData data) => json.encode(data.toJson());

class AppVersionData {
  AppVersionData({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory AppVersionData.fromJson(Map<String, dynamic> json) => AppVersionData(
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    this.app,
    this.landingpage,
    this.lastestMenuUpdate,
    this.autf,
    this.backgroundTimeForPass,
    this.advertismentText,
    this.creditInquiryPrice,
    this.activateIncreaseDepositBalance,
    this.activatePromissoryPublishPayment,
    this.activateLoanFeePayment,
    this.activateWalletChargePayment,
    this.activateCreditInquiryPayment,
  });

  App? app;
  Landingpage? landingpage;
  String? lastestMenuUpdate;
  bool? autf;
  int? backgroundTimeForPass;
  String? advertismentText;
  int? creditInquiryPrice;
  bool? activatePromissoryPublishPayment;
  bool? activateLoanFeePayment;
  bool? activateWalletChargePayment;
  bool? activateCreditInquiryPayment;

  bool? activateIncreaseDepositBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        app: json['app'] == null ? null : App.fromJson(json['app']),
        landingpage: json['landingpage'] == null ? null : Landingpage.fromJson(json['landingpage']),
        lastestMenuUpdate: json['lastest_menu_update'],
        autf: json['autf'],
        backgroundTimeForPass: json['background_time_for_pass'],
        advertismentText: json['advertisment_text'],
        creditInquiryPrice: json['credit_inquiry_price'],
        activatePromissoryPublishPayment: json['activate_promissory_publish_payment'],
        activateLoanFeePayment: json['activate_loan_fee_payment'],
        activateWalletChargePayment: json['activate_wallet_charge_payment'],
        activateCreditInquiryPayment: json['activate_credit_inquiry_payment'],
        activateIncreaseDepositBalance: json['activate_increase_deposit_balance'],
      );

  Map<String, dynamic> toJson() => {
        'app': app?.toJson(),
        'landingpage': landingpage?.toJson(),
        'lastest_menu_update': lastestMenuUpdate,
        'autf': autf,
        'background_time_for_pass': backgroundTimeForPass,
        'advertisment_text': advertismentText,
        'credit_inquiry_price': creditInquiryPrice,
        'activate_increase_deposit_balance': activateIncreaseDepositBalance,
        'activate_promissory_publish_payment': activatePromissoryPublishPayment,
        'activate_loan_fee_payment': activateLoanFeePayment,
        'activate_wallet_charge_payment': activateWalletChargePayment,
        'activate_credit_inquiry_payment': activateCreditInquiryPayment,
      };
}

class App {
  App({
    this.id,
    this.version,
    this.type,
    this.forcingUpdate,
    this.link,
    this.link32,
    this.createdAt,
    this.showUpdate,
  });

  int? id;
  String? version;
  String? type;
  bool? forcingUpdate;
  String? link;
  String? link32;
  String? createdAt;
  bool? showUpdate;

  factory App.fromJson(Map<String, dynamic> json) => App(
        id: json['id'],
        version: json['version'],
        type: json['type'],
        forcingUpdate: json['forcing_update'],
        link: json['link'],
        link32: json['link_32'],
        createdAt: json['created_at'],
        showUpdate: json['show_update'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'version': version,
        'type': type,
        'forcing_update': forcingUpdate,
        'link': link,
        'link_32': link32,
        'created_at': createdAt,
        'show_update': showUpdate,
      };
}

class Landingpage {
  Landingpage({
    this.id,
    this.title,
    this.link,
    this.createdAt,
  });

  int? id;
  String? title;
  String? link;
  String? createdAt;

  factory Landingpage.fromJson(Map<String, dynamic> json) => Landingpage(
        id: json['id'],
        title: json['title'],
        link: json['link'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'link': link,
        'created_at': createdAt,
      };
}
