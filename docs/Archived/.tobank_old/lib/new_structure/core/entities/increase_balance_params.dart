import 'enums.dart';

class IncreaseBalanceParams {
  final int amount;
  final String depositNumber;
  final ChargeServiceType service;
  final String? token;

  const IncreaseBalanceParams({
    required this.amount,
    required this.depositNumber,
    required this.service,
    this.token,
  });

  factory IncreaseBalanceParams.fromJson(Map<String, dynamic> json) {
    return IncreaseBalanceParams(
      service:ChargeServiceType.fromJson(json['amount']),
      amount: json['amount'] as int,
      depositNumber: json['deposit_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'service':service.toJson(),
      'amount': amount,
      'deposit_number': depositNumber.trim(),
      'token': token,
    };

    return data;
  }

  @override
  String toString() {
    return 'IncreaseBalanceParams(\n'
        'amount: $amount\n'
        'depositNumber: "$depositNumber"\n'
        'token: "$token"\n'
        ')';
  }
}