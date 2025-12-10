class IncreaseDepositBalanceResponseData {
  IncreaseDepositBalanceResponseData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;

  factory IncreaseDepositBalanceResponseData.fromJson(Map<String, dynamic> json) => IncreaseDepositBalanceResponseData(
        data: Data.fromJson(json['data']),
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'success': success,
      };
}

class Data {
  Data({
    this.transactionId,
    this.url,
  });

  int? transactionId;
  String? url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId: json['transaction_id'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'transaction_id': transactionId,
        'url': url,
      };
}
