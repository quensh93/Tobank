import '../model/transfer/request/iban_inquiry_request_data.dart';
import '../model/transfer/request/transfer_history_request_data.dart';
import '../model/transfer/request/transfer_request_data.dart';
import '../model/transfer/request/transfer_status_request_data.dart';
import '../model/transfer/response/iban_inquiry_response_data.dart';
import '../model/transfer/response/transfer_history_response_data.dart';
import '../model/transfer/response/transfer_response_data.dart';
import '../model/transfer/response/transfer_status_response_data.dart';
import 'core/api_core.dart';

class TransferServices {
  TransferServices._();

  static Future<ApiResult<(IbanInquiryResponseData, int), ApiException>> ibanInquiryRequest({
    required IbanInquiryRequestData ibanInquiryRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.inquiryIban,
        data: ibanInquiryRequestData,
        modelFromJson: (responseBody, statusCode) => IbanInquiryResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransferResponseData, int), ApiException>> transferRequest({
    required TransferRequestData transferRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.transferDepositRequest,
        data: transferRequestData,
        modelFromJson: (responseBody, statusCode) => TransferResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransferHistoryResponseData, int), ApiException>> getTransferHistory({
    required TransferHistoryRequestData transferHistoryRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getTransferHistory,
        data: transferHistoryRequestData,
        modelFromJson: (responseBody, statusCode) => TransferHistoryResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransferStatusResponseData, int), ApiException>> transferStatusRequest({
    required TransferStatusRequestData transferStatusRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.inquiryTransferStatus,
        data: transferStatusRequestData,
        modelFromJson: (responseBody, statusCode) => TransferStatusResponseData.fromJson(responseBody));
  }
}
