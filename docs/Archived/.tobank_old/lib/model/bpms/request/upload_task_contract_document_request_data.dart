import '../../../service/core/api_request_model.dart';

class UploadTaskContractDocumentRequestData extends ApiRequestModel {
  UploadTaskContractDocumentRequestData({
    required this.trackingNumber,
    required this.customerNumber,
    required this.documentData,
    required this.documentId,
  });

  String trackingNumber;
  String customerNumber;
  String documentData;
  String documentId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'documentData': documentData,
        'documentId': documentId,
      };
}
