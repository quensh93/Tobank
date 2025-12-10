import '../../request/complete_task_request_data.dart';
import '../../response/get_task_data_response_data.dart';

class CompleteCustomerApplicantAdditionalDocumentsTaskData extends CompleteTaskRequestData {
  CompleteCustomerApplicantAdditionalDocumentsTaskData({
    required this.value,
  });

  ApplicantAdditionalDocumentsValue value;

  @override
  Map<String, dynamic> toJson() => {
        'applicantAdditionalDocuments': value.toJson(),
      };
}

class ApplicantAdditionalDocumentsValue {
  ApplicantAdditionalDocumentsValue({
    required this.documents,
  });

  SubValueDictionary documents; // TODO

  Map<String, dynamic> toJson() => {
        'value': documents.toJson(),
      };
}
