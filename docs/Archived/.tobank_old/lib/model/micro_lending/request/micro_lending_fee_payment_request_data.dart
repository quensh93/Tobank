import '../../../service/core/api_request_model.dart';
import '../../../util/enums_constants.dart';

class MicroLendingFeePaymentRequest extends ApiRequestModel {
  PaymentType transactionType;
  String? depositNumber;

  MicroLendingFeePaymentRequest({
    required this.transactionType,
    required this.depositNumber,
  });

  @override
  Map<String, dynamic> toJson() => {
        'transaction_type': transactionType.name,
        'deposit_number': depositNumber,
      };
}
