import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteEmploymentSelfEmployedTaskData extends CompleteTaskRequestData {
  CompleteEmploymentSelfEmployedTaskData({
    required this.applicantBusinessLicenseDocument,
  });

  DocumentFile applicantBusinessLicenseDocument;

  @override
  Map<String, dynamic> toJson() => {
        'applicantBusinessLicenseDocument': applicantBusinessLicenseDocument.toJson(),
      };
}
