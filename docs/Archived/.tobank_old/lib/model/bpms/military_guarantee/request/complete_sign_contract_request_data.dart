import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteSignContractTaskData extends CompleteTaskRequestData {
  CompleteSignContractTaskData({
    required this.collateralFile,
    required this.contractFile,
  });

  DocumentFile collateralFile;
  DocumentFile contractFile;

  @override
  Map<String, dynamic> toJson() => {
        'collateralFile': collateralFile.toJson(),
        'contractFile': contractFile.toJson(),
      };
}
