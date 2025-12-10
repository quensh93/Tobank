import 'dart:async';

import '../model/azki_loan/request/submit_azki_loan_collateral_promissory_request_data.dart';
import '../model/azki_loan/request/submit_azki_loan_contract_request_data.dart';
import '../model/azki_loan/response/get_azki_loan_collateral_promissory_data_response_data.dart';
import '../model/azki_loan/response/get_azki_loan_contract_response_data.dart';
import '../model/azki_loan/response/get_azki_loan_current_step_response_data.dart';
import '../model/azki_loan/response/submit_azki_loan_collateral_promissory_response_data.dart';
import '../model/azki_loan/response/submit_azki_loan_contract_response_data.dart';
import 'core/api_core.dart';

class AzkiLoanServices {
  AzkiLoanServices._();

  static Future<ApiResult<(GetAzkiLoanCurrentStepResponse, int), ApiException>> getCurrentStep() async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getAzkiLoanCurrentStep,
      modelFromJson: (responseBody, statusCode) => GetAzkiLoanCurrentStepResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(GetAzkiLoanDetailResponse, int), ApiException>> getAzkiLoanDetail() async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getAzkiLoanDetail,
      modelFromJson: (responseBody, statusCode) => GetAzkiLoanDetailResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(SubmitAzkiLoanCollateralPromissoryResponse, int), ApiException>>
      submitCollateralPromissoryData({
    required SubmitAzkiLoanCollateralPromissoryRequest submitAzkiLoanCollateralPromissoryRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.submitAzkiLoanCollateralPromissoryData,
      data: submitAzkiLoanCollateralPromissoryRequest,
      modelFromJson: (responseBody, statusCode) => SubmitAzkiLoanCollateralPromissoryResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(GetAzkiLoanContractResponse, int), ApiException>> getAzkiLoanContractRequest() async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getAzkiLoanContract,
      modelFromJson: (responseBody, statusCode) => GetAzkiLoanContractResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(SubmitAzkiLoanContractResponseModel, int), ApiException>>
      submitSignedAzkiLoanContractRequest({
    required int documentId,
    required SubmitAzkiLoanContractRequestModel submitAzkiLoanContractRequestModel,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.submitAzkiLoanSignedContract,
      slug: documentId.toString(),
      data: submitAzkiLoanContractRequestModel,
      modelFromJson: (responseBody, statusCode) => SubmitAzkiLoanContractResponseModel.fromJson(responseBody),
    );
  }
}
