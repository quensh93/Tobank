import '../../../service/core/api_request_model.dart';

class GetTaskContractDocumentRequest extends ApiRequestModel {
  GetTaskContractDocumentRequest({
    required this.taskId,
  });

  String taskId;

  @override
  Map<String, dynamic> toJson() => {
        'task_id': taskId,
      };
}
