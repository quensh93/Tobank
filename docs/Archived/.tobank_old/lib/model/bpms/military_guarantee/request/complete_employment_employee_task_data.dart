import '../../document_file_data.dart';
import '../../request/complete_task_request_data.dart';

class CompleteEmploymentEmployeeTaskData extends CompleteTaskRequestData {
  CompleteEmploymentEmployeeTaskData({
    required this.applicantEmploymentDocument,
    required this.applicantDeductionSalaryDocument,
  });

  DocumentFile applicantEmploymentDocument;
  DocumentFile applicantDeductionSalaryDocument;

  @override
  Map<String, dynamic> toJson() => {
        'applicantEmploymentDocument': applicantEmploymentDocument.toJson(),
        'applicantDeductionSalaryDocument': applicantDeductionSalaryDocument.toJson(),
      };
}
