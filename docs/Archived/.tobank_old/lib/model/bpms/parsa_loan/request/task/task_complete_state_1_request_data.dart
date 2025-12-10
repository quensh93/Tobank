import '../../../../../service/core/api_request_model.dart';

class TaskCompleteState1RequestData extends ApiRequestModel {
  bool? returnNextTasks;
  List<TaskData>? taskData;
  String? taskKey;
  String? trackingNumber;
  int? processId;

  TaskCompleteState1RequestData({
    this.returnNextTasks,
    this.taskData,
    this.taskKey,
    this.trackingNumber,
    this.processId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'return_next_tasks': returnNextTasks,
        'task_data': taskData == null ? [] : List<dynamic>.from(taskData!.map((x) => x.toJson())),
        'task_key': taskKey,
        'tracking_number': trackingNumber,
        'process_id': processId,
      };
}

class TaskData {
  bool hasActiveAccountResult;

  TaskData({
    required this.hasActiveAccountResult,
  });

  Map<String, dynamic> toJson() => {
        'name': 'hasActiveAccountResult',
        'value': hasActiveAccountResult,
      };
}
