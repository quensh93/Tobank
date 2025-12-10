import 'dart:convert';

CreditCardFacilityDepositListResponseData creditCardFacilityDepositListResponseDataFromJson(String str) =>
    CreditCardFacilityDepositListResponseData.fromJson(json.decode(str));

String creditCardFacilityDepositListResponseDataToJson(CreditCardFacilityDepositListResponseData data) =>
    json.encode(data.toJson());

class CreditCardFacilityDepositListResponseData {
  String? message;
  bool? success;
  Data? data;

  CreditCardFacilityDepositListResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory CreditCardFacilityDepositListResponseData.fromJson(Map<String, dynamic> json) =>
      CreditCardFacilityDepositListResponseData(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  List<DepositList>? depositList;

  Data({
    this.depositList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        depositList: json['deposit_list'] == null
            ? []
            : List<DepositList>.from(json['deposit_list']!.map((x) => DepositList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'deposit_list': depositList == null ? [] : List<dynamic>.from(depositList!.map((x) => x.toJson())),
      };
}

class DepositList {
  String? depositNumber;
  String? mainCustomerNumber;
  String? depositTitle;
  String? depositTypeNumber;
  String? depositTypeTitle;
  String? customerRelationWithDepositPersian;
  String? customerRelationWithDepositEnglish;
  String? depositState;
  String? currencyName;
  String? currencySwiftCode;
  String? withdrawRight;
  String? branchCode;
  String? depositIban;
  bool? shared;
  CardInfo? cardInfo;

  DepositList({
    this.depositNumber,
    this.mainCustomerNumber,
    this.depositTitle,
    this.depositTypeNumber,
    this.depositTypeTitle,
    this.customerRelationWithDepositPersian,
    this.customerRelationWithDepositEnglish,
    this.depositState,
    this.currencyName,
    this.currencySwiftCode,
    this.withdrawRight,
    this.branchCode,
    this.depositIban,
    this.shared,
    this.cardInfo,
  });

  factory DepositList.fromJson(Map<String, dynamic> json) => DepositList(
        depositNumber: json['DepositNumber'],
        mainCustomerNumber: json['MainCustomerNumber'],
        depositTitle: json['DepositTitle'],
        depositTypeNumber: json['DepositTypeNumber'],
        depositTypeTitle: json['DepositTypeTitle'],
        customerRelationWithDepositPersian: json['CustomerRelationWithDepositPersian'],
        customerRelationWithDepositEnglish: json['CustomerRelationWithDepositEnglish'],
        depositState: json['DepositState'],
        currencyName: json['CurrencyName'],
        currencySwiftCode: json['CurrencySwiftCode'],
        withdrawRight: json['WithdrawRight'],
        branchCode: json['BranchCode'],
        depositIban: json['DepositIban'],
        shared: json['shared'],
        cardInfo: json['cardInfo'] == null ? null : CardInfo.fromJson(json['cardInfo']),
      );

  Map<String, dynamic> toJson() => {
        'DepositNumber': depositNumber,
        'MainCustomerNumber': mainCustomerNumber,
        'DepositTitle': depositTitle,
        'DepositTypeNumber': depositTypeNumber,
        'DepositTypeTitle': depositTypeTitle,
        'CustomerRelationWithDepositPersian': customerRelationWithDepositPersian,
        'CustomerRelationWithDepositEnglish': customerRelationWithDepositEnglish,
        'DepositState': depositState,
        'CurrencyName': currencyName,
        'CurrencySwiftCode': currencySwiftCode,
        'WithdrawRight': withdrawRight,
        'BranchCode': branchCode,
        'DepositIban': depositIban,
        'shared': shared,
        'cardInfo': cardInfo?.toJson(),
      };
}

class CardInfo {
  String? pan;
  int? cardType;
  int? status;
  String? depositNumber;

  CardInfo({
    this.pan,
    this.cardType,
    this.status,
    this.depositNumber,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) => CardInfo(
        pan: json['pan'],
        cardType: json['cardType'],
        status: json['status'],
        depositNumber: json['depositNumber'],
      );

  Map<String, dynamic> toJson() => {
        'pan': pan,
        'cardType': cardType,
        'status': status,
        'depositNumber': depositNumber,
      };
}
