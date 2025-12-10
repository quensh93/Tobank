import 'dart:async';

import '../model/gift_card/request/gift_card_data_request.dart';
import '../model/gift_card/response/costs_data.dart';
import '../model/gift_card/response/gift_card_internet_pay_data.dart';
import '../model/gift_card/response/list_delivery_date_data.dart';
import '../model/gift_card/response/list_event_plan_data.dart';
import '../model/gift_card/response/list_gift_card_amount_data.dart';
import '../model/gift_card/response/list_gift_card_data.dart';
import '../model/gift_card/response/list_message_gift_card_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class GiftCardServices {
  GiftCardServices._();

  static Future<ApiResult<(ListPhysicalGiftCardAmountData, int), ApiException>>
      getPhysicalGiftCardsAmountRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPhysicalGiftCardsAmount,
        modelFromJson: (responseBody, statusCode) => ListPhysicalGiftCardAmountData.fromJson(responseBody));
  }

  static Future<ApiResult<(CostsData, int), ApiException>> getPhysicalCostsRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getGiftCardCosts,
        modelFromJson: (responseBody, statusCode) => CostsData.fromJson(responseBody));
  }

  static Future<ApiResult<(ListPhysicalGiftCardData, int), ApiException>> getListPhysicalGiftCardRequest() async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters['per_page'] = 100;
    queryParameters['paid'] = true;
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getGiftCardsList,
        queryParameters: queryParameters,
        modelFromJson: (responseBody, statusCode) => ListPhysicalGiftCardData.fromJson(responseBody));
  }

  static Future<ApiResult<(ListEventPlanData, int), ApiException>> getListEventPlanRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getGiftCardEvents,
        modelFromJson: (responseBody, statusCode) => ListEventPlanData.fromJson(responseBody));
  }

  static Future<ApiResult<(ListMessageGiftCardData, int), ApiException>> getListMessageGiftCardRequest(
      {required int eventId}) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters['event'] = eventId;
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getGiftCardMessageList,
        queryParameters: queryParameters,
        modelFromJson: (responseBody, statusCode) => ListMessageGiftCardData.fromJson(responseBody));
  }

  static Future<ApiResult<(ListDeliveryDateData, int), ApiException>> getListDeliveryDateData() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getGiftCardDeliveryDates,
        modelFromJson: (responseBody, statusCode) => ListDeliveryDateData.fromJson(responseBody));
  }

  static Future<ApiResult<(PhysicalGiftCardInternetPayData, int), ApiException>> payPhysicalGiftCardInternet({
    required PhysicalGiftCardDataRequest physicalGiftCardDataRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.payPhysicalGiftCard,
        data: physicalGiftCardDataRequest,
        modelFromJson: (responseBody, statusCode) => PhysicalGiftCardInternetPayData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> payPhysicalGiftCardWallet({
    required PhysicalGiftCardDataRequest physicalGiftCardDataRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.payPhysicalGiftCard,
        data: physicalGiftCardDataRequest,
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }
}
