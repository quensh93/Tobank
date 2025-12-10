import '../../common/bpms_address.dart';
import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteCustomerLocationTaskData extends CompleteTaskRequestData {
  CompleteCustomerLocationTaskData({
    required this.applicantAddress,
    required this.applicantResidencyType,
    required this.applicantResidencyDescription,
    required this.applicantResidencyTrackingCode,
    required this.applicantResidencyDocument,
  });

  BPMSAddress applicantAddress;
  String applicantResidencyType;
  String? applicantResidencyDescription;
  String? applicantResidencyTrackingCode;
  DocumentFile applicantResidencyDocument;

  @override
  Map<String, dynamic> toJson() => {
        'applicantAddress': applicantAddress.toJson(),
        'applicantResidencyType': applicantResidencyType,
        'applicantResidencyDescription': applicantResidencyDescription,
        'applicantResidencyTrackingCode': applicantResidencyTrackingCode,
        'applicantResidencyDocument': applicantResidencyDocument.toJson(),
      };
}
