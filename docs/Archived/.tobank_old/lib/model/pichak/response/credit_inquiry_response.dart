import 'dart:convert';

import '../error_response_pichak_data.dart';

CreditInquiryResponse creditInquiryResponseFromJson(String str) => CreditInquiryResponse.fromJson(json.decode(str));

String creditInquiryResponseToJson(CreditInquiryResponse data) => json.encode(data.toJson());

class CreditInquiryResponse {
  CreditInquiryResponse({
    this.iban,
    this.bankCode,
    this.bankName,
    this.branchCode,
    this.accountOwners,
  });

  late ErrorResponsePichakData errorResponsePichakData;
  int? statusCode;
  String? iban;
  int? bankCode;
  String? bankName;
  String? branchCode;
  List<AccountOwner>? accountOwners;

  factory CreditInquiryResponse.fromJson(Map<String, dynamic> json) => CreditInquiryResponse(
        iban: json['iban'],
        bankCode: json['bankCode'],
        bankName: json['bankName'],
        branchCode: json['branchCode'],
        accountOwners: json['accountOwners'] == null
            ? null
            : List<AccountOwner>.from(json['accountOwners'].map((x) => AccountOwner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'iban': iban,
        'bankCode': bankCode,
        'bankName': bankName,
        'branchCode': branchCode,
        'accountOwners': accountOwners == null ? null : List<dynamic>.from(accountOwners!.map((x) => x.toJson())),
      };
}

class AccountOwner {
  AccountOwner({
    this.fullName,
    this.returnedChequeCount,
    this.lastUpdate,
    this.status,
  });

  String? fullName;
  dynamic returnedChequeCount;
  int? lastUpdate;
  String? status;

  factory AccountOwner.fromJson(Map<String, dynamic> json) => AccountOwner(
        fullName: json['fullName'],
        returnedChequeCount: json['returnedChequeCount'],
        lastUpdate: json['LastUpdate'],
        status: json['Status'],
      );

  Map<String, dynamic> toJson() =>
      {
        'fullName': fullName,
        'returnedChequeCount': returnedChequeCount,
        'LastUpdate': lastUpdate,
        'Status': status,
      };
}
