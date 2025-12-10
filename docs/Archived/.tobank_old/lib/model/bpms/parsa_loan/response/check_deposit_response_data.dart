import 'dart:convert';

import '../loan_detail.dart';

CheckDepositResponseData checkDepositResponseDataFromJson(String str) =>
    CheckDepositResponseData.fromJson(json.decode(str));

class CheckDepositResponseData {
  String? message;
  bool? success;
  Data? data;

  CheckDepositResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory CheckDepositResponseData.fromJson(Map<String, dynamic> json) => CheckDepositResponseData(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );
}

class Data {
  LoanDetail? loanDetail;
  DepositInfo? depositInfo;

  Data({
    this.loanDetail,
    this.depositInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        loanDetail: json['loan_detail'] == null ? null : LoanDetail.fromJson(json['loan_detail']),
        depositInfo: json['deposit_info'] == null ? null : DepositInfo.fromJson(json['deposit_info']),
      );
}

class DepositInfo {
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
  String? portion;
  String? isSpecial;
  String? fullName;
  String? individualOrSharedDeposit;
  String? openingDate;
  List<SignerInfo>? signerInfo;

  DepositInfo({
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
    this.portion,
    this.isSpecial,
    this.fullName,
    this.individualOrSharedDeposit,
    this.openingDate,
    this.signerInfo,
  });

  factory DepositInfo.fromJson(Map<String, dynamic> json) => DepositInfo(
        depositNumber: json['depositNumber'],
        mainCustomerNumber: json['mainCustomerNumber'],
        depositTitle: json['depositTitle'],
        depositTypeNumber: json['depositTypeNumber'],
        depositTypeTitle: json['depositTypeTitle'],
        customerRelationWithDepositPersian: json['customerRelationWithDepositPersian'],
        customerRelationWithDepositEnglish: json['customerRelationWithDepositEnglish'],
        depositState: json['depositState'],
        currencyName: json['currencyName'],
        currencySwiftCode: json['currencySwiftCode'],
        withdrawRight: json['withdrawRight'],
        branchCode: json['branchCode'],
        depositIban: json['depositIban'],
        portion: json['portion'],
        isSpecial: json['isSpecial'],
        fullName: json['fullName'],
        individualOrSharedDeposit: json['individualOrSharedDeposit'],
        openingDate: json['openingDate'],
        signerInfo: json['signerInfo'] == null
            ? []
            : List<SignerInfo>.from(json['signerInfo']!.map((x) => SignerInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'depositNumber': depositNumber,
        'mainCustomerNumber': mainCustomerNumber,
        'depositTitle': depositTitle,
        'depositTypeNumber': depositTypeNumber,
        'depositTypeTitle': depositTypeTitle,
        'customerRelationWithDepositPersian': customerRelationWithDepositPersian,
        'customerRelationWithDepositEnglish': customerRelationWithDepositEnglish,
        'depositState': depositState,
        'currencyName': currencyName,
        'currencySwiftCode': currencySwiftCode,
        'withdrawRight': withdrawRight,
        'branchCode': branchCode,
        'depositIban': depositIban,
        'portion': portion,
        'isSpecial': isSpecial,
        'fullName': fullName,
        'individualOrSharedDeposit': individualOrSharedDeposit,
        'openingDate': openingDate,
        'signerInfo': signerInfo == null ? [] : List<dynamic>.from(signerInfo!.map((x) => x.toJson())),
      };
}

class SignerInfo {
  String? customerNumber;
  String? portion;
  String? customerRelationWithDepositPersian;
  String? customerRelationWithDepositEnglish;
  String? fullName;

  SignerInfo({
    this.customerNumber,
    this.portion,
    this.customerRelationWithDepositPersian,
    this.customerRelationWithDepositEnglish,
    this.fullName,
  });

  factory SignerInfo.fromJson(Map<String, dynamic> json) => SignerInfo(
        customerNumber: json['customerNumber'],
        portion: json['portion'],
        customerRelationWithDepositPersian: json['customerRelationWithDepositPersian'],
        customerRelationWithDepositEnglish: json['customerRelationWithDepositEnglish'],
        fullName: json['fullName'],
      );

  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'portion': portion,
        'customerRelationWithDepositPersian': customerRelationWithDepositPersian,
        'customerRelationWithDepositEnglish': customerRelationWithDepositEnglish,
        'fullName': fullName,
      };
}
