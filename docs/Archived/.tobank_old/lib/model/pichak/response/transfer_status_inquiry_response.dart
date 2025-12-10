import 'dart:convert';

import '../error_response_pichak_data.dart';

TransferStatusInquiryResponse transferStatusInquiryResponseFromJson(String str) =>
    TransferStatusInquiryResponse.fromJson(json.decode(str));

String transferStatusInquiryResponseToJson(TransferStatusInquiryResponse data) => json.encode(data.toJson());

class TransferStatusInquiryResponse {
  TransferStatusInquiryResponse({
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
    this.chequeHolders,
  });

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
  List<ChequeHolder>? chequeHolders;
  int? statusCode;
  late ErrorResponsePichakData errorResponsePichakData;

  factory TransferStatusInquiryResponse.fromJson(Map<String, dynamic> json) => TransferStatusInquiryResponse(
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
        chequeHolders: json['chequeHolders'] == null
            ? null
            : List<ChequeHolder>.from(json['chequeHolders'].map((x) => ChequeHolder.fromJson(x))),
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
        'chequeHolders': chequeHolders == null ? null : List<dynamic>.from(chequeHolders!.map((x) => x.toJson())),
      };
}

class ChequeHolder {
  ChequeHolder({
    this.fullName,
    this.personType,
    this.nationalId,
    this.transferAction,
    this.lastActionDate,
  });

  String? fullName;
  int? personType;
  String? nationalId;
  int? transferAction;
  int? lastActionDate;

  factory ChequeHolder.fromJson(Map<String, dynamic> json) => ChequeHolder(
        fullName: json['fullName'],
        personType: json['personType'],
        nationalId: json['nationalId'],
        transferAction: json['transferAction'],
        lastActionDate: json['lastActionDate'],
      );

  Map<String, dynamic> toJson() =>
      {
        'fullName': fullName,
        'personType': personType,
        'nationalId': nationalId,
        'transferAction': transferAction,
        'lastActionDate': lastActionDate,
      };
}
