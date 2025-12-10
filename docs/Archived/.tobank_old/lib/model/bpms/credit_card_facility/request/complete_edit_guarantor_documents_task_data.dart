import '../../request/complete_task_request_data.dart';

class CompleteEditGuarantorDocumentsTaskData extends CompleteTaskRequestData {
  CompleteEditGuarantorDocumentsTaskData({
    required this.guarantorBirthCertificateMarriageDocumentId,
    required this.guarantorBirthCertificateChildrenDocumentId,
    required this.guarantorBirthCertificateDeathInfoDocumentId,
  });

  String guarantorBirthCertificateMarriageDocumentId;
  String guarantorBirthCertificateChildrenDocumentId;
  String guarantorBirthCertificateDeathInfoDocumentId;

  @override
  Map<String, dynamic> toJson() => {
        'guarantorBirthCertificateMarriageDocumentId': guarantorBirthCertificateMarriageDocumentId,
        'guarantorBirthCertificateChildrenDocumentId': guarantorBirthCertificateChildrenDocumentId,
        'guarantorBirthCertificateDeathInfoDocumentId': guarantorBirthCertificateDeathInfoDocumentId,
      };
}
