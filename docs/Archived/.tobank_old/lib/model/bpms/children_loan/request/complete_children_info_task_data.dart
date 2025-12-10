import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteChildrenInfoTaskData extends CompleteTaskRequestData {
  CompleteChildrenInfoTaskData({
    required this.childNationalId,
    required this.childBirthDate,
    required this.childBirthCertificateFirstDocument,
    required this.childBirthCertificateSecondDocument,
    required this.childBirthCertificateThirdDocument,
  });

  String childNationalId;
  int childBirthDate;
  DocumentFile childBirthCertificateFirstDocument;
  DocumentFile childBirthCertificateSecondDocument;
  DocumentFile childBirthCertificateThirdDocument;

  @override
  Map<String, dynamic> toJson() => {
        'childNationalId': childNationalId,
        'childBirthDate': childBirthDate,
        'childBirthCertificateFirstDocument': childBirthCertificateFirstDocument.toJson(),
        'childBirthCertificateSecondDocument': childBirthCertificateSecondDocument.toJson(),
        'childBirthCertificateThirdDocument': childBirthCertificateThirdDocument.toJson(),
      };
}
