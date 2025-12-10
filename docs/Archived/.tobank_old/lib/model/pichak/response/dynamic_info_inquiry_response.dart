import 'dart:convert';

import '../error_response_pichak_data.dart';

DynamicInfoInquiryResponse dynamicInfoInquiryResponseFromJson(String str) =>
    DynamicInfoInquiryResponse.fromJson(json.decode(str));

String dynamicInfoInquiryResponseToJson(DynamicInfoInquiryResponse data) => json.encode(data.toJson());

class DynamicInfoInquiryResponse {
  DynamicInfoInquiryResponse({
    this.chequeId,
    this.serialNo,
    this.fromIban,
    this.amount,
    this.dueDate,
    this.description,
    this.bankCode,
    this.branchCode,
    this.chequeType,
    this.chequeMedia,
    this.currency,
    this.chequeStatus,
    this.guaranteeStatus,
    this.blockStatus,
    this.locked,
    this.chequeReceivers,
    this.reason,
    this.requestId,
  });

  String? requestId;
  late ErrorResponsePichakData errorResponsePichakData;
  int? statusCode;
  String? chequeId;
  String? serialNo;
  String? fromIban;
  int? amount;
  int? dueDate;
  String? description;
  String? bankCode;
  String? branchCode;
  int? chequeType;
  int? chequeMedia;
  int? currency;
  int? chequeStatus;
  int? guaranteeStatus;
  int? blockStatus;
  int? locked;
  List<ChequeReceiver>? chequeReceivers;
  String? reason;

  factory DynamicInfoInquiryResponse.fromJson(Map<String, dynamic> json) => DynamicInfoInquiryResponse(
        chequeId: json['chequeId'],
        serialNo: json['serialNo'],
        fromIban: json['fromIban'],
        amount: json['amount'],
        dueDate: json['dueDate'],
        description: json['description'],
        bankCode: json['bankCode'],
        branchCode: json['branchCode'],
        chequeType: json['chequeType'],
        chequeMedia: json['chequeMedia'],
        currency: json['currency'],
        chequeStatus: json['chequeStatus'],
        guaranteeStatus: json['guaranteeStatus'],
        blockStatus: json['blockStatus'],
        locked: json['locked'],
    requestId: json['requestId'],
        chequeReceivers: json['chequeReceivers'] == null
            ? null
            : List<ChequeReceiver>.from(json['chequeReceivers'].map((x) => ChequeReceiver.fromJson(x))),
        reason: json['reason'],
      );

  Map<String, dynamic> toJson() => {
        'chequeId': chequeId,
        'serialNo': serialNo,
        'fromIban': fromIban,
        'amount': amount,
        'dueDate': dueDate,
        'description': description,
        'bankCode': bankCode,
        'branchCode': branchCode,
        'chequeType': chequeType,
        'chequeMedia': chequeMedia,
        'currency': currency,
        'chequeStatus': chequeStatus,
        'guaranteeStatus': guaranteeStatus,
        'blockStatus': blockStatus,
        'locked': locked,
        'chequeReceivers': chequeReceivers == null ? null : List<dynamic>.from(chequeReceivers!.map((x) => x.toJson())),
        'reason': reason,
      };
}

class ChequeReceiver {
  ChequeReceiver({
    this.fullName,
    this.personType,
    this.nationalId,
  });

  String? fullName;
  int? personType;
  String? nationalId;

  factory ChequeReceiver.fromJson(Map<String, dynamic> json) => ChequeReceiver(
        fullName: json['fullName'],
        personType: json['personType'],
        nationalId: json['nationalId'],
      );

  Map<String, dynamic> toJson() =>
      {
        'fullName': fullName,
        'personType': personType,
        'nationalId': nationalId,
      };
}
