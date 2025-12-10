import 'dart:convert';

import '../../common/error_response_data.dart';

CustomerDepositsResponse customerDepositsResponseFromJson(String str) =>
    CustomerDepositsResponse.fromJson(json.decode(str));

String customerDepositsResponseToJson(CustomerDepositsResponse data) => json.encode(data.toJson());

class CustomerDepositsResponse {
  CustomerDepositsResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CustomerDepositsResponse.fromJson(Map<String, dynamic> json) => CustomerDepositsResponse(
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
    this.deposits,
    this.message,
    this.registrationDate,
    this.status,
    this.trackingNumber,
    this.transactionId,
  });

  List<Deposit>? deposits;
  String? message;
  int? registrationDate;
  int? status;
  String? trackingNumber;
  String? transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deposits:
            json['deposits'] == null ? null : List<Deposit>.from(json['deposits'].map((x) => Deposit.fromJson(x))),
        message: json['message'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
      );

  Map<String, dynamic> toJson() => {
        'deposits': deposits == null ? null : List<dynamic>.from(deposits!.map((x) => x.toJson())),
        'message': message,
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
      };
}

class Deposit {
  Deposit({
    this.branchCode,
    this.currencyName,
    this.currencySwiftCode,
    this.customerRelationWithDepositEnglish,
    this.customerRelationWithDepositPersian,
    this.depositIban,
    this.depositNumber,
    this.depositState,
    this.depositTitle,
    this.depositTypeNumber,
    this.depositTypeTitle,
    this.mainCustomerNumber,
    this.withdrawRight,
    this.cardInfo,
    this.depositeKind,
    this.depositeName,
  });

  String? branchCode;
  String? currencyName;
  String? currencySwiftCode;
  String? customerRelationWithDepositEnglish;
  String? customerRelationWithDepositPersian;
  String? depositIban;
  String? depositNumber;
  String? depositState;
  String? depositTitle;
  String? depositTypeNumber;
  String? depositTypeTitle;
  String? mainCustomerNumber;
  String? withdrawRight;
  CardInfo? cardInfo;
  int? depositeKind; // 1 -> short term, 2 -> gharzolhasane, 3 -> long term, 4 -> current
  String? depositeName;
  int? balance;
  bool isHideBalance = true;

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        branchCode: json['BranchCode'],
        currencyName: json['CurrencyName'],
        currencySwiftCode: json['CurrencySwiftCode'],
        customerRelationWithDepositEnglish: json['CustomerRelationWithDepositEnglish'],
        customerRelationWithDepositPersian: json['CustomerRelationWithDepositPersian'],
        depositIban: json['DepositIban'],
        depositNumber: json['DepositNumber'],
        depositState: json['DepositState'],
        depositTitle: json['DepositTitle'],
        depositTypeNumber: json['DepositTypeNumber'],
        depositTypeTitle: json['DepositTypeTitle'],
        mainCustomerNumber: json['MainCustomerNumber'],
        withdrawRight: json['WithdrawRight'],
        cardInfo: json['cardInfo'] == null ? null : CardInfo.fromJson(json['cardInfo']),
        depositeKind: json['deposite_kind'],
        depositeName: json['deposite_name'],
      );

  Map<String, dynamic> toJson() => {
        'BranchCode': branchCode,
        'CurrencyName': currencyName,
        'CurrencySwiftCode': currencySwiftCode,
        'CustomerRelationWithDepositEnglish': customerRelationWithDepositEnglish,
        'CustomerRelationWithDepositPersian': customerRelationWithDepositPersian,
        'DepositIban': depositIban,
        'DepositNumber': depositNumber,
        'DepositState': depositState,
        'DepositTitle': depositTitle,
        'DepositTypeNumber': depositTypeNumber,
        'DepositTypeTitle': depositTypeTitle,
        'MainCustomerNumber': mainCustomerNumber,
        'WithdrawRight': withdrawRight,
        'cardInfo': cardInfo?.toJson(),
        'deposite_kind': depositeKind,
        'deposite_name': depositeName,
      };
}

class CardInfo {
  CardInfo({
    this.cardType,
    this.depositNumber,
    this.pan,
    this.status,
  });

  int? cardType;
  String? depositNumber;
  String? pan;
  int? status;

  factory CardInfo.fromJson(Map<String, dynamic> json) => CardInfo(
        cardType: json['cardType'],
        depositNumber: json['depositNumber'],
        pan: json['pan'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'cardType': cardType,
        'depositNumber': depositNumber,
        'pan': pan,
        'status': status,
      };
}
