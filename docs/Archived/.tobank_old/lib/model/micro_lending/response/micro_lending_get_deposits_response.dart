import '../../deposit/response/customer_deposits_response_data.dart';

class MicroLendingGetDepositsResponse {
  MicroLendingGetDepositsResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory MicroLendingGetDepositsResponse.fromJson(Map<String, dynamic> json) => MicroLendingGetDepositsResponse(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.depositList,
  });

  List<Deposit>? depositList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        depositList: json['deposit_list'] == null
            ? null
            : List<Deposit>.from(json['deposit_list'].map((x) => Deposit.fromJson(x))),
      );
}
