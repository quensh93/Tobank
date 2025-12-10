import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class TaskDataSignContract extends CompleteTaskRequestData {
  TaskDataSignContract({
    required this.contractFile,
    required this.finalApprovalRejectReason,
  });

  DocumentFile? contractFile;
  String? finalApprovalRejectReason;

  @override
  Map<String, dynamic> toJson() => {
        'contractFile': contractFile?.toJson(),
        'finalApprovalRejectReason': finalApprovalRejectReason,
      };
}
