import '../../../service/core/api_request_model.dart';

class PromissoryFetchDocumentRequest extends ApiRequestModel {
  PromissoryFetchDocumentRequest({
    required this.promissoryId,
    required this.docType,
    required this.nationalNumber,
    required this.number,
  });

  String promissoryId;
  String docType;
  String? nationalNumber;
  String? number;

  @override
  Map<String, dynamic> toJson() => {
        'promissoryId': promissoryId,
        'docType': docType,
        'nationalNumber': nationalNumber,
        'number': number,
      };
}
