import '../../common/bpms_address.dart';
import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteEditCustomerLocationTaskData extends CompleteTaskRequestData {
  CompleteEditCustomerLocationTaskData({
    required this.applicantResidencyType,
    required this.applicantResidencyDescription,
    required this.applicantResidencyTrackingCode,
    required this.applicantAddress,
    required this.applicantResidencyDocument,
  });

  String applicantResidencyType;
  String? applicantResidencyDescription;
  String? applicantResidencyTrackingCode;
  BPMSAddress applicantAddress;
  DocumentFile applicantResidencyDocument;

  @override
  Map<String, dynamic> toJson() => {
        'applicantResidencyType': applicantResidencyType,
        'applicantResidencyDescription': applicantResidencyDescription,
        'applicantResidencyTrackingCode': applicantResidencyTrackingCode,
        'applicantAddress': applicantAddress.toJson(),
        'applicantResidencyDocument': applicantResidencyDocument.toJson(),
      };
}
