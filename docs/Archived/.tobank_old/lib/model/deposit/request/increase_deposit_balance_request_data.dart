import '../../../service/core/api_request_model.dart';

class IncreaseDepositBalanceRequestData extends ApiRequestModel {
  IncreaseDepositBalanceRequestData({
    required this.amount,
    required this.depositNumber,
  });

  int amount;
  String depositNumber;

  @override
  Map<String, dynamic> toJson() => {
        'amount': amount,
        'deposit_number': depositNumber,
      };
}
