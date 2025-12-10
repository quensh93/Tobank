import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../model/common/error_response_data.dart';
import '../model/shaparak_hub/request/card_to_card/shaparak_hub_card_inquiry_request.dart';
import '../model/shaparak_hub/request/card_to_card/shaparak_hub_transfer_inquiry_request.dart';
import '../model/shaparak_hub/request/card_to_card/shaparak_hub_transfer_request.dart';
import '../model/shaparak_hub/request/tsm/shaparak_hub_app_reactivation_request.dart';
import '../model/shaparak_hub/request/tsm/shaparak_hub_card_enrollment_request.dart';
import '../model/shaparak_hub/request/tsm/shaparak_hub_get_card_info_request.dart';
import '../model/shaparak_hub/request/tsm/shaparak_hub_get_key_request.dart';
import '../model/shaparak_hub/request/tsm/shaparak_hub_renew_card_id_request.dart';
import '../model/shaparak_hub/response/card_to_card/shaparak_hub_card_inquiry_response.dart';
import '../model/shaparak_hub/response/card_to_card/shaparak_hub_transfer_inquiry_response.dart';
import '../model/shaparak_hub/response/tsm/shaparak_hub_app_reactivation_response.dart';
import '../model/shaparak_hub/response/tsm/shaparak_hub_card_enrollment_response.dart';
import '../model/shaparak_hub/response/tsm/shaparak_hub_get_card_info_response.dart';
import '../model/shaparak_hub/response/tsm/shaparak_hub_get_key_response.dart';
import '../model/shaparak_hub/response/tsm/shaparak_hub_renew_card_id_response.dart';
import '../model/transaction/response/transaction_data_response.dart';
import '../util/app_util.dart';
import '../util/dio_util.dart';
import 'core/api_core.dart';

class ShaparakHubServices {
  ShaparakHubServices._();

  // TSM
  static Future<ApiResult<(ShaparakHubCardEnrollmentResponse, int), ApiException>> cardEnrollmentRequest(
    ShaparakHubCardEnrollmentRequest cardEnrollmentRequestData,
  ) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.enrollCardTSM,
        data: cardEnrollmentRequestData,
        modelFromJson: (responseBody, statusCode) => ShaparakHubCardEnrollmentResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(ShaparakHubAppReactivationResponse, int), ApiException>> appReactivationRequest(
    ShaparakHubAppReactivationRequest requestData,
  ) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.reactiveAppTSM,
        data: requestData,
        modelFromJson: (responseBody, statusCode) => ShaparakHubAppReactivationResponse.fromJson(responseBody));
  }

  // TODO: Create new api client
  static Future<ShaparakHubGetKeyResponse> getKey(
    ShaparakHubGetKeyRequest keyRequestData,
  ) async {
    ShaparakHubGetKeyResponse keyResponseData = ShaparakHubGetKeyResponse();
    final headers = AppUtil.getHTTPHeaderWithoutToken();
    try {
      final response = await DioUtil.getDio(
        headers: headers,
        baseUrl: AppUtil.getShaparakHubBaseUrl(),
      ).post(
        'mobileApp/getKey',
        data: jsonEncode(keyRequestData.toJson()),
      );
      final String responseString = response.toString();
      if (response.statusCode == 200) {
        keyResponseData = shaparakHubGetKeyResponseFromJson(responseString);
        keyResponseData.statusCode = response.statusCode;
        return keyResponseData;
      } else if (response.statusCode == 400) {
        keyResponseData.errorResponseData = errorResponseDataFromJson(responseString);
        keyResponseData.statusCode = response.statusCode;
        return keyResponseData;
      } else {
        keyResponseData.statusCode = response.statusCode;
        return keyResponseData;
      }
    } on DioException catch (error, stack) {
      await Sentry.captureException(
        error,
        stackTrace: stack,
      );
      keyResponseData.statusCode = DioUtil.getErrorStatusCode(error);
      return keyResponseData;
    } on Exception catch (error, stack) {
      await Sentry.captureException(
        error,
        stackTrace: stack,
      );
      keyResponseData.statusCode = 500;
      return keyResponseData;
    }
  }

  static Future<ApiResult<(ShaparakHubGetCardInfoResponse, int), ApiException>> getCardInfo(
    ShaparakHubGetCardInfoRequest requestData,
  ) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getCardInfoTSM,
        data: requestData,
        modelFromJson: (responseBody, statusCode) => ShaparakHubGetCardInfoResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(ShaparakHubRenewCardIdResponse, int), ApiException>> renewCardId(
    ShaparakHubRenewCardIdRequest requestData,
  ) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.renewCardTSM,
        data: requestData,
        modelFromJson: (responseBody, statusCode) => ShaparakHubRenewCardIdResponse.fromJson(responseBody));
  }
// TSM End

// Shaparak Hub CardToCard
  static Future<ApiResult<(ShaparakHubCardInquiryResponse, int), ApiException>> cardInquiry(
    ShaparakHubCardInquiryRequest requestData,
  ) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.inquiryCard,
        data: requestData,
        modelFromJson: (responseBody, statusCode) => ShaparakHubCardInquiryResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> transfer(
    ShaparakHubTransferRequest requestData,
  ) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.cardTransferShaparakHub,
        data: requestData,
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(ShaparakHubTransferInquiryResponse, int), ApiException>> transferInquiry(
    ShaparakHubTransferInquiryRequest requestData,
  ) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.inquiryCardTransferShaparakHub,
        data: requestData,
        modelFromJson: (responseBody, statusCode) => ShaparakHubTransferInquiryResponse.fromJson(responseBody));
  }
}
