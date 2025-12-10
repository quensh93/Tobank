
import '../../../service/core/api_request_model.dart';

class DigitalDocumentRequestData extends ApiRequestModel {
  DigitalDocumentRequestData({
    required this.trackingNumber,
    required this.customerNumber,
    required this.documentId,
  });

  String trackingNumber;
  String customerNumber;
  String documentId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'documentId': documentId,
      };
}
