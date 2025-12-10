import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteDraftFileTaskData extends CompleteTaskRequestData {
  CompleteDraftFileTaskData({
    required this.draftFile,
  });

  DocumentFile draftFile;

  @override
  Map<String, dynamic> toJson() => {
        'draftFile': draftFile.toJson(),
      };
}
