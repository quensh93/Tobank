import 'complete_task_request_data.dart';

class CompleteEditDocumentsTaskData extends CompleteTaskRequestData {
  CompleteEditDocumentsTaskData({
    required this.editDocumentList,
  });

  List<EditDocumentData> editDocumentList;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, String> documents = {};
    for (final document in editDocumentList) {
      documents[document.id] = document.documentId;
    }
    return documents;
  }
}

class EditDocumentData {
  EditDocumentData({
    required this.id,
    required this.documentId,
  });

  String id;
  String documentId;
}
