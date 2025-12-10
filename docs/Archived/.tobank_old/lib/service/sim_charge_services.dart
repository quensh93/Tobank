import 'dart:async';

import '../model/sim_charge/request/charge_sim_data.dart';
import '../model/sim_charge/response/charge_static_data.dart';
import '../model/sim_charge/response/sim_charge_internet_pay_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class SimChargeServices {
  SimChargeServices._();

  static Future<ApiResult<(ChargeStaticResponseData, int), ApiException>> getChargeStaticResponseDataRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getSimCardChargePlans,
        modelFromJson: (responseBody, statusCode) => ChargeStaticResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> simCardChargeWalletPayRequest({
    required ChargeSimData chargeSimData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.paySimCardChargePlan,
        data: chargeSimData,
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(SimChargeInternetData, int), ApiException>> simCardChargeInternetPayRequest({
    required ChargeSimData chargeSimData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.paySimCardChargePlan,
        data: chargeSimData,
        modelFromJson: (responseBody, statusCode) => SimChargeInternetData.fromJson(responseBody));
  }
}
