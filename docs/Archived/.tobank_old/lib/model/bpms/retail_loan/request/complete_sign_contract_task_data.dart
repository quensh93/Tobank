import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteSignContractTaskData extends CompleteTaskRequestData {
  DocumentFile? contractFile;
  String? finalApprovalRejectReason;

  CompleteSignContractTaskData({
    required this.contractFile,
    required this.finalApprovalRejectReason,
  });

  @override
  Map<String, dynamic> toJson() => {
        'contractFile': contractFile?.toJson(),
        'finalApprovalRejectReason': finalApprovalRejectReason,
      };
}
