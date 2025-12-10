import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteEditEmploymentOthersTaskData extends CompleteTaskRequestData {
  CompleteEditEmploymentOthersTaskData({
    required this.applicantaffidavitDocument,
  });

  DocumentFile applicantaffidavitDocument;

  @override
  Map<String, dynamic> toJson() => {
        'applicantaffidavitDocument': applicantaffidavitDocument.toJson(),
      };
}
