import '../../../service/core/api_request_model.dart';

class DepositTypeRequestData extends ApiRequestModel {
  DepositTypeRequestData({
    this.trackingNumber,
    this.customerNumber,
  });

  String? trackingNumber;
  String? customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
      };
}
