import '../../request/complete_task_request_data.dart';
import '../../response/get_task_data_response_data.dart';

class CompleteApplicantAdditionalDocumentsTaskData extends CompleteTaskRequestData {
  CompleteApplicantAdditionalDocumentsTaskData({
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

  factory ApplicantAdditionalDocumentsValue.fromJson(Map<String, dynamic> json) => ApplicantAdditionalDocumentsValue(
        documents: SubValueDictionary.fromJson(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'value': documents.toJson(),
      };
}
