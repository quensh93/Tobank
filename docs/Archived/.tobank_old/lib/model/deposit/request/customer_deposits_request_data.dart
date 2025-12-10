import '../../../service/core/api_request_model.dart';

class CustomerDepositsRequest extends ApiRequestModel {
  CustomerDepositsRequest({
    required this.trackingNumber,
    required this.customerNumber,
  });

  String trackingNumber;
  String customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
      };
}
