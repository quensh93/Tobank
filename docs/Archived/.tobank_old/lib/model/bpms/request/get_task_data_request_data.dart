import '../../../service/core/api_request_model.dart';

class GetTaskDataRequest extends ApiRequestModel {
  GetTaskDataRequest({
    required this.customerNumber,
    required this.nationalId,
    required this.personalityType,
    required this.taskId,
    required this.trackingNumber,
  });

  String customerNumber;
  String nationalId;
  int personalityType;
  String taskId;
  String trackingNumber;

  @override
  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'nationalId': nationalId,
        'personalityType': personalityType,
        'taskId': taskId,
        'trackingNumber': trackingNumber,
      };
}
