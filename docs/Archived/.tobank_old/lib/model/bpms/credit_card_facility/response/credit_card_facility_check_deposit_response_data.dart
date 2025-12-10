import 'dart:convert';

import '../../../common/error_response_data.dart';

CreditCardFacilityCheckDepositResponseData creditCardFacilityCheckDepositResponseDataFromJson(String str) =>
    CreditCardFacilityCheckDepositResponseData.fromJson(json.decode(str));

String creditCardFacilityCheckDepositResponseDataToJson(CreditCardFacilityCheckDepositResponseData data) =>
    json.encode(data.toJson());

class CreditCardFacilityCheckDepositResponseData {
  bool? success;
  Data? data;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  CreditCardFacilityCheckDepositResponseData({
    this.success,
    this.data,
    this.message,
  });

  factory CreditCardFacilityCheckDepositResponseData.fromJson(Map<String, dynamic> json) =>
      CreditCardFacilityCheckDepositResponseData(
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'message': message,
      };
}

class Data {
  int? averageDepositAmount;
  List<LoanData>? loanData;

  Data({
    this.averageDepositAmount,
    this.loanData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        averageDepositAmount: json['average_deposit_amount'],
        loanData:
            json['loan_data'] == null ? [] : List<LoanData>.from(json['loan_data']!.map((x) => LoanData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'average_deposit_amount': averageDepositAmount,
        'loan_data': loanData == null ? [] : List<dynamic>.from(loanData!.map((x) => x.toJson())),
      };
}

class LoanData {
  int? month;
  int? amount;

  LoanData({
    this.month,
    this.amount,
  });

  factory LoanData.fromJson(Map<String, dynamic> json) => LoanData(
        month: json['month'],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() => {
        'month': month,
        'amount': amount,
      };
}
