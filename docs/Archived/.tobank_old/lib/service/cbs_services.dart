import '../model/cbs/request/credit_inquiry_request_data.dart';
import '../model/cbs/request/inquiry_cbs_request_data.dart';
import '../model/cbs/request/third_person_notify_request_data.dart';
import '../model/cbs/response/cbs_fetch_document_response_data.dart';
import '../model/cbs/response/credit_inquiry_internet_response_data.dart';
import '../model/cbs/response/credit_inquiry_order_id_response_data.dart';
import '../model/cbs/response/third_person_notify_response_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class CBSServices {
  CBSServices._();

  static Future<ApiResult<(ThirdPersonNotifyResponseData, int), ApiException>> thirdPersonNotifyRequest(
    ThirdPersonNotifyRequestData thirdPersonNotifyRequestData,
  ) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.cbsSendThirdPersonOTP,
      data: thirdPersonNotifyRequestData,
      modelFromJson: (responseBody, statusCode) => ThirdPersonNotifyResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> creditInquiryPaymentRequest({
    required CreditInquiryRequestData creditInquiryRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.cbsCreditInquiry,
      data: creditInquiryRequestData,
      modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CreditInquiryInternetResponseData, int), ApiException>> creditInquiryInternetRequest({
    required CreditInquiryRequestData creditInquiryRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.cbsCreditInquiry,
      data: creditInquiryRequestData,
      modelFromJson: (responseBody, statusCode) => CreditInquiryInternetResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CBSFetchDocumentResponse, int), ApiException>> cbsFetchDocumentRequest({
    required int id,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.cbsFetchDocument,
      slug: id.toString(),
      modelFromJson: (responseBody, statusCode) => CBSFetchDocumentResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CreditInquiryOrderIdResponseData, int), ApiException>> creditInquiryOrderIdRequest({
    required InquiryCbsRequestData inquiryCbsRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.cbsCreditInquiryOrderId,
      data: inquiryCbsRequestData,
      modelFromJson: (responseBody, statusCode) => CreditInquiryOrderIdResponseData.fromJson(responseBody),
    );
  }
}
