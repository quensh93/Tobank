import 'complete_edit_documents_request_data.dart';
import 'complete_task_request_data.dart';

class CompleteEditDocumentsValueTaskData extends CompleteTaskRequestData {
  CompleteEditDocumentsValueTaskData({
    required this.editDocumentList,
  });

  List<EditDocumentData> editDocumentList;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, Map<String, Map<String, String>>> documents = {};
    for (final document in editDocumentList) {
      documents[document.id] = {
        'value': {
          'id': document.documentId,
        },
      };
    }
    return documents;
  }
}
