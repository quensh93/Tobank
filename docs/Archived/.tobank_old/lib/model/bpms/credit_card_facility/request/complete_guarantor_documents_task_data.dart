import '../../request/complete_task_request_data.dart';

class CompleteGuarantorDocumentsTaskData extends CompleteTaskRequestData {
  CompleteGuarantorDocumentsTaskData({
    required this.guarantorBirthCertificateMarriageDocumentId,
    required this.guarantorBirthCertificateChildrenDocumentId,
    required this.guarantorBirthCertificateDeathInfoDocumentId,
    required this.guarantorEmploymentDocumentId,
  });

  String guarantorBirthCertificateMarriageDocumentId;
  String guarantorBirthCertificateChildrenDocumentId;
  String guarantorBirthCertificateDeathInfoDocumentId;
  String guarantorEmploymentDocumentId;

  @override
  Map<String, dynamic> toJson() => {
        'guarantorBirthCertificateMarriageDocumentId': guarantorBirthCertificateMarriageDocumentId,
        'guarantorBirthCertificateChildrenDocumentId': guarantorBirthCertificateChildrenDocumentId,
        'guarantorBirthCertificateDeathInfoDocumentId': guarantorBirthCertificateDeathInfoDocumentId,
        'guarantorEmploymentDocumentId': guarantorEmploymentDocumentId,
      };
}
