import 'dart:convert';

import '../../common/error_response_data.dart';

TransferHistoryResponseData transferHistoryResponseDataFromJson(String str) =>
    TransferHistoryResponseData.fromJson(json.decode(str));

String transferHistoryResponseDataToJson(TransferHistoryResponseData data) => json.encode(data.toJson());

class TransferHistoryResponseData {
  TransferHistoryResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory TransferHistoryResponseData.fromJson(Map<String, dynamic> json) => TransferHistoryResponseData(
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
    this.message,
    this.registrationDate,
    this.status,
    this.trackingNumber,
    this.transactionId,
    this.transactions,
  });

  String? message;
  int? registrationDate;
  int? status;
  String? trackingNumber;
  String? transactionId;
  List<Transaction>? transactions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json['message'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        transactions: json['transactions'] == null
            ? null
            : List<Transaction>.from(json['transactions'].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'transactions': transactions == null ? null : List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.amount,
    this.destinationDepositNumber,
    this.destinationIban,
    this.externalTransactionDate,
    this.financialTransactionDate,
    this.financialTransactionId,
    this.financialTransactionStatus,
    this.localDescription,
    this.purpose,
    this.receiverFirstName,
    this.receiverLastName,
    this.referenceNumber,
    this.sourceDepositNumber,
    this.trackingNumber,
    this.transactionDescription,
    this.transactionId,
    this.transferType,
    this.message,
    this.transferMessage,
    this.externalTransactionId,
  });

  int? amount;
  String? destinationDepositNumber;
  String? destinationIban;
  int? externalTransactionDate;
  int? financialTransactionDate;
  String? financialTransactionId;
  int? financialTransactionStatus;
  String? localDescription;
  int? purpose;
  String? receiverFirstName;
  String? receiverLastName;
  String? referenceNumber;
  String? sourceDepositNumber;
  String? trackingNumber;
  String? transactionDescription;
  String? transactionId;
  int? transferType;
  String? message;
  String? transferMessage;
  String? externalTransactionId;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json['amount'],
        destinationDepositNumber: json['destinationDepositNumber'],
        externalTransactionDate: json['externalTransactionDate'],
        financialTransactionDate: json['financialTransactionDate'],
        destinationIban: json['destinationIban'],
        financialTransactionId: json['financialTransactionId'],
        financialTransactionStatus: json['financialTransactionStatus'],
        localDescription: json['localDescription'],
        purpose: json['purpose'],
        receiverFirstName: json['receiverFirstName'],
        receiverLastName: json['receiverLastName'],
        referenceNumber: json['referenceNumber'],
        sourceDepositNumber: json['sourceDepositNumber'],
        trackingNumber: json['trackingNumber'],
        transactionDescription: json['transactionDescription'],
        transactionId: json['transactionId'],
        transferType: json['transferType'],
        message: json['message'],
        transferMessage: json['transfer_message'],
        externalTransactionId: json['externalTransactionId'],
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'destinationDepositNumber': destinationDepositNumber,
        'externalTransactionDate': externalTransactionDate,
        'financialTransactionDate': financialTransactionDate,
        'destinationIban': destinationIban,
        'financialTransactionId': financialTransactionId,
        'financialTransactionStatus': financialTransactionStatus,
        'localDescription': localDescription,
        'purpose': purpose,
        'receiverFirstName': receiverFirstName,
        'receiverLastName': receiverLastName,
        'referenceNumber': referenceNumber,
        'sourceDepositNumber': sourceDepositNumber,
        'trackingNumber': trackingNumber,
        'transactionDescription': transactionDescription,
        'transactionId': transactionId,
        'transferType': transferType,
        'message': message,
        'transfer_message': transferMessage,
        'externalTransactionId': externalTransactionId,
      };
}
