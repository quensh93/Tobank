import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteGuarantorDocumentsTaskData extends CompleteTaskRequestData {
  CompleteGuarantorDocumentsTaskData({
    required this.guarantorBirthCertificateFirstDocument,
    required this.guarantorBirthCertificateSecondDocument,
    required this.guarantorBirthCertificateThirdDocument,
    required this.guarantorEmploymentDocument,
  });

  DocumentFile guarantorBirthCertificateFirstDocument;
  DocumentFile guarantorBirthCertificateSecondDocument;
  DocumentFile guarantorBirthCertificateThirdDocument;
  DocumentFile guarantorEmploymentDocument;

  @override
  Map<String, dynamic> toJson() => {
        'guarantorBirthCertificateFirstDocument': guarantorBirthCertificateFirstDocument.toJson(),
        'guarantorBirthCertificateSecondDocument': guarantorBirthCertificateSecondDocument.toJson(),
        'guarantorBirthCertificateThirdDocument': guarantorBirthCertificateThirdDocument.toJson(),
        'guarantorEmploymentDocument': guarantorEmploymentDocument.toJson(),
      };
}
