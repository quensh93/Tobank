import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteEditMilitaryLetterTaskData extends CompleteTaskRequestData {
  CompleteEditMilitaryLetterTaskData({
    required this.beneficiaryLetterDocument,
  });

  DocumentFile beneficiaryLetterDocument;

  @override
  Map<String, dynamic> toJson() => {
        'beneficiaryLetterDocument': beneficiaryLetterDocument.toJson(),
      };
}
