import '../../../service/core/api_request_model.dart';

class CompleteTaskRequest<T extends CompleteTaskRequestData> extends ApiRequestModel {
  CompleteTaskRequest({
    required this.customerNumber,
    required this.nationalId,
    required this.personalityType,
    required this.taskId,
    required this.trackingNumber,
    required this.taskData,
  });

  String customerNumber;
  String nationalId;
  int personalityType;
  String taskId;
  String trackingNumber;
  T taskData;

  @override
  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'nationalId': nationalId,
        'personalityType': personalityType,
        'taskId': taskId,
        'trackingNumber': trackingNumber,
        'taskData': taskData.toJson(),
      };
}

abstract class CompleteTaskRequestData extends ApiRequestModel {}
