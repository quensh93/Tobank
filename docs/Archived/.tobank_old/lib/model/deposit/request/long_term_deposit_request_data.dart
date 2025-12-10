import '../../../service/core/api_request_model.dart';

class LongTermDepositRequestData extends ApiRequestModel {
  LongTermDepositRequestData({
    this.trackingNumber,
    this.depositTypeCode,
    this.customerNumber,
    this.amount,
    this.sourceDepositNumber,
    this.interestDepositNumber,
    this.branchCode,
  });

  String? trackingNumber;
  String? depositTypeCode;
  String? customerNumber;
  int? amount;
  String? sourceDepositNumber;
  String? interestDepositNumber;
  String? branchCode;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'depositTypeCode': depositTypeCode,
        'customerNumber': customerNumber,
        'amount': amount,
        'sourceDepositNumber': sourceDepositNumber,
        'interestDepositNumber': interestDepositNumber,
        'branchCode': branchCode,
      };
}
