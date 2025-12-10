import '../../request/complete_task_request_data.dart';

class CompleteEditCustomerDocumentsTaskData extends CompleteTaskRequestData {
  CompleteEditCustomerDocumentsTaskData({
    required this.applicantBirthCertificateMarriageDocumentId,
    required this.applicantBirthCertificateChildrenDocumentId,
    required this.applicantBirthCertificateDeathInfoDocumentId,
    required this.applicantEmploymentDocumentId,
  });

  String applicantBirthCertificateMarriageDocumentId;
  String applicantBirthCertificateChildrenDocumentId;
  String applicantBirthCertificateDeathInfoDocumentId;
  String applicantEmploymentDocumentId;

  @override
  Map<String, dynamic> toJson() => {
        'applicantBirthCertificateMarriageDocumentId': applicantBirthCertificateMarriageDocumentId,
        'applicantBirthCertificateChildrenDocumentId': applicantBirthCertificateChildrenDocumentId,
        'applicantBirthCertificateDeathInfoDocumentId': applicantBirthCertificateDeathInfoDocumentId,
        'applicantEmploymentDocumentId': applicantEmploymentDocumentId,
      };
}
