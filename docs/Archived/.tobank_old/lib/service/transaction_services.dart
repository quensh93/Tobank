import 'dart:async';

import '../model/transaction/request/transaction_filter_data.dart';
import '../model/transaction/response/list_transaction_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class TransactionServices {
  TransactionServices._();

  static Future<ApiResult<(ListTransactionData, int), ApiException>> getTransactionItemsRequest({
    required TransactionFilterData transactionFilterData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getUserTransactions,
        queryParameters: transactionFilterData.toQueryParameters(),
        modelFromJson: (responseBody, statusCode) => ListTransactionData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> getTransactionByIdRequest({
    required int id,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getUserTransactions,
        slug: id.toString(),
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> getTransactionByRefId({
    required String refId,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getUserTransactionByRefId,
        slug: refId,
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }
}
