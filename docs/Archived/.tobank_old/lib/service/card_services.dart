import 'dart:async';

import '../model/card/request/card_block_request_data.dart';
import '../model/card/request/card_issuance_request_data.dart';
import '../model/card/request/card_issuance_template_request_data.dart';
import '../model/card/request/change_card_pin_request_data.dart';
import '../model/card/request/change_custom_card_pin_request_data.dart';
import '../model/card/request/edit_card_data_request.dart';
import '../model/card/request/edit_remote_card_request_data.dart';
import '../model/card/request/submit_card_request_data.dart';
import '../model/card/response/card_block_response_data.dart';
import '../model/card/response/card_data_response.dart';
import '../model/card/response/card_issuance_response_data.dart';
import '../model/card/response/card_issuance_template_response_data.dart';
import '../model/card/response/change_card_pin_response_data.dart';
import '../model/card/response/change_custom_card_pin_response_data.dart';
import '../model/card/response/customer_card_response_data.dart';
import '../model/card/response/edit_card_data_response.dart';
import '../model/card/response/list_bank_data.dart';
import '../model/common/base_response_data.dart';
import 'core/api_core.dart';

class CardServices {
  CardServices._();

  static Future<ApiResult<(CardDataResponse, int), ApiException>> submitCardRequest({
    required SubmitCardRequest submitCardRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.submitUserCard,
      data: submitCardRequest,
      modelFromJson: (responseBody, statusCode) => CardDataResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CardDataResponse, int), ApiException>> updateNotebookCardRequest({
    required EditNotebookCardDataRequest editNotebookCardDataRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.updateUserCard,
      data: editNotebookCardDataRequest,
      slug: editNotebookCardDataRequest.id.toString(),
      modelFromJson: (responseBody, statusCode) => CardDataResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(EditCardDataResponse, int), ApiException>> updateUserCardRequest({
    required EditUserCardDataRequest editCardDataRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.updateUserCard,
      data: editCardDataRequest,
      slug: editCardDataRequest.id.toString(),
      modelFromJson: (responseBody, statusCode) => EditCardDataResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(BaseResponseData, int), ApiException>> deleteUserCardRequest(
    int cardId,
  ) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.deleteUserCard,
      slug: cardId.toString(),
      modelFromJson: (responseBody, statusCode) => BaseResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(ListBankData, int), ApiException>> getListBankData({
    required bool isTransfer,
  }) async {
    Map<String, dynamic>? queryParameters;
    if (isTransfer) {
      queryParameters = <String, dynamic>{};
      queryParameters['is_transfer'] = 'True';
    }
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getListBankData,
      queryParameters: queryParameters,
      modelFromJson: (responseBody, statusCode) => ListBankData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CustomerCardResponseData, int), ApiException>> getCustomerCardsRequest() async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getCards,
      modelFromJson: (responseBody, statusCode) => CustomerCardResponseData.fromJson(responseBody),
    );
  }

  // Commented because maybe someday will be needed

  // static Future<CustomerCardsResponse> getCustomerCards(
  //     {required String token, required CustomerCardsRequest customerCardsRequest}) async {
  //   CustomerCardsResponse getCustomerCardsResponse = CustomerCardsResponse();
  //   final headers = AppUtil.getHTTPHeader(token);
  //
  //   try {
  //     final Map<String, dynamic> body = <String, dynamic>{};
  //     final String requestDataString = jsonEncode(customerCardsRequest.toJson());
  //     final String requestDataBase64 = base64Encode(utf8.encode(requestDataString));
  //     body['data'] = requestDataBase64;
  //     final response = await DioUtil.getDio(
  //       headers: headers,
  //       baseUrl: AppUtil.baseUrl(),
  //     ).post(
  //       'dibalite/customer/cards',
  //       data: AppUtil.encodeString(jsonEncode(body)),
  //     );
  //     final String decoded = AppUtil.getDecodedString(response.toString());
  //     LogUtil.printAPI(response);
  //     if (response.statusCode == 200) {
  //       getCustomerCardsResponse = customerCardsResponseFromJson(decoded);
  //       getCustomerCardsResponse.statusCode = response.statusCode;
  //       return getCustomerCardsResponse;
  //     } else if (response.statusCode == 400) {
  //       getCustomerCardsResponse.errorResponseModel = errorResponseDataFromJson(decoded);
  //       getCustomerCardsResponse.statusCode = response.statusCode;
  //       return getCustomerCardsResponse;
  //     } else {
  //       getCustomerCardsResponse.statusCode = response.statusCode;
  //       return getCustomerCardsResponse;
  //     }
  //   } on DioException catch (error, stack) {
  //     await Sentry.captureException(
  //       error,
  //       stackTrace: stack,
  //     );
  //     getCustomerCardsResponse.statusCode = DioUtil.getErrorStatusCode(error);
  //     return getCustomerCardsResponse;
  //   } on Exception catch (error, stack) {
  //     await Sentry.captureException(
  //       error,
  //       stackTrace: stack,
  //     );
  //     getCustomerCardsResponse.statusCode = 500;
  //     return getCustomerCardsResponse;
  //   }
  // }

  static Future<ApiResult<(CardIssuanceResponse, int), ApiException>> cardIssuance({
    required CardIssuanceRequest cardIssuanceRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.cardIssuance,
      data: cardIssuanceRequest,
      modelFromJson: (responseBody, statusCode) => CardIssuanceResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(ChangeCardPinResponse, int), ApiException>> changeCardPin({
    required ChangeCardPinRequest changeCardPinRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.changeCardPin,
      data: changeCardPinRequest,
      modelFromJson: (responseBody, statusCode) => ChangeCardPinResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CardIssuanceTemplateResponse, int), ApiException>> getCardIssuanceTemplates(
      {required CardIssuanceTemplateRequest cardIssuanceTemplateRequest}) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getCardIssuanceTemplates,
      data: cardIssuanceTemplateRequest,
      modelFromJson: (responseBody, statusCode) => CardIssuanceTemplateResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CardBlockResponseData, int), ApiException>> cardBlockRequest({
    required CardBlockRequestData cardBlockRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.blockCard,
      data: cardBlockRequestData,
      modelFromJson: (responseBody, statusCode) => CardBlockResponseData.fromJson(responseBody),
    );
  }

  // Commented because maybe someday will be needed

  // static Future<CardUnBlockResponseData> cardUnBlockRequest(
  //     {required String token, required CardUnBlockRequestData cardUnBlockRequestData}) async {
  //   CardUnBlockResponseData cardUnBlockResponseData = CardUnBlockResponseData();
  //   var headers = AppUtil.getHTTPHeader(token);
  //   try {
  //     final Map<String, dynamic> body = <String, dynamic>{};
  //     final String requestDataString = jsonEncode(cardUnBlockRequestData.toJson());
  //     final String requestDataBase64 = base64Encode(utf8.encode(requestDataString));
  //     final SignModel? sign = await AppUtil.signRequestBody(requestDataString);
  //     if (sign == null) {
  //       cardUnBlockResponseData.errorResponseModel =
  //           ErrorResponseData(message: 'امضای دیجیتال را تایید نکردید', success: false);
  //       cardUnBlockResponseData.statusCode = 400;
  //       return cardUnBlockResponseData;
  //     } else {
  //       headers = AppUtil.getSignedHTTPHeader(token: token, signData: sign);
  //       body['data'] = requestDataBase64;
  //
  //       final response = await DioUtil.getDio(
  //         headers: headers,
  //         baseUrl: AppUtil.baseUrl(),
  //       ).post(
  //         'dibalite/cards/unblock',
  //         data: AppUtil.encodeString(jsonEncode(body)),
  //       );
  //       final String decoded = AppUtil.getDecodedString(response.toString());
  //       LogUtil.printAPI(response);
  //       if (response.statusCode == 200) {
  //         cardUnBlockResponseData = cardUnBlockResponseDataFromJson(decoded);
  //         cardUnBlockResponseData.statusCode = response.statusCode;
  //         return cardUnBlockResponseData;
  //       } else if (response.statusCode == 400) {
  //         cardUnBlockResponseData.errorResponseModel = errorResponseDataFromJson(decoded);
  //         cardUnBlockResponseData.statusCode = response.statusCode;
  //         return cardUnBlockResponseData;
  //       } else {
  //         cardUnBlockResponseData.statusCode = response.statusCode;
  //         return cardUnBlockResponseData;
  //       }
  //     }
  //   } on DioException catch (error, stack) {
  //     await Sentry.captureException(
  //       error,
  //       stackTrace: stack,
  //     );
  //     cardUnBlockResponseData.statusCode = DioUtil.getErrorStatusCode(error);
  //     return cardUnBlockResponseData;
  //   } on Exception catch (error, stack) {
  //     await Sentry.captureException(
  //       error,
  //       stackTrace: stack,
  //     );
  //     cardUnBlockResponseData.statusCode = 500;
  //     return cardUnBlockResponseData;
  //   }
  // }

  static Future<ApiResult<(ChangeCustomCardPinResponseData, int), ApiException>> changeCardPinArbitrary({
    required ChangeCustomCardPinRequestData changeCustomCardPinRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.changeCardPinArbitrary,
      data: changeCustomCardPinRequestData,
      modelFromJson: (responseBody, statusCode) => ChangeCustomCardPinResponseData.fromJson(responseBody),
    );
  }
}
