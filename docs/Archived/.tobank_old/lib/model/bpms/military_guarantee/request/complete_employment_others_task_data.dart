import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteEmploymentOthersTaskData extends CompleteTaskRequestData {
  CompleteEmploymentOthersTaskData({
    required this.applicantaffidavitDocument,
  });

  DocumentFile applicantaffidavitDocument;

  @override
  Map<String, dynamic> toJson() => {
        'applicantaffidavitDocument': applicantaffidavitDocument.toJson(),
      };
}
