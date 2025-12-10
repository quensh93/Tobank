import '../../request/complete_task_request_data.dart';

class CompleteEditCustomerLocationTaskData extends CompleteTaskRequestData {
  CompleteEditCustomerLocationTaskData({
    required this.applicantProvince,
    required this.applicantCity,
    required this.applicantAddress,
    required this.applicantResidencyType,
    required this.applicantResidencyTrackingCode,
    required this.applicantResidencyDocumentId,
    required this.applicantPostalCode,
    this.applicantResidencyDescription,
  });

  String applicantProvince;
  String applicantCity;
  String applicantAddress;
  String applicantResidencyType;
  String? applicantResidencyDescription;
  String applicantResidencyTrackingCode;
  String applicantResidencyDocumentId;
  String applicantPostalCode;

  @override
  Map<String, dynamic> toJson() => {
        'applicantProvince': applicantProvince,
        'applicantCity': applicantCity,
        'applicantAddress': applicantAddress,
        'applicantResidencyType': applicantResidencyType,
        'applicantResidencyDescription': applicantResidencyDescription,
        'applicantResidencyTrackingCode': applicantResidencyTrackingCode,
        'applicantResidencyDocumentId': applicantResidencyDocumentId,
        'applicantPostalCode': applicantPostalCode,
      };
}
