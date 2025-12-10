import '../../../service/core/api_request_model.dart';

class StartProcessRequest<T extends StartProcessRequestVariables> extends ApiRequestModel {
  StartProcessRequest({
    required this.customerNumber,
    required this.returnNextTasks,
    required this.processDefinitionKey,
    required this.businessKey,
    required this.trackingNumber,
    required this.variables,
  });

  String customerNumber;
  bool returnNextTasks;
  String processDefinitionKey;
  String businessKey;
  String trackingNumber;
  T variables;

  @override
  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'returnNextTasks': returnNextTasks,
        'processDefinitionKey': processDefinitionKey,
        'businessKey': businessKey,
        'trackingNumber': trackingNumber,
        'variables': variables.toJson(),
      };
}

abstract class StartProcessRequestVariables extends ApiRequestModel {}
