import '../../../../../service/core/api_request_model.dart';

class ProcessStateRequestData extends ApiRequestModel {
  int? processId;
  bool? returnNextTasks;
  String? trackingNumber;

  ProcessStateRequestData({
    this.processId,
    this.returnNextTasks,
    this.trackingNumber,
  });

  @override
  Map<String, dynamic> toJson() => {
        'process_id': processId,
        'return_next_tasks': returnNextTasks,
        'tracking_number': trackingNumber,
      };
}
