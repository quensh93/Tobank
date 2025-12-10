import '../../../../service/core/api_request_model.dart';

class UploadDocumentRequestData extends ApiRequestModel {
  String? document;

  UploadDocumentRequestData({
    this.document,
  });

  @override
  Map<String, dynamic> toJson() => {
        'document': document,
      };
}
