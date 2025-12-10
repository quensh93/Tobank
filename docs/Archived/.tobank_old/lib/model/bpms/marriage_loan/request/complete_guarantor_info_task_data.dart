import '../../request/complete_task_request_data.dart';

class CompleteGuarantorInfoTaskData extends CompleteTaskRequestData {
  CompleteGuarantorInfoTaskData({
    required this.guarantorBirthDate,
    required this.guarantorNationalId,
    required this.guarantorMobile,
    required this.personalityType,
  });

  int guarantorBirthDate;
  String guarantorNationalId;
  String guarantorMobile;
  String personalityType;

  @override
  Map<String, dynamic> toJson() => {
        'guarantorBirthDate': guarantorBirthDate,
        'guarantorNationalId': guarantorNationalId,
        'guarantorMobile': guarantorMobile,
        'personalityType': personalityType,
      };
}
