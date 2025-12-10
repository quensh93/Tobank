import 'dart:convert';

import '../../common/error_response_data.dart';
import '../../common/gateway_pay_data.dart';
import 'transaction_data.dart';

TransactionDataResponse transactionDataResponseFromJson(String str) =>
    TransactionDataResponse.fromJson(json.decode(str));

String transactionDataResponseToJson(TransactionDataResponse data) => json.encode(data.toJson());

class TransactionDataResponse {
  TransactionDataResponse({
    this.data,
    this.success,
  });

  TransactionData? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;
  late GatewayPayData gatewayPayData;

  factory TransactionDataResponse.fromJson(Map<String, dynamic> json) => TransactionDataResponse(
        data: json['data'] == null ? null : TransactionData.fromJson(json['data']),
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'success': success,
      };
}
