import 'dart:convert';

import '../../common/error_response_data.dart';

BillInquiryDataResponse billInquiryDataResponseFromJson(String str) =>
    BillInquiryDataResponse.fromJson(json.decode(str));

String billInquiryDataResponseToJson(BillInquiryDataResponse data) => json.encode(data.toJson());

class BillInquiryDataResponse {
  BillInquiryDataResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory BillInquiryDataResponse.fromJson(Map<String, dynamic> json) => BillInquiryDataResponse(
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
    this.amount,
    this.billId,
    this.payId,
    this.type,
  });

  int? amount;
  String? billId;
  String? payId;
  String? type;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        amount: json['amount'],
        billId: json['bill_id'].toString(),
        payId: json['pay_id'].toString(),
        type: json['type'],
      );

  Map<String, dynamic> toJson() =>
      {
        'amount': amount,
        'bill_id': billId,
        'pay_id': payId,
        'type': type,
      };
}
