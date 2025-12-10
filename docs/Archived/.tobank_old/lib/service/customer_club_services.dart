import 'dart:async';

import '../model/customer_club/response/customer_club_discount_effect_response.dart';
import '../model/customer_club/response/customer_club_web_view_link_response.dart';
import 'core/api_core.dart';

class CustomerClubServices {
  CustomerClubServices._();

  static Future<ApiResult<(CustomerClubDiscountEffectResponse, int), ApiException>> getDiscountEffectRest({
    required int amount,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters['amount'] = amount;
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getDiscountEffect,
        queryParameters: queryParameters,
        modelFromJson: (responseBody, statusCode) => CustomerClubDiscountEffectResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(CustomerClubWebViewResponseData, int), ApiException>>
      getCustomerClubWebViewLinkRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getCustomerClubWebViewLink,
        modelFromJson: (responseBody, statusCode) => CustomerClubWebViewResponseData.fromJson(responseBody));
  }
}
