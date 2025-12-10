import 'dart:async';

import '../model/other/app_version_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import '../model/wallet/request/charge_wallet_request_data.dart';
import '../model/wallet/request/customer_info_wallet_detail_request_data.dart';
import '../model/wallet/request/transfer_wallet_data.dart';
import '../model/wallet/response/charge_wallet_response_data.dart';
import '../model/wallet/response/customer_info_wallet_detail_response_data.dart';
import '../model/wallet/response/wallet_balance_response_data.dart';
import '../model/wallet/response/wallet_detail_data.dart';
import 'core/api_core.dart';

class WalletServices {
  WalletServices._();

  static Future<ApiResult<(WalletDetailData, int), ApiException>> getWalletDetailRequest({
    required String type,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters['type'] = type;

    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getUserWalletDetail,
        modelFromJson: (responseBody, statusCode) => WalletDetailData.fromJson(responseBody));
  }

  static Future<ApiResult<(ChargeWalletInternetResponseData, int), ApiException>> chargeWalletInternetRequest({
    required ChargeWalletRequestData chargeWalletData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.chargeWalletRequest,
        data: chargeWalletData,
        modelFromJson: (responseBody, statusCode) => ChargeWalletInternetResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> chargeWalletRequest({
    required ChargeWalletRequestData chargeWalletData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.chargeWalletRequest,
        data: chargeWalletData,
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(WalletBalanceResponseData, int), ApiException>> getWalletBalance() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getWalletBalance,
        modelFromJson: (responseBody, statusCode) => WalletBalanceResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> transferWalletToWalletRequest({
    required TransferWalletData transferWalletData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.transferWalletRequest,
        data: transferWalletData,
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(Object, int), ApiException>> getCustomerInfoWalletDetailRequest({
    required CustomerInfoWalletDetailRequestData customerInfoWalletDetailRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getCustomerInfoWalletRequest,
      data: customerInfoWalletDetailRequestData,
      modelFromJson: (responseBody, statusCode) {
        switch (statusCode) {
          case 420:
            return AppVersionData.fromJson(responseBody);
          default: // Only 200
            return CustomerInfoWalletDetailResponseData.fromJson(responseBody);
        }
      },
    );
  }
}
