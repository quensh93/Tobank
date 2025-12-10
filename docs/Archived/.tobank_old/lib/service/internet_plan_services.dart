import 'dart:async';

import '../model/internet/request/internet_plan_request_data.dart';
import '../model/internet/response/internet_plan_data.dart';
import '../model/internet/response/internet_plan_pay_internet_data.dart';
import '../model/internet/response/internet_static_data_model.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class InternetPlanServices {
  InternetPlanServices._();

  static Future<ApiResult<(InternetStaticDataModel, int), ApiException>> getInternetStaticData() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getInternetPlansStaticData,
        modelFromJson: (responseBody, statusCode) => InternetStaticDataModel.fromJson(responseBody));
  }

  static Future<ApiResult<(InternetPlanData, int), ApiException>> getInternetPlanRequest({
    required String operatorName,
    required String planType,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters['operator'] = operatorName;
    queryParameters['plan'] = planType;

    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getInternetPlans,
        queryParameters: queryParameters,
        modelFromJson: (responseBody, statusCode) => InternetPlanData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> payInternetPlanWalletRequest({
    required InternetPlanRequestData internetData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.payInternetPlan,
        data: internetData,
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(InternetPlanPayInternetData, int), ApiException>> payInternetPlanInternetRequest({
    required InternetPlanRequestData internetData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.payInternetPlan,
        data: internetData,
        modelFromJson: (responseBody, statusCode) => InternetPlanPayInternetData.fromJson(responseBody));
  }
}
