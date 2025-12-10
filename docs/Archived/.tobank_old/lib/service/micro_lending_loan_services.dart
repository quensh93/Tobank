import 'dart:async';

import '../model/micro_lending/request/micro_lending_deposit_submit_request_data.dart';
import '../model/micro_lending/request/micro_lending_fee_payment_request_data.dart';
import '../model/micro_lending/request/micro_lending_price_submit_request_data.dart';
import '../model/micro_lending/request/micro_lending_submit_contract_request_data.dart';
import '../model/micro_lending/request/micro_loan_inquiry_cbs_request_data.dart';
import '../model/micro_lending/response/micro_lending_check_access_response.dart';
import '../model/micro_lending/response/micro_lending_check_deposit_response.dart';
import '../model/micro_lending/response/micro_lending_check_sana_response.dart';
import '../model/micro_lending/response/micro_lending_fee_internet_pay_data.dart';
import '../model/micro_lending/response/micro_lending_get_current_step_response.dart';
import '../model/micro_lending/response/micro_lending_get_deposits_response.dart';
import '../model/micro_lending/response/micro_lending_get_loan_detail_response.dart';
import '../model/micro_lending/response/micro_lending_submit_contract_response.dart';
import '../model/micro_lending/response/micro_lending_submit_price_response.dart';
import '../model/micro_lending/response/micro_loan_check_samat_cbs_response_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class MicroLendingLoanServices {
  MicroLendingLoanServices._();

  static Future<ApiResult<(MicroLendingGetCurrentStepResponse, int), ApiException>> getCurrentStepRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.microLendingGetCurrentStep,
        modelFromJson: (responseBody, statusCode) => MicroLendingGetCurrentStepResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(MicroLendingCheckAccessResponse, int), ApiException>> checkAccessRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.microLendingCheckAccess,
        modelFromJson: (responseBody, statusCode) => MicroLendingCheckAccessResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(MicroLendingGetDepositsResponse, int), ApiException>> getDepositsRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.microLendingGetDeposits,
        modelFromJson: (responseBody, statusCode) => MicroLendingGetDepositsResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(MicroLendingCheckDepositResponse, int), ApiException>> checkDepositRequest({
    required MicroLendingSubmitDepositRequest microLendingSubmitDepositRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.microLendingCheckDeposit,
        data: microLendingSubmitDepositRequest,
        modelFromJson: (responseBody, statusCode) => MicroLendingCheckDepositResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(MicroLendingCheckSanaResponse, int), ApiException>> checkSanaRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.microLendingCheckSana,
        modelFromJson: (responseBody, statusCode) => MicroLendingCheckSanaResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> feePaymentRequest({
    required MicroLendingFeePaymentRequest microLendingFeePaymentRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.microLendingPayFee,
      data: microLendingFeePaymentRequest,
      modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(MicroLendingFeeInternetPayData, int), ApiException>> internetFeePaymentRequest({
    required MicroLendingFeePaymentRequest microLendingFeePaymentRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.microLendingPayFee,
      data: microLendingFeePaymentRequest,
      modelFromJson: (responseBody, statusCode) => MicroLendingFeeInternetPayData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(MicroLendingSubmitPriceAndDurationResponse, int), ApiException>>
      submitPriceAndDurationRequest({
    required MicroLendingSubmitPriceAndDurationRequest microLendingSubmitPriceAndDurationRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.microLendingSubmitPriceAndDuration,
      data: microLendingSubmitPriceAndDurationRequest,
      modelFromJson: (responseBody, statusCode) => MicroLendingSubmitPriceAndDurationResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(MicroLendingSubmitContractResponse, int), ApiException>> submitSignedContractRequest({
    required MicroLendingSubmitContractRequest microLendingSubmitContractRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.microLendingSubmitSignedContract,
      data: microLendingSubmitContractRequest,
      modelFromJson: (responseBody, statusCode) => MicroLendingSubmitContractResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(MicroLendingGetLoanDetailResponse, int), ApiException>> getLoanDetailRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.microLendingGetLoanDetail,
        modelFromJson: (responseBody, statusCode) => MicroLendingGetLoanDetailResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(MicroLoanCheckSamatCbsResponseData, int), ApiException>> checkMicroLoanSamatCbs() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.microLendingCheckSamatCbs,
        modelFromJson: (responseBody, statusCode) => MicroLoanCheckSamatCbsResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(MicroLoanCheckSamatCbsResponseData, int), ApiException>> inquiryMicroLoanCbs(
      {required MicroLoanInquiryCbsRequestData microLoanInquiryCbsRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.microLendingInquiryCbs,
        data: microLoanInquiryCbsRequestData,
        modelFromJson: (responseBody, statusCode) => MicroLoanCheckSamatCbsResponseData.fromJson(responseBody));
  }
}
