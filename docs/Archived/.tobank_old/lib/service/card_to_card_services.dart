import 'dart:async';
import '../model/card_to_card/request/card_owner_request_data.dart';
import '../model/card_to_card/request/card_to_card_dynamic_password_request_data.dart';
import '../model/card_to_card/request/card_to_card_request_data.dart';
import '../model/card_to_card/response/card_owner_data.dart';
import '../model/card_to_card/response/otp_bank_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class CardToCardServices {
  CardToCardServices._();

  static Future<ApiResult<(CardOwnerResponseData, int), ApiException>> getCardOwnerRequest({
    required CardOwnerRequestData cardOwnerRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getCardOwner,
      data: cardOwnerRequestData,
      modelFromJson: (responseBody, statusCode) => CardOwnerResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> cardToCardRequest({
    required CardToCardRequestData cardToCardData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.cardToCard,
      data: cardToCardData,
      modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(OtpBankResponse, int), ApiException>> getDynamicPassword({
    required CardToCardDynamicPasswordRequestData cardToCardDynamicPasswordRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getCardDynamicPassword,
      data: cardToCardDynamicPasswordRequestData,
      modelFromJson: (responseBody, statusCode) => OtpBankResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> cardToCardGardeshgaryRequest({
    required CardToCardRequestData cardToCardData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.cardToCardGardeshgary,
      data: cardToCardData,
      modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody),
    );
  }
}
