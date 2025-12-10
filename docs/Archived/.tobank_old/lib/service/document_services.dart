import 'dart:async';

import '../model/document/request/digital_document_request_data.dart';
import '../model/document/request/upload_document_request_data.dart';
import '../model/document/response/digital_document_response_data.dart';
import '../model/document/response/upload_document_response_data.dart';
import 'core/api_core.dart';

class DocumentServices {
  DocumentServices._();

  static Future<ApiResult<(UploadDocumentResponseData, int), ApiException>> uploadDocumentRequest({
    required UploadDocumentRequestData uploadDocumentRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.uploadDocumentRequest,
        data: uploadDocumentRequestData,
        modelFromJson: (responseBody, statusCode) => UploadDocumentResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(DigitalDocumentResponseData, int), ApiException>> getDigitalDocumentRequest({
    required DigitalDocumentRequestData digitalDocumentRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getDigitalDocument,
        data: digitalDocumentRequestData,
        modelFromJson: (responseBody, statusCode) => DigitalDocumentResponseData.fromJson(responseBody));
  }
}
