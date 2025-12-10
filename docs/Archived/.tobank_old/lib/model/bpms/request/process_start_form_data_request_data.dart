import '../../../service/core/api_request_model.dart';

class ProcessStartFormDataRequest extends ApiRequestModel {
  ProcessStartFormDataRequest({
    required this.processDefinitionKey,
    required this.processDefinitionVersion,
    required this.trackingNumber,
  });

  String processDefinitionKey;
  int processDefinitionVersion;
  String trackingNumber;

  @override
  Map<String, dynamic> toJson() => {
        'processDefinitionKey': processDefinitionKey,
        'processDefinitionVersion': processDefinitionVersion,
        'trackingNumber': trackingNumber,
      };
}
