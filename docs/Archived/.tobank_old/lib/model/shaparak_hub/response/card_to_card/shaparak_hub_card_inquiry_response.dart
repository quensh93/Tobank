import 'dart:convert';

import '../../../common/error_response_data.dart';

ShaparakHubCardInquiryResponse shaparakHubCardInquiryResponseFromJson(String str) =>
    ShaparakHubCardInquiryResponse.fromJson(json.decode(str));

String shaparakHubCardInquiryResponseToJson(ShaparakHubCardInquiryResponse data) => json.encode(data.toJson());

class ShaparakHubCardInquiryResponse {
  ShaparakHubCardInquiryResponse({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ShaparakHubCardInquiryResponse.fromJson(Map<String, dynamic> json) => ShaparakHubCardInquiryResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
      };
}

class Data {
  Data({
    this.amount,
    this.transactionId,
    this.trackingNumber,
    this.stan,
    this.rrn,
    this.cardHolderName,
    this.approvalCode,
    this.status,
    this.registrationDate,
    this.transactionDate,
  });

  int? amount;
  String? transactionId;
  String? trackingNumber;
  int? stan;
  String? rrn;
  String? cardHolderName;
  String? approvalCode;
  int? status;
  int? registrationDate;
  int? transactionDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        amount: json['amount'],
        transactionId: json['transactionId'],
        trackingNumber: json['trackingNumber'],
        stan: json['stan'],
        rrn: json['rrn'],
        cardHolderName: json['cardHolderName'],
        approvalCode: json['approvalCode'],
        status: json['status'],
        registrationDate: json['registrationDate'],
        transactionDate: json['transactionDate'],
      );

  Map<String, dynamic> toJson() =>
      {
        'amount': amount,
        'transactionId': transactionId,
        'trackingNumber': trackingNumber,
        'stan': stan,
        'rrn': rrn,
        'cardHolderName': cardHolderName,
        'approvalCode': approvalCode,
        'status': status,
        'registrationDate': registrationDate,
        'transactionDate': transactionDate,
      };
}
