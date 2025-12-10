import '../../../service/core/api_request_model.dart';

class UserProcessInstancesRequest extends ApiRequestModel {
  UserProcessInstancesRequest({
    required this.customerNumber,
    required this.trackingNumber,
  });

  String customerNumber;
  String trackingNumber;

  @override
  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'trackingNumber': trackingNumber,
      };
}
