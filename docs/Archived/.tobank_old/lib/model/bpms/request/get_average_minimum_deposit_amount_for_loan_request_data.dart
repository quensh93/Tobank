import '../../../service/core/api_request_model.dart';

class GetAverageMinimumDepositAmountForLoanRequest extends ApiRequestModel {
  String? trackingNumber;
  String? customerNumber;
  String? deposit;
  String? processKey;

  GetAverageMinimumDepositAmountForLoanRequest({
    this.trackingNumber,
    this.customerNumber,
    this.deposit,
    this.processKey,
  });

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'deposit': deposit,
        'processKey': processKey,
      };
}
