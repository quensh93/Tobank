import 'complete_task_request_data.dart';

class CompleteDeleteGuarantorTaskData extends CompleteTaskRequestData {
  CompleteDeleteGuarantorTaskData({
    required this.deleteGuarantor,
    required this.deleteGuarantorReasonDescription,
  });

  bool deleteGuarantor;
  String deleteGuarantorReasonDescription;

  @override
  Map<String, dynamic> toJson() => {
        'deleteGuarantor': deleteGuarantor,
        'deleteGuarantorReasonDescription': deleteGuarantorReasonDescription,
      };
}
