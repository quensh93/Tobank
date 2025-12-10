import 'dart:convert';

import '../error_response_pichak_data.dart';

StaticInfoInquiryResponse staticInfoInquiryResponseFromJson(String str) =>
    StaticInfoInquiryResponse.fromJson(json.decode(str));

String staticInfoInquiryResponseToJson(StaticInfoInquiryResponse data) => json.encode(data.toJson());

class StaticInfoInquiryResponse {
  StaticInfoInquiryResponse({
    this.serialNo,
    this.seriesNo,
    this.fromIban,
    this.accountOwners,
    this.signers,
    this.bankCode,
    this.branchCode,
    this.currency,
    this.requestId,
  });

  late ErrorResponsePichakData errorResponsePichakData;
  int? statusCode;
  String? serialNo;
  String? seriesNo;
  String? fromIban;
  List<Ner>? accountOwners;
  List<Ner>? signers;
  String? bankCode;
  String? branchCode;
  int? currency;
  String? requestId;

  factory StaticInfoInquiryResponse.fromJson(Map<String, dynamic> json) => StaticInfoInquiryResponse(
        serialNo: json['serialNo'],
        seriesNo: json['seriesNo'],
        fromIban: json['fromIban'],
        accountOwners:
            json['accountOwners'] == null ? null : List<Ner>.from(json['accountOwners'].map((x) => Ner.fromJson(x))),
        signers: json['signers'] == null ? null : List<Ner>.from(json['signers'].map((x) => Ner.fromJson(x))),
        bankCode: json['bankCode'],
        branchCode: json['branchCode'],
        currency: json['currency'],
    requestId: json['requestId'],
      );

  Map<String, dynamic> toJson() => {
        'serialNo': serialNo,
        'seriesNo': seriesNo,
        'fromIban': fromIban,
        'accountOwners': accountOwners == null ? null : List<dynamic>.from(accountOwners!.map((x) => x.toJson())),
        'signers': signers == null ? null : List<dynamic>.from(signers!.map((x) => x.toJson())),
        'bankCode': bankCode,
        'branchCode': branchCode,
        'currency': currency,
        'requestId': requestId,
      };
}

class Ner {
  Ner({
    this.fullName,
    this.personType,
  });

  String? fullName;
  int? personType;

  factory Ner.fromJson(Map<String, dynamic> json) => Ner(
        fullName: json['fullName'],
        personType: json['personType'],
      );

  Map<String, dynamic> toJson() =>
      {
        'fullName': fullName,
        'personType': personType,
      };
}
