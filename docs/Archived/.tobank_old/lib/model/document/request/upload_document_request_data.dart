
import '../../../service/core/api_request_model.dart';

class UploadDocumentRequestData extends ApiRequestModel {
  UploadDocumentRequestData({
    this.trackingNumber,
    this.customerNumber,
    this.documentData,
  });

  String? trackingNumber;
  String? customerNumber;
  String? documentData;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'documentData': documentData,
      };
}
