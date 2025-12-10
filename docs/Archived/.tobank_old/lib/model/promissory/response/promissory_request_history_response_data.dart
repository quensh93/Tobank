import 'dart:convert';

import '../../../util/enums_constants.dart';
import '../../common/error_response_data.dart';
import '../../transaction/response/transaction_data.dart';

PromissoryRequestHistoryResponseData promissoryRequestHistoryResponseDataFromJson(String str) =>
    PromissoryRequestHistoryResponseData.fromJson(json.decode(str));

class PromissoryRequestHistoryResponseData {
  PromissoryRequestHistoryResponseData({
    this.data,
    this.messages,
    this.success,
  });

  Data? data;
  String? messages;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory PromissoryRequestHistoryResponseData.fromJson(Map<String, dynamic> json) =>
      PromissoryRequestHistoryResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        messages: json['messages'],
        success: json['success'],
      );
}

class Data {
  List<PublishRequest>? publishRequests;
  List<EndorsementRequest>? endorsementRequests;
  List<GuaranteeRequest>? guaranteeRequests;
  List<SettlementGradualRequest>? settlementGradualRequests;
  List<SettlementRequest>? settlementRequests;

  Data({
    this.publishRequests,
    this.endorsementRequests,
    this.guaranteeRequests,
    this.settlementGradualRequests,
    this.settlementRequests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        publishRequests: json['publish'] == null
            ? []
            : List<PublishRequest>.from(json['publish']!.map((x) => PublishRequest.fromJson(x))),
        endorsementRequests: json['endorsement'] == null
            ? []
            : List<EndorsementRequest>.from(json['endorsement']!.map((x) => EndorsementRequest.fromJson(x))),
        guaranteeRequests: json['guarantee'] == null
            ? []
            : List<GuaranteeRequest>.from(json['guarantee']!.map((x) => GuaranteeRequest.fromJson(x))),
        settlementGradualRequests: json['settlement_gradual'] == null
            ? []
            : List<SettlementGradualRequest>.from(
                json['settlement_gradual']!.map((x) => SettlementGradualRequest.fromJson(x))),
        settlementRequests: json['settlement'] == null
            ? []
            : List<SettlementRequest>.from(json['settlement']!.map((x) => SettlementRequest.fromJson(x))),
      );
}

class PromissoryRequest {
  int? id;
  String? faServiceName;
  PromissoryDocType? docType;
  String? createdAt;

  PromissoryRequest({
    required this.id,
    required this.faServiceName,
    required this.docType,
    required this.createdAt,
  });
}

class PublishRequest extends PromissoryRequest {
  PromissoryCustomerType? issuerType;
  String? issuerNn;
  String? issuerCellphone;
  String? issuerFullName;
  String? issuerAccountNumber;
  String? issuerAddress;
  String? issuerPostalCode;
  PromissoryCustomerType? recipientType;
  String? recipientNn;
  String? recipientCellphone;
  String? recipientFullName;
  String? paymentPlace;
  int? amount;
  String? dueDate;
  String? description;
  bool? transferable;
  bool? isPayed;
  TransactionData? transaction;

  PublishRequest({
    super.id,
    super.faServiceName,
    super.docType,
    super.createdAt,
    this.issuerType,
    this.issuerNn,
    this.issuerCellphone,
    this.issuerFullName,
    this.issuerAccountNumber,
    this.issuerAddress,
    this.issuerPostalCode,
    this.recipientType,
    this.recipientNn,
    this.recipientCellphone,
    this.recipientFullName,
    this.paymentPlace,
    this.amount,
    this.dueDate,
    this.description,
    this.transferable,
    this.isPayed,
    this.transaction,
  });

  factory PublishRequest.fromJson(Map<String, dynamic> json) => PublishRequest(
        id: json['id'],
        faServiceName: json['faServiceName'],
        docType: json['docType'] != null ? PromissoryDocType.fromJsonValue(json['docType']) : null,
        createdAt: json['createdAt'],
        issuerType: json['issuerType'] != null ? PromissoryCustomerType.fromJsonValue(json['issuerType']) : null,
        issuerNn: json['issuerNN'],
        issuerCellphone: json['issuerCellphone'],
        issuerFullName: json['issuerFullName'],
        issuerAccountNumber: json['issuerAccountNumber'],
        issuerAddress: json['issuerAddress'],
        issuerPostalCode: json['issuerPostalCode'],
        recipientType:
            json['recipientType'] != null ? PromissoryCustomerType.fromJsonValue(json['recipientType']) : null,
        recipientNn: json['recipientNN'],
        recipientCellphone: json['recipientCellphone'],
        recipientFullName: json['recipientFullName'],
        paymentPlace: json['paymentPlace'],
        amount: json['amount'],
        dueDate: json['dueDate'],
        description: json['description'],
        transferable: json['transferable'],
        isPayed: json['isPayed'],
        transaction: json['transaction'] == null ? null : TransactionData.fromJson(json['transaction']),
      );
}

class EndorsementRequest extends PromissoryRequest {
  String? ownerNn;
  String? ownerCellphone;
  String? ownerAccountNumber;
  String? ownerAddress;
  PromissoryCustomerType? recipientType;
  String? recipientNn;
  String? recipientCellphone;
  String? recipientFullName;
  String? paymentPlace;
  String? description;
  String? promissoryId;

  EndorsementRequest({
    super.id,
    super.faServiceName,
    super.docType,
    super.createdAt,
    this.ownerNn,
    this.ownerCellphone,
    this.ownerAccountNumber,
    this.ownerAddress,
    this.recipientType,
    this.recipientNn,
    this.recipientCellphone,
    this.recipientFullName,
    this.paymentPlace,
    this.description,
    this.promissoryId,
  });

  factory EndorsementRequest.fromJson(Map<String, dynamic> json) => EndorsementRequest(
        id: json['id'],
        faServiceName: json['faServiceName'],
        docType: json['docType'] != null ? PromissoryDocType.fromJsonValue(json['docType']) : null,
        createdAt: json['createdAt'],
        ownerNn: json['ownerNN'],
        ownerCellphone: json['ownerCellphone'],
        ownerAccountNumber: json['ownerAccountNumber'],
        ownerAddress: json['ownerAddress'],
        recipientType:
            json['recipientType'] != null ? PromissoryCustomerType.fromJsonValue(json['recipientType']) : null,
        recipientNn: json['recipientNN'],
        recipientCellphone: json['recipientCellphone'],
        recipientFullName: json['recipientFullName'],
        paymentPlace: json['paymentPlace'],
        description: json['description'],
        promissoryId: json['promissoryId'],
      );
}

class GuaranteeRequest extends PromissoryRequest {
  PromissoryCustomerType? guaranteeType;
  String? guaranteeNn;
  String? guaranteeCellphone;
  String? guaranteeFullName;
  String? guaranteeAccountNumber;
  String? guaranteeAddress;
  String? paymentPlace;
  String? nationalNumber;
  String? description;
  String? promissoryId;

  GuaranteeRequest({
    super.id,
    super.faServiceName,
    super.docType,
    super.createdAt,
    this.guaranteeType,
    this.guaranteeNn,
    this.guaranteeCellphone,
    this.guaranteeFullName,
    this.guaranteeAccountNumber,
    this.guaranteeAddress,
    this.paymentPlace,
    this.nationalNumber,
    this.description,
    this.promissoryId,
  });

  factory GuaranteeRequest.fromJson(Map<String, dynamic> json) => GuaranteeRequest(
        id: json['id'],
        faServiceName: json['faServiceName'],
        docType: json['docType'] != null ? PromissoryDocType.fromJsonValue(json['docType']) : null,
        createdAt: json['createdAt'],
        guaranteeType:
            json['guaranteeType'] != null ? PromissoryCustomerType.fromJsonValue(json['guaranteeType']) : null,
        guaranteeNn: json['guaranteeNN'],
        guaranteeCellphone: json['guaranteeCellphone'],
        guaranteeFullName: json['guaranteeFullName'],
        guaranteeAccountNumber: json['guaranteeAccountNumber'],
        guaranteeAddress: json['guaranteeAddress'],
        paymentPlace: json['paymentPlace'],
        nationalNumber: json['nationalNumber'],
        description: json['description'],
        promissoryId: json['promissoryId'],
      );
}

class SettlementRequest extends PromissoryRequest {
  String? ownerNn;
  int? settlementAmount;
  String? promissoryId;

  SettlementRequest({
    super.id,
    super.faServiceName,
    super.docType,
    super.createdAt,
    this.ownerNn,
    this.settlementAmount,
    this.promissoryId,
  });

  factory SettlementRequest.fromJson(Map<String, dynamic> json) => SettlementRequest(
        id: json['id'],
        faServiceName: json['faServiceName'],
        docType: json['docType'] != null ? PromissoryDocType.fromJsonValue(json['docType']) : null,
        createdAt: json['createdAt'],
        ownerNn: json['ownerNN'],
        settlementAmount: json['settlementAmount'],
        promissoryId: json['promissoryId'],
      );
}

class SettlementGradualRequest extends PromissoryRequest {
  String? ownerNn;
  int? settlementAmount;
  String? promissoryId;

  SettlementGradualRequest({
    super.id,
    super.faServiceName,
    super.docType,
    super.createdAt,
    this.ownerNn,
    this.settlementAmount,
    this.promissoryId,
  });

  factory SettlementGradualRequest.fromJson(Map<String, dynamic> json) => SettlementGradualRequest(
        id: json['id'],
        faServiceName: json['faServiceName'],
        docType: json['docType'] != null ? PromissoryDocType.fromJsonValue(json['docType']) : null,
        createdAt: json['createdAt'],
        ownerNn: json['ownerNN'],
        settlementAmount: json['settlementAmount'],
        promissoryId: json['promissoryId'],
      );
}
