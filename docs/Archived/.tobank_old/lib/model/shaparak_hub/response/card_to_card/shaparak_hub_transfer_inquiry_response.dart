import 'dart:convert';

import '../../../common/error_response_data.dart';

ShaparakHubTransferInquiryResponse shaparakHubTransferInquiryResponseFromJson(String str) =>
    ShaparakHubTransferInquiryResponse.fromJson(json.decode(str));

String shaparakHubTransferInquiryResponseToJson(ShaparakHubTransferInquiryResponse data) => json.encode(data.toJson());

class ShaparakHubTransferInquiryResponse {
  ShaparakHubTransferInquiryResponse({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ShaparakHubTransferInquiryResponse.fromJson(Map<String, dynamic> json) => ShaparakHubTransferInquiryResponse(
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
    this.status,
    this.transactionType,
    this.registrationDate,
    this.transactionDate,
  });

  int? amount;
  String? transactionId;
  String? trackingNumber;
  int? stan;
  String? rrn;
  int? status;
  int? transactionType;
  int? registrationDate;
  int? transactionDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        amount: json['amount'],
        transactionId: json['transactionId'],
        trackingNumber: json['trackingNumber'],
        stan: json['stan'],
        rrn: json['rrn'],
        status: json['status'],
        transactionType: json['transactionType'],
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
        'status': status,
        'transactionType': transactionType,
        'registrationDate': registrationDate,
        'transactionDate': transactionDate,
      };
}
