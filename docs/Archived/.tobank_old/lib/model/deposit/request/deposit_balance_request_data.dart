import '../../../service/core/api_request_model.dart';

class DepositBalanceRequestData extends ApiRequestModel {
  DepositBalanceRequestData({
    this.trackingNumber,
    this.depositNumber,
    this.customerNumber,
  });

  String? trackingNumber;
  String? depositNumber;
  String? customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'depositNumber': depositNumber,
        'customerNumber': customerNumber,
      };
}
