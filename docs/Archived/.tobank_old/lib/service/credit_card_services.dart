import '../model/bpms/credit_card_facility/request/credit_card_facility_check_deposit_request_data.dart';
import '../model/bpms/credit_card_facility/response/credit_card_facility_access_response_data.dart';
import '../model/bpms/credit_card_facility/response/credit_card_facility_check_deposit_response_data.dart';
import '../model/bpms/credit_card_facility/response/credit_card_facility_deposit_list_response_data.dart';
import '../model/common/error_response_data.dart';
import 'core/api_core.dart';

class CreditCardServices {
  CreditCardServices._();

  static Future<ApiResult<(CreditCardFacilityAccessResponseData, int), ApiException<ErrorResponseData>>>
      creditCardFacilityCheckAccessRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.creditCardFacilityAccess,
        modelFromJson: (responseBody, statusCode) => CreditCardFacilityAccessResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(CreditCardFacilityDepositListResponseData, int), ApiException>>
      creditCardFacilityDepositListRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.creditCardFacilityDepositList,
        modelFromJson: (responseBody, statusCode) => CreditCardFacilityDepositListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(CreditCardFacilityCheckDepositResponseData, int), ApiException>> checkDepositRequest({
    required CreditCardFacilityCheckDepositRequestData creditCardFacilityCheckDepositRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.creditCardFacilityCheckDeposit,
        data: creditCardFacilityCheckDepositRequestData,
        modelFromJson: (responseBody, statusCode) => CreditCardFacilityCheckDepositResponseData.fromJson(responseBody));
  }
}
