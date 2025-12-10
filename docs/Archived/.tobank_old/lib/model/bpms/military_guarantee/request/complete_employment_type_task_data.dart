import '../../request/complete_task_request_data.dart';

class CompleteEmploymentTypeTaskData extends CompleteTaskRequestData {
  CompleteEmploymentTypeTaskData({
    required this.applicantEmploymentType,
  });

  String applicantEmploymentType;

  @override
  Map<String, dynamic> toJson() => {
        'applicantEmploymentType': applicantEmploymentType,
      };
}
