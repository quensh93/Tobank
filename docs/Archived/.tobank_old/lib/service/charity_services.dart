import 'dart:async';

import '../model/charity/request/charity_payment_request_data.dart';
import '../model/charity/response/charity_internet_pay_data.dart';
import '../model/charity/response/list_charity_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class CharityServices {
  CharityServices._();

  static Future<ApiResult<(ListCharityData, int), ApiException>> getCharitiesRequest() async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getCharities,
      modelFromJson: (responseBody, statusCode) => ListCharityData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> charityWalletPaymentRequest({
    required CharityPaymentRequestData charityPaymentRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.donateCharities,
      slug: charityPaymentRequestData.charityId.toString(),
      data: charityPaymentRequestData,
      modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CharityInternetPayData, int), ApiException>> charityInternetPaymentRequest({
    required CharityPaymentRequestData charityPaymentRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.donateCharities,
      slug: charityPaymentRequestData.charityId.toString(),
      data: charityPaymentRequestData,
      modelFromJson: (responseBody, statusCode) => CharityInternetPayData.fromJson(responseBody),
    );
  }
}
