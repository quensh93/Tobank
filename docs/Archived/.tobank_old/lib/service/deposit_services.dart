import 'dart:async';

import '../model/deposit/request/customer_deposits_request_data.dart';
import '../model/deposit/request/deposit_balance_request_data.dart';
import '../model/deposit/request/deposit_statement_request_data.dart';
import '../model/deposit/request/deposit_type_request_data.dart';
import '../model/deposit/request/increase_deposit_balance_request_data.dart';
import '../model/deposit/request/long_term_deposit_request_data.dart';
import '../model/deposit/request/open_deposit_request_data.dart';
import '../model/deposit/response/customer_deposits_response_data.dart';
import '../model/deposit/response/deposit_balance_response_data.dart';
import '../model/deposit/response/deposit_statement_response_data.dart';
import '../model/deposit/response/deposit_type_response_data.dart';
import '../model/deposit/response/increase_deposit_balance_response_data.dart';
import '../model/deposit/response/long_term_deposit_response_data.dart';
import '../model/deposit/response/open_deposit_response_data.dart';
import 'core/api_core.dart';

class DepositServices {
  DepositServices._();

  static Future<ApiResult<(CustomerDepositsResponse, int), ApiException>> getCustomerDeposits(
      {required CustomerDepositsRequest customerDepositsRequest}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getcustomerDeposits,
        data: customerDepositsRequest,
        modelFromJson: (responseBody, statusCode) => CustomerDepositsResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(OpenDepositResponse, int), ApiException>> openDeposit({
    required OpenDepositRequest openDepositRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.openDeposit,
        data: openDepositRequest,
        modelFromJson: (responseBody, statusCode) => OpenDepositResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(DepositTypeResponseData, int), ApiException>> getDepositTypesRequest({
    required DepositTypeRequestData depositTypeRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getDepositTypes,
        data: depositTypeRequestData,
        modelFromJson: (responseBody, statusCode) => DepositTypeResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(DepositBalanceResponseData, int), ApiException>> getDepositBalanceRequest({
    required DepositBalanceRequestData depositBalanceRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getDepositBalance,
        data: depositBalanceRequestData,
        modelFromJson: (responseBody, statusCode) => DepositBalanceResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(DepositStatementResponseData, int), ApiException>> getDepositStatementRequest({
    required DepositStatementRequestData depositStatementRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: depositStatementRequestData.pageNumber == 1
            ? ApiProviderEnum.getDepositStatement
            : ApiProviderEnum.getDepositStatementWithoutSign,
        data: depositStatementRequestData,
        modelFromJson: (responseBody, statusCode) => DepositStatementResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(LongTermDepositResponseData, int), ApiException>> openLongTermDeposit({
    required LongTermDepositRequestData longTermDepositRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.openLongTermDeposit,
        data: longTermDepositRequestData,
        modelFromJson: (responseBody, statusCode) => LongTermDepositResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(IncreaseDepositBalanceResponseData, int), ApiException>> increaseDepositBalance({
    required IncreaseDepositBalanceRequestData increaseDepositBalanceRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.increaseDepositBalance,
        data: increaseDepositBalanceRequestData,
        modelFromJson: (responseBody, statusCode) => IncreaseDepositBalanceResponseData.fromJson(responseBody));
  }
}
