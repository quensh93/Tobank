import 'package:universal_io/io.dart';

import 'response/get_task_data_response_data.dart';

class DocumentStateData {
  TaskDataFormField id;
  TaskDataFormField status;
  TaskDataFormField description;

  //using those variables in edit document
  String? documentId;
  File? documentFile;
  bool isUploading = false;

  bool isRejected() {
    if (status.value!.subValue == 'REJECTED') {
      return true;
    } else {
      return false;
    }
  }

  DocumentStateData({
    required this.id,
    required this.status,
    required this.description,
  });
}
