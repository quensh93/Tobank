import '../../request/complete_task_request_data.dart';

class CompleteEmploymentDocumentsTaskData extends CompleteTaskRequestData {
  CompleteEmploymentDocumentsTaskData({
    required this.confirmCompleteEmployment,
  });

  bool confirmCompleteEmployment;

  @override
  Map<String, dynamic> toJson() => {
        'confirmCompleteEmployment': confirmCompleteEmployment,
      };
}
