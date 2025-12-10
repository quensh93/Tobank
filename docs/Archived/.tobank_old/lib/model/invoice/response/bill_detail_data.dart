import 'dart:convert';

import '../../common/error_response_data.dart';

BillDetailData billDetailDataFromJson(String str) => BillDetailData.fromJson(json.decode(str));

String billDetailDataToJson(BillDetailData data) => json.encode(data.toJson());

class BillDetailData {
  BillDetailData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory BillDetailData.fromJson(Map<String, dynamic> json) => BillDetailData(
        data: Data.fromJson(json['data']),
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data!.toJson(),
        'success': success,
      };
}

class Data {
  Data({
    this.amount,
    this.billType,
    this.companyName,
    this.requestData,
    this.requestDateTime,
    this.status,
    this.statusDescription,
    this.subUtilityCode,
    this.utilityCode,
  });

  int? amount;
  String? billType;
  String? companyName;
  RequestData? requestData;
  String? requestDateTime;
  int? status;
  String? statusDescription;
  String? subUtilityCode;
  String? utilityCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        amount: json['amount'],
        billType: json['bill_type'],
        companyName: json['company_name'],
        requestData: RequestData.fromJson(json['request_data']),
        requestDateTime: json['request_date_time'],
        status: json['status'],
        statusDescription: json['status_description'],
        subUtilityCode: json['sub_utility_code'],
        utilityCode: json['utility_code'],
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'bill_type': billType,
        'company_name': companyName,
        'request_data': requestData!.toJson(),
        'request_date_time': requestDateTime,
        'status': status,
        'status_description': statusDescription,
        'sub_utility_code': subUtilityCode,
        'utility_code': utilityCode,
      };
}

class RequestData {
  RequestData({
    this.billId,
    this.payId,
  });

  String? billId;
  String? payId;

  factory RequestData.fromJson(Map<String, dynamic> json) => RequestData(
        billId: json['bill_id'],
        payId: json['pay_id'],
      );

  Map<String, dynamic> toJson() =>
      {
        'bill_id': billId,
        'pay_id': payId,
      };
}
