import '../model/common/error_response_data.dart';
import '../model/promissory/request/dest_user_info_request_data.dart';
import '../model/promissory/request/promissory_amount_request_data.dart';
import '../model/promissory/request/promissory_company_inquiry_request_data.dart';
import '../model/promissory/request/promissory_delete_request_data.dart';
import '../model/promissory/request/promissory_endorsement_finalize_request_data.dart';
import '../model/promissory/request/promissory_endorsement_request_data.dart';
import '../model/promissory/request/promissory_fetch_document_request_data.dart';
import '../model/promissory/request/promissory_fetch_unsigned_document_request_data.dart';
import '../model/promissory/request/promissory_guarantee_finalize_request_data.dart';
import '../model/promissory/request/promissory_guarantee_request_data.dart';
import '../model/promissory/request/promissory_inquiry_request_data.dart';
import '../model/promissory/request/promissory_publish_finalize_request_data.dart';
import '../model/promissory/request/promissory_publish_payment_request_data.dart';
import '../model/promissory/request/promissory_request_data.dart';
import '../model/promissory/request/promissory_settlement_finalize_request_data.dart';
import '../model/promissory/request/promissory_settlement_gradual_finalize_request_data.dart';
import '../model/promissory/request/promissory_settlement_gradual_request_data.dart';
import '../model/promissory/request/promissory_settlement_request_data.dart';
import '../model/promissory/response/check_sana_response_data.dart';
import '../model/promissory/response/dest_user_info_response_data.dart';
import '../model/promissory/response/get_full_detailed_my_promissory_response_data.dart';
import '../model/promissory/response/get_open_publish_response_data.dart';
import '../model/promissory/response/my_promissory_inquiry_response_data.dart';
import '../model/promissory/response/promissory_amount_response_data.dart';
import '../model/promissory/response/promissory_asset_response_data.dart';
import '../model/promissory/response/promissory_company_inquiry_response_data.dart';
import '../model/promissory/response/promissory_delete_response_data.dart';
import '../model/promissory/response/promissory_endorsement_finalize_response_data.dart';
import '../model/promissory/response/promissory_endorsement_response_data.dart';
import '../model/promissory/response/promissory_fetch_document_response_data.dart';
import '../model/promissory/response/promissory_fetch_unsigned_document_response_data.dart';
import '../model/promissory/response/promissory_guarantee_finalize_response_data.dart';
import '../model/promissory/response/promissory_guarantee_response_data.dart';
import '../model/promissory/response/promissory_inquiry_response_data.dart';
import '../model/promissory/response/promissory_internet_payment_response_data.dart';
import '../model/promissory/response/promissory_publish_finalize_response_data.dart';
import '../model/promissory/response/promissory_request_history_response_data.dart';
import '../model/promissory/response/promissory_response_data.dart';
import '../model/promissory/response/promissory_settlement_finalize_response_data.dart';
import '../model/promissory/response/promissory_settlement_gradual_finalize_response_data.dart';
import '../model/promissory/response/promissory_settlement_gradual_response_data.dart';
import '../model/promissory/response/promissory_settlement_response_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class PromissoryServices {
  PromissoryServices._();

  static Future<ApiResult<(PromissoryFetchUnsignedDocumentResponse, int), ApiException>> fetchUnsignedDocumentRequest({
    required PromissoryFetchUnsignedDocumentRequest promissoryFetchUnsignedDocumentRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.fetchUnsignedDocument,
        data: promissoryFetchUnsignedDocumentRequest,
        modelFromJson: (responseBody, statusCode) => PromissoryFetchUnsignedDocumentResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryRequestHistoryResponseData, int), ApiException>>
      getPromissoryRequestsHistory() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getOpenPromissoryRequests,
        modelFromJson: (responseBody, statusCode) => PromissoryRequestHistoryResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> promissoryPaymentRequest({
    required PromissoryPublishPaymentRequestData promissoryPublishPaymentRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.payPromissoryPublishRequest,
        data: promissoryPublishPaymentRequestData,
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryInternetPaymentResponseData, int), ApiException>> promissoryInternetRequest({
    required PromissoryPublishPaymentRequestData promissoryPublishPaymentRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.payPromissoryPublishRequest,
        data: promissoryPublishPaymentRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryInternetPaymentResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryPublishFinalizeResponse, int), ApiException>> promissoryPublishFinalizeRequest({
    required PromissoryPublishFinalizeRequestData promissoryPublishFinalizeRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.finalizePromissoryPublishRequest,
        data: promissoryPublishFinalizeRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryPublishFinalizeResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryAmountResponseData, int), ApiException>> getPromissoryPublishPriceRequest({
    required PromissoryAmountRequestData promissoryAmountRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPromissoryPublishPrice,
        data: promissoryAmountRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryAmountResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryPublishResponseData, int), ApiException>> promissoryRequest({
    required PromissoryRequestData promissoryRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.createPromissoryPublishRequest,
        data: promissoryRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryPublishResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryDeleteResponseData, int), ApiException>> promissoryDeleteRequest({
    required PromissoryDeleteRequestData promissoryDeleteRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.deletePromissoryOpenRequest,
        data: promissoryDeleteRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryDeleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryGuaranteeResponseData, int), ApiException>> guaranteeRequest({
    required PromissoryGuaranteeRequestData promissoryGuaranteeRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.createPromissoryGuaranteeRequest,
        data: promissoryGuaranteeRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryGuaranteeResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryInquiryResponseData, int), ApiException>> promissoryInquiryRequest({
    required PromissoryInquiryRequestData promissoryInquiryRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.inquiryPromissory,
        data: promissoryInquiryRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryInquiryResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryGuaranteeFinalizeResponseData, int), ApiException>> promissoryGuaranteeFinalize({
    required PromissoryGuaranteeFinalizeRequestData promissoryGuaranteeFinalizeRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.finalizePromissoryGuaranteeRequest,
        data: promissoryGuaranteeFinalizeRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryGuaranteeFinalizeResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(MyPromissoryInquiryResponse, int), ApiException>> myPromissoryInquiry({
    required int size,
    required int page,
    required String? role,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters['size'] = size;
    queryParameters['page'] = page;

    if (role != null) {
      queryParameters['role'] = role;
    }

    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getMyPromissories,
        queryParameters: queryParameters,
        modelFromJson: (responseBody, statusCode) => MyPromissoryInquiryResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(DestUserInfoResponse, int), ApiException>> destUserInfo({
    required DestUserInfoRequestData destUserInfoRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.inquiryOtherUserName,
        data: destUserInfoRequestData,
        modelFromJson: (responseBody, statusCode) => DestUserInfoResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryEndorsementResponseData, int), ApiException>> promissoryEndorsementRequest({
    required PromissoryEndorsementRequestData promissoryEndorsementRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.createPromissoryEndorsementRequest,
        data: promissoryEndorsementRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryEndorsementResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryEndorsementFinalizeResponse, int), ApiException>>
      promissoryEndorsementFinalizeRequest({
    required PromissoryEndorsementFinalizeRequestData promissoryEndorsementFinalizeRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.finalizePromissoryEndorsementRequest,
        data: promissoryEndorsementFinalizeRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryEndorsementFinalizeResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryFetchDocumentResponse, int), ApiException>> promissoryFetchDocumentRequest({
    required PromissoryFetchDocumentRequest promissoryFetchDocument,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.fetchPromissoryDocument,
        data: promissoryFetchDocument,
        modelFromJson: (responseBody, statusCode) => PromissoryFetchDocumentResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissorySettlementResponse, int), ApiException>> settlementRequest({
    required PromissorySettlementRequest promissorySettlementRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.createPromissorySettlementRequest,
        data: promissorySettlementRequest,
        modelFromJson: (responseBody, statusCode) => PromissorySettlementResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissorySettlementFinalizeResponse, int), ApiException>>
      promissorySettlementFinalizeRequest({
    required PromissorySettlementFinalizeRequest promissorySettlementFinalizeRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.finalizePromissorySettlementRequest,
        data: promissorySettlementFinalizeRequest,
        modelFromJson: (responseBody, statusCode) => PromissorySettlementFinalizeResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissorySettlementGradualResponse, int), ApiException>> settlementGradualRequest({
    required PromissorySettlementGradualRequest promissorySettlementGradualRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.createPromissorySettlementGradualRequest,
        data: promissorySettlementGradualRequest,
        modelFromJson: (responseBody, statusCode) => PromissorySettlementGradualResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissorySettlementGradualFinalizeResponse, int), ApiException>>
      promissorySettlementGradualFinalizeRequest({
    required PromissorySettlementGradualFinalizeRequest promissorySettlementGradualFinalizeRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.finalizePromissorySettlementGradualRequest,
        data: promissorySettlementGradualFinalizeRequest,
        modelFromJson: (responseBody, statusCode) =>
            PromissorySettlementGradualFinalizeResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryAssetResponseData, int), ApiException>> getPromissoryAssets() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPromissoryAssets,
        modelFromJson: (responseBody, statusCode) => PromissoryAssetResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(PromissoryCompanyInquiryResponseData, int), ApiException>> companyInquiryRequest({
    required PromissoryCompanyInquiryRequestData promissoryCompanyInquiryRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.inquiryCompany,
        data: promissoryCompanyInquiryRequestData,
        modelFromJson: (responseBody, statusCode) => PromissoryCompanyInquiryResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(CheckSanaResponseData, int), ApiException<ErrorResponseData>>> checkUserSana() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.checkUserSana,
        modelFromJson: (responseBody, statusCode) => CheckSanaResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(GetOpenPublishResponse, int), ApiException<ErrorResponseData>>>
      getOpenPublishRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getOpenPromissoryPublishRequest,
        modelFromJson: (responseBody, statusCode) => GetOpenPublishResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(GetMyFullDeatiledPromissoryResponse, int), ApiException<ErrorResponseData>>>
      getMyFullDetailedPromissory() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getMyFullDetailedPromissory,
        modelFromJson: (responseBody, statusCode) => GetMyFullDeatiledPromissoryResponse.fromJson(responseBody));
  }
}
