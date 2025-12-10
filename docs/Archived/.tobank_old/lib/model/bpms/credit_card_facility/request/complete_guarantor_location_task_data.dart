import '../../request/complete_task_request_data.dart';

class CompleteGuarantorLocationTaskData extends CompleteTaskRequestData {
  CompleteGuarantorLocationTaskData({
    required this.guarantorProvince,
    required this.guarantorCity,
    required this.guarantorAddress,
    required this.guarantorResidencyType,
    required this.guarantorResidencyTrackingCode,
    required this.guarantorResidencyDocumentId,
    required this.guarantorPostalCode,
    this.guarantorResidencyDescription,
  });

  String guarantorProvince;
  String guarantorCity;
  String guarantorAddress;
  String guarantorResidencyType;
  String? guarantorResidencyDescription;
  String? guarantorResidencyTrackingCode;
  String guarantorResidencyDocumentId;
  String guarantorPostalCode;

  @override
  Map<String, dynamic> toJson() => {
        'guarantorProvince': guarantorProvince,
        'guarantorCity': guarantorCity,
        'guarantorAddress': guarantorAddress,
        'guarantorResidencyType': guarantorResidencyType,
        'guarantorResidencyDescription': guarantorResidencyDescription,
        'guarantorResidencyTrackingCode': guarantorResidencyTrackingCode,
        'guarantorResidencyDocumentId': guarantorResidencyDocumentId,
        'guarantorPostalCode': guarantorPostalCode,
      };
}
