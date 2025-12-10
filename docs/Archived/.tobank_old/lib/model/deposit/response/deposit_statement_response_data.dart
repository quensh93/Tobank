import 'dart:convert';

import 'package:expandable/expandable.dart';

import '../../common/error_response_data.dart';

DepositStatementResponseData depositStatementResponseDataFromJson(String str) =>
    DepositStatementResponseData.fromJson(json.decode(str));

String depositStatementResponseDataToJson(DepositStatementResponseData data) => json.encode(data.toJson());

class DepositStatementResponseData {
  DepositStatementResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory DepositStatementResponseData.fromJson(Map<String, dynamic> json) => DepositStatementResponseData(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.depositInfo,
    this.registrationDate,
    this.status,
    this.trackingNumber,
    this.transactionId,
    this.turnOvers,
  });

  DepositInfo? depositInfo;
  int? registrationDate;
  int? status;
  String? trackingNumber;
  String? transactionId;
  List<TurnOver>? turnOvers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        depositInfo: DepositInfo.fromJson(json['depositInfo']),
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        turnOvers: List<TurnOver>.from(json['turnOvers'].map((x) => TurnOver.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        'depositInfo': depositInfo!.toJson(),
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'turnOvers': List<dynamic>.from(turnOvers!.map((x) => x.toJson())),
      };
}

class DepositInfo {
  DepositInfo({
    this.balance,
    this.currencyName,
    this.depositNumber,
    this.depositable,
    this.isSpecial,
    this.special,
    this.title,
    this.withdrawable,
    this.withdrawableBalance,
  });

  int? balance;
  String? currencyName;
  String? depositNumber;
  bool? depositable;
  bool? isSpecial;
  bool? special;
  String? title;
  bool? withdrawable;
  int? withdrawableBalance;

  factory DepositInfo.fromJson(Map<String, dynamic> json) => DepositInfo(
        balance: json['balance'],
        currencyName: json['currencyName'],
        depositNumber: json['depositNumber'],
        depositable: json['depositable'],
        isSpecial: json['isSpecial'],
        special: json['special'],
        title: json['title'],
        withdrawable: json['withdrawable'],
        withdrawableBalance: json['withdrawableBalance'],
      );

  Map<String, dynamic> toJson() =>
      {
        'balance': balance,
        'currencyName': currencyName,
        'depositNumber': depositNumber,
        'depositable': depositable,
        'isSpecial': isSpecial,
        'special': special,
        'title': title,
        'withdrawable': withdrawable,
        'withdrawableBalance': withdrawableBalance,
      };
}

class TurnOver {
  TurnOver({
    this.date,
    this.balance,
    this.branchCode,
    this.debtorAmount,
    this.creditorAmount,
    this.description,
    this.time,
    this.transactionCode,
    this.voucherNumber,
  });

  String? date;
  int? balance;
  String? branchCode;
  int? debtorAmount;
  String? description;
  String? time;
  String? transactionCode;
  String? voucherNumber;
  int? creditorAmount;
  ExpandableController expandableController = ExpandableController(
    initialExpanded: false,
  );

  factory TurnOver.fromJson(Map<String, dynamic> json) => TurnOver(
        date: json['Date'],
        balance: json['balance'],
        branchCode: json['branchCode'],
        debtorAmount: json['debtorAmount'],
        creditorAmount: json['creditorAmount'],
        description: json['description'],
        time: json['time'],
        transactionCode: json['transactionCode'],
        voucherNumber: json['voucherNumber'],
      );

  Map<String, dynamic> toJson() =>
      {
        'Date': date,
        'balance': balance,
        'branchCode': branchCode,
        'debtorAmount': debtorAmount,
        'creditorAmount': creditorAmount,
        'description': description,
        'time': time,
        'transactionCode': transactionCode,
        'voucherNumber': voucherNumber,
      };
}
