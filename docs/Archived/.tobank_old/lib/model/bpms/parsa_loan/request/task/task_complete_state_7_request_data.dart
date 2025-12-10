import '../../../../../service/core/api_request_model.dart';

class TaskCompleteState7RequestData extends ApiRequestModel {
  bool? returnNextTasks;
  List<Map<String, dynamic>>? taskData;
  String? taskKey;
  String? trackingNumber;
  int? processId;

  TaskCompleteState7RequestData({
    this.returnNextTasks,
    this.taskData,
    this.taskKey,
    this.trackingNumber,
    this.processId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'return_next_tasks': returnNextTasks,
        'task_data': taskData,
        'task_key': taskKey,
        'tracking_number': trackingNumber,
        'process_id': processId,
      };
}
