import 'dart:async';

import '../model/card_balance/request/card_balance_otp_request_model.dart';
import '../model/card_balance/request/card_balance_request_model.dart';
import '../model/card_balance/response/card_balance_otp_response.dart';
import '../model/card_balance/response/card_balance_response_model.dart';
import 'core/api_core.dart';

class CardBalanceServices {
  CardBalanceServices._();

  static Future<ApiResult<(CardBalanceResponseModel, int), ApiException>> getCardBalance({
    required CardBalanceRequestModel cardBalanceRequestModel,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.cardBalance,
      data: cardBalanceRequestModel,
      modelFromJson: (responseBody, statusCode) => CardBalanceResponseModel.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CardBalanceOTPResponseModel, int), ApiException>> getDynamicPassword({
    required CardBalanceOTPRequestModel cardBalanceOTPRequestModel,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getDynamicPassword,
      data: cardBalanceOTPRequestModel,
      modelFromJson: (responseBody, statusCode) => CardBalanceOTPResponseModel.fromJson(responseBody),
    );
  }
}
