import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteMilitaryLetterTaskData extends CompleteTaskRequestData {
  CompleteMilitaryLetterTaskData({
    required this.beneficiaryLetterDocument,
  });

  DocumentFile beneficiaryLetterDocument;

  @override
  Map<String, dynamic> toJson() => {
        'beneficiaryLetterDocument': beneficiaryLetterDocument.toJson(),
      };
}
