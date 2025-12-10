import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteompleMarriageLicenseTaskData extends CompleteTaskRequestData {
  CompleteompleMarriageLicenseTaskData({
    required this.marriageLicenseType,
    required this.marriageNewLicenseFrontDocument,
    required this.marriageNewLicenseBackDocument,
    required this.marriageLicenseFirstDocument,
    required this.marriageLicenseSecondDocument,
    required this.marriageLicenseThirdDocument,
  });

  String marriageLicenseType;
  DocumentFile? marriageNewLicenseFrontDocument;
  DocumentFile? marriageNewLicenseBackDocument;
  DocumentFile? marriageLicenseFirstDocument;
  DocumentFile? marriageLicenseSecondDocument;
  DocumentFile? marriageLicenseThirdDocument;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> temp = {};
    temp['marriageLicenseType'] = marriageLicenseType;
    if (marriageNewLicenseFrontDocument != null) {
      temp['marriageNewLicenseFrontDocument'] = marriageNewLicenseFrontDocument!.toJson();
    }
    if (marriageNewLicenseBackDocument != null) {
      temp['marriageNewLicenseBackDocument'] = marriageNewLicenseBackDocument!.toJson();
    }
    if (marriageLicenseFirstDocument != null) {
      temp['marriageLicenseFirstDocument'] = marriageLicenseFirstDocument!.toJson();
    }
    if (marriageLicenseSecondDocument != null) {
      temp['marriageLicenseSecondDocument'] = marriageLicenseSecondDocument!.toJson();
    }
    if (marriageLicenseThirdDocument != null) {
      temp['marriageLicenseThirdDocument'] = marriageLicenseThirdDocument!.toJson();
    }
    return temp;
  }
}
