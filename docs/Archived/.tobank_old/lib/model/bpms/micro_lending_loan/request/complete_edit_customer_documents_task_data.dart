import '../../request/complete_task_request_data.dart';

class CompleteEditCustomerDocumentsTaskData extends CompleteTaskRequestData {
  CompleteEditCustomerDocumentsTaskData({
    this.applicantBirthCertificateMarriageDocumentId,
    this.applicantBirthCertificateChildrenDocumentId,
    this.applicantBirthCertificateDeathInfoDocumentId,
    this.applicantEmploymentDocumentId,
  });

  String? applicantBirthCertificateMarriageDocumentId;
  String? applicantBirthCertificateChildrenDocumentId;
  String? applicantBirthCertificateDeathInfoDocumentId;
  String? applicantEmploymentDocumentId;

  @override
  Map<String, dynamic> toJson() => {
        'applicantBirthCertificateMarriageDocumentId': applicantBirthCertificateMarriageDocumentId,
        'applicantBirthCertificateChildrenDocumentId': applicantBirthCertificateChildrenDocumentId,
        'applicantBirthCertificateDeathInfoDocumentId': applicantBirthCertificateDeathInfoDocumentId,
        'applicantEmploymentDocumentId': applicantEmploymentDocumentId,
      };
}
