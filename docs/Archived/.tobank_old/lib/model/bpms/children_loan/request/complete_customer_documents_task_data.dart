import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteCustomerDocumentsTaskData extends CompleteTaskRequestData {
  CompleteCustomerDocumentsTaskData({
    required this.applicantBirthCertificateFirstDocument,
    required this.applicantBirthCertificateSecondDocument,
    required this.applicantBirthCertificateThirdDocument,
    required this.applicantIsFathersChild,
    this.applicantGuardianshipDocument,
  });

  DocumentFile applicantBirthCertificateFirstDocument;
  DocumentFile applicantBirthCertificateSecondDocument;
  DocumentFile applicantBirthCertificateThirdDocument;
  DocumentFile? applicantGuardianshipDocument;
  bool applicantIsFathersChild;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> temp = {};
    temp['applicantBirthCertificateFirstDocument'] = applicantBirthCertificateFirstDocument.toJson();
    temp['applicantBirthCertificateSecondDocument'] = applicantBirthCertificateSecondDocument.toJson();
    temp['applicantBirthCertificateThirdDocument'] = applicantBirthCertificateThirdDocument.toJson();
    temp['applicantIsFathersChild'] = applicantIsFathersChild;
    if (applicantGuardianshipDocument != null) {
      temp['applicantGuardianshipDocument'] = applicantGuardianshipDocument!.toJson();
    }
    return temp;
  }
}
