import '../../../service/core/api_request_model.dart';

class ProcessDetailRequest extends ApiRequestModel {
  ProcessDetailRequest({
    required this.customerNumber,
    required this.processInstanceId,
    required this.trackingNumber,
  });

  String customerNumber;
  String processInstanceId;
  String trackingNumber;

  @override
  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'processInstanceId': processInstanceId,
        'trackingNumber': trackingNumber,
      };
}
