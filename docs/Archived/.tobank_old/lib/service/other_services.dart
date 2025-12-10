import 'dart:async';

import '../model/other/response/other_item_data.dart';
import 'core/api_core.dart';

class OtherServices {
  OtherServices._();

  static Future<ApiResult<(OtherItemData, int), ApiException>> getFirstRulesRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageDataWithoutToken,
        slug: 'tos',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getRulesRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'tos',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getAboutRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'about',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getShccRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'shcc',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getShabahangRules() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'shabahang-rules',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getShabahangDepositShortTermRules() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'shabahang-short-term-rules',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getShabahangDepositLongTermRules() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'shabahang-long-term-rules',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getShabahangDepositGharzolhasaneRules() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'shabahang-gharzolhasane-rules',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getSafeBoxRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'deposit-fund-rules',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getRequestPromissoryRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'promissory-request-rules',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getRequestPromissoryEndorsementRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'promissory_endorsement',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getChildrenLoanRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'children-loan',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getCreditCardRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'credit-card-facility',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getMarriageLoanRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'marriage-loan',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getMicroLendingLoanRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'tobank-micro-lending-loan',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getMicroLendingLoanCreditRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'tobank-micro-lending-loan-credit-rule',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getParsaLoanRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'tobank-parsa-loan-credit-rule',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getParsaLoanCreditRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'tobank-parsa-loan',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getMilitaryGuaranteeRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'military-guarantee',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getRayanCreditCardFacilityRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'rayan-credit-card-facility',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }

  static Future<ApiResult<(OtherItemData, int), ApiException>> getRetailLoanRuleRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getPageData,
        slug: 'retail-loan',
        modelFromJson: (responseBody, statusCode) => OtherItemData.fromJson(responseBody));
  }
}
