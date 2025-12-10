import '../../common/bpms_address.dart';
import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteGuarantorLocationTaskData extends CompleteTaskRequestData {
  CompleteGuarantorLocationTaskData({
    required this.guarantorAddress,
    required this.guarantorResidencyType,
    required this.guarantorResidencyDescription,
    required this.guarantorResidencyTrackingCode,
    required this.guarantorResidencyDocument,
  });

  BPMSAddress guarantorAddress;
  String guarantorResidencyType;
  String? guarantorResidencyDescription;
  String? guarantorResidencyTrackingCode;
  DocumentFile guarantorResidencyDocument;

  @override
  Map<String, dynamic> toJson() => {
        'guarantorAddress': guarantorAddress.toJson(),
        'guarantorResidencyType': guarantorResidencyType,
        'guarantorResidencyDescription': guarantorResidencyDescription,
        'guarantorResidencyTrackingCode': guarantorResidencyTrackingCode,
        'guarantorResidencyDocument': guarantorResidencyDocument.toJson(),
      };
}
