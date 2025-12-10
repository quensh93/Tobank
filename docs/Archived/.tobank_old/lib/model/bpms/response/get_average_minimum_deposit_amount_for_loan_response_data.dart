import 'dart:convert';

import '../../common/error_response_data.dart';

GetAverageMinimumDepositAmountForLoanResponse getAverageMinimumDepositAmountForLoanResponseFromJson(String str) =>
    GetAverageMinimumDepositAmountForLoanResponse.fromJson(json.decode(str));

String getAverageMinimumDepositAmountForLoanResponseToJson(GetAverageMinimumDepositAmountForLoanResponse data) =>
    json.encode(data.toJson());

class GetAverageMinimumDepositAmountForLoanResponse {
  String? message;
  bool? success;
  Data? data;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  GetAverageMinimumDepositAmountForLoanResponse({
    this.message,
    this.success,
    this.data,
  });

  factory GetAverageMinimumDepositAmountForLoanResponse.fromJson(Map<String, dynamic> json) =>
      GetAverageMinimumDepositAmountForLoanResponse(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  int? processMinimum;
  int? depositMinimum;
  int? checkedDays;
  bool? isConfirmed;

  Data({
    this.processMinimum,
    this.depositMinimum,
    this.checkedDays,
    this.isConfirmed,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        processMinimum: json['process_minimum'],
        depositMinimum: json['deposit_minimum'],
        checkedDays: json['checked_days'],
        isConfirmed: json['is_confirmed'],
      );

  Map<String, dynamic> toJson() => {
        'process_minimum': processMinimum,
        'deposit_minimum': depositMinimum,
        'checked_days': checkedDays,
        'is_confirmed': isConfirmed,
      };
}
