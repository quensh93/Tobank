import '../../../service/core/api_request_model.dart';
import '../../../util/enums_constants.dart';

class ChargeWalletRequestData extends ApiRequestModel {
  ChargeWalletRequestData({
    required this.amount,
    required this.transactionType,
    required this.depositNumber,
    this.token,
  });

  int amount;
  PaymentType transactionType;
  String? depositNumber;
  String? token;

  @override
  Map<String, dynamic> toJson() => {
        'amount': amount,
        'transaction_type': transactionType.name,
        'deposit_number': depositNumber,
        'token': token,
      };
}
