import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteCustomerDocumentsTaskData extends CompleteTaskRequestData {
  CompleteCustomerDocumentsTaskData({
    required this.applicantBirthCertificateFirstDocument,
    required this.applicantBirthCertificateSecondDocument,
    required this.applicantBirthCertificateThirdDocument,
  });

  DocumentFile applicantBirthCertificateFirstDocument;
  DocumentFile applicantBirthCertificateSecondDocument;
  DocumentFile applicantBirthCertificateThirdDocument;

  @override
  Map<String, dynamic> toJson() => {
        'applicantBirthCertificateFirstDocument': applicantBirthCertificateFirstDocument.toJson(),
        'applicantBirthCertificateSecondDocument': applicantBirthCertificateSecondDocument.toJson(),
        'applicantBirthCertificateThirdDocument': applicantBirthCertificateThirdDocument.toJson(),
      };
}
