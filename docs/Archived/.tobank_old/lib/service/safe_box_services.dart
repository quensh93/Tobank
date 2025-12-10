import '../model/safe_box/request/submit_safe_box_request_data.dart';
import '../model/safe_box/request/submit_visit_safe_box_request_data.dart';
import '../model/safe_box/response/branch_list_response_data.dart';
import '../model/safe_box/response/refer_date_time_list_response_data.dart';
import '../model/safe_box/response/safe_box_city_list_response_data.dart';
import '../model/safe_box/response/safe_box_internet_pay_data.dart';
import '../model/safe_box/response/submit_visit_safe_box_response_data.dart';
import '../model/safe_box/response/user_safe_box_list_response_data.dart';
import '../model/safe_box/response/user_visit_list_response_data.dart';
import '../model/safe_box/response/visit_date_time_list_response_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class SafeBoxServices {
  SafeBoxServices._();

  static Future<ApiResult<(UserSafeBoxListResponseData, int), ApiException>> getUserSafeBoxListRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getUserSafeBoxes,
        modelFromJson: (responseBody, statusCode) => UserSafeBoxListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(BranchListResponseData, int), ApiException>> getBranchListRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getSafeBoxBranches,
        modelFromJson: (responseBody, statusCode) => BranchListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ReferDateTimeListResponseData, int), ApiException>> getReferDateTimeRequest({
    required int branchId,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters['branch_id'] = branchId;

    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getSafeBoxReferDate,
        queryParameters: queryParameters,
        modelFromJson: (responseBody, statusCode) => ReferDateTimeListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> safeBoxWalletPayment({
    required SubmitSafeBoxRequestData submitSafeBoxRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.paySafeBoxCost,
        data: submitSafeBoxRequestData,
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(SafeBoxInternetPayData, int), ApiException>> safeBoxInternetPayment({
    required SubmitSafeBoxRequestData submitSafeBoxRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.paySafeBoxCost,
        data: submitSafeBoxRequestData,
        modelFromJson: (responseBody, statusCode) => SafeBoxInternetPayData.fromJson(responseBody));
  }

  static Future<ApiResult<(UserVisitListResponseData, int), ApiException>> getListOfVisitRequest({
    required int userFundId,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters['user_fund_id'] = userFundId;

    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getSafeBoxVisitDates,
        queryParameters: queryParameters,
        modelFromJson: (responseBody, statusCode) => UserVisitListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(SubmitVisitSafeBoxResponseData, int), ApiException>> submitVisitRequest({
    required SubmitVisitSafeBoxRequestData submitVisitSafeBoxRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.submitSafeBoxVisitRequest,
        data: submitVisitSafeBoxRequestData,
        modelFromJson: (responseBody, statusCode) => SubmitVisitSafeBoxResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(VisitDateTimeListResponseData, int), ApiException>> getVisitDateTimeRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getSafeBoxVisitDateTime,
        modelFromJson: (responseBody, statusCode) => VisitDateTimeListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(SafeBoxCityListResponseData, int), ApiException>> getCityListRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getSafeBoxCities,
        modelFromJson: (responseBody, statusCode) => SafeBoxCityListResponseData.fromJson(responseBody));
  }
}
