import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteSpouseInfoTaskData extends CompleteTaskRequestData {
  CompleteSpouseInfoTaskData({
    required this.spouseNationalId,
    required this.spouseBirthDate,
    required this.spouseHasSmartNationalIdCard,
    required this.spouseBirthCertificateFirstDocument,
    required this.spouseBirthCertificateSecondDocument,
    required this.spouseBirthCertificateThirdDocument,
    this.spouseNationalIdTrackingNumber,
    this.spouseNationalIdFrontDocument,
    this.spouseNationalIdBackDocument,
  });

  String spouseNationalId;
  int spouseBirthDate;
  String? spouseNationalIdTrackingNumber;
  bool spouseHasSmartNationalIdCard;
  DocumentFile? spouseNationalIdFrontDocument;
  DocumentFile? spouseNationalIdBackDocument;
  DocumentFile spouseBirthCertificateFirstDocument;
  DocumentFile spouseBirthCertificateSecondDocument;
  DocumentFile spouseBirthCertificateThirdDocument;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> temp = {};
    temp['spouseNationalId'] = spouseNationalId;
    temp['spouseBirthDate'] = spouseBirthDate;
    temp['spouseNationalIdTrackingNumber'] = spouseNationalIdTrackingNumber;
    temp['spouseHasSmartNationalIdCard'] = spouseHasSmartNationalIdCard;
    temp['spouseBirthCertificateFirstDocument'] = spouseBirthCertificateFirstDocument.toJson();
    temp['spouseBirthCertificateSecondDocument'] = spouseBirthCertificateSecondDocument.toJson();
    temp['spouseBirthCertificateThirdDocument'] = spouseBirthCertificateThirdDocument.toJson();

    if (spouseNationalIdFrontDocument != null) {
      temp['spouseNationalIdFrontDocument'] = spouseNationalIdFrontDocument!.toJson();
    }
    if (spouseNationalIdBackDocument != null) {
      temp['spouseNationalIdBackDocument'] = spouseNationalIdBackDocument!.toJson();
    }
    return temp;
  }
}
