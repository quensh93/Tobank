import 'dart:async';

import '../model/bpms/request/applicant_task_list_request_data.dart';
import '../model/bpms/request/check_personal_info_request_data.dart';
import '../model/bpms/request/complete_task_request_data.dart';
import '../model/bpms/request/get_average_minimum_deposit_amount_for_loan_request_data.dart';
import '../model/bpms/request/get_task_contract_document_request_data.dart';
import '../model/bpms/request/get_task_data_request_data.dart';
import '../model/bpms/request/process_detail_request_data.dart';
import '../model/bpms/request/process_start_form_data_request_data.dart';
import '../model/bpms/request/start_process_request_data.dart';
import '../model/bpms/request/upload_task_contract_document_request_data.dart';
import '../model/bpms/request/user_process_instances_request_data.dart';
import '../model/bpms/response/applicant_task_list_response_data.dart';
import '../model/bpms/response/check_personal_info_response_data.dart';
import '../model/bpms/response/complete_task_response_data.dart';
import '../model/bpms/response/get_average_minimum_deposit_amount_for_loan_response_data.dart';
import '../model/bpms/response/get_task_contract_document_response_data.dart';
import '../model/bpms/response/get_task_data_response_data.dart';
import '../model/bpms/response/process_detail_response_data.dart';
import '../model/bpms/response/process_start_form_data_response_data.dart';
import '../model/bpms/response/start_process_response_data.dart';
import '../model/bpms/response/upload_task_contract_document_response_data.dart';
import '../model/bpms/response/user_process_instances_response_data.dart';
import '../model/common/base_response_data.dart';
import 'core/api_client.dart';
import 'core/api_exception.dart';
import 'core/api_provider.dart';
import 'core/api_result_model.dart';

class BPMSServices {
  BPMSServices._();

  static Future<ApiResult<(UserProcessInstancesResponse, int), ApiException>> getUserProcessInstances({
    required UserProcessInstancesRequest userProcessInstances,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getUserProcessInstances,
      data: userProcessInstances,
      modelFromJson: (responseBody, statusCode) => UserProcessInstancesResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(ProcessDetailResponse, int), ApiException>> getProcessDetail({
    required ProcessDetailRequest processDetailRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getProcessDetail,
      data: processDetailRequest,
      modelFromJson: (responseBody, statusCode) => ProcessDetailResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(ApplicantTaskListResponse, int), ApiException>> getApplicantTaskList({
    required ApplicantTaskListRequest applicantTaskListRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getApplicantTaskList,
      data: applicantTaskListRequest,
      modelFromJson: (responseBody, statusCode) => ApplicantTaskListResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(ProcessStartFormDataResponse, int), ApiException>> getProcessStartFormData({
    required ProcessStartFormDataRequest processStartFormDataRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getProcessStartFormData,
      data: processStartFormDataRequest,
      modelFromJson: (responseBody, statusCode) => ProcessStartFormDataResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(GetTaskDataResponse, int), ApiException>> getTaskData({
    required GetTaskDataRequest getTaskDataRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getTaskData,
      data: getTaskDataRequest,
      modelFromJson: (responseBody, statusCode) => GetTaskDataResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(GetTaskContractDocumentResponse, int), ApiException>> getTaskContractDocument({
    required String templateName,
    required GetTaskContractDocumentRequest getTaskContractDocumentRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getTaskContractDocument,
      data: getTaskContractDocumentRequest,
      slug: templateName,
      modelFromJson: (responseBody, statusCode) => GetTaskContractDocumentResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(UploadTaskContractDocumentResponse, int), ApiException>> uploadTaskContractDocument({
    required UploadTaskContractDocumentRequestData uploadTaskContractDocumentRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.uploadTaskContractDocument,
      data: uploadTaskContractDocumentRequestData,
      modelFromJson: (responseBody, statusCode) => UploadTaskContractDocumentResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(StartProcessResponse, int), ApiException>> startProcess({
    required StartProcessRequest startProcessRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.startProcess,
      data: startProcessRequest,
      modelFromJson: (responseBody, statusCode) => StartProcessResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(Object, int), ApiException>> startProcessWithCBSCheck({
    required StartProcessRequest startProcessRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.startProcess,
        data: startProcessRequest,
        modelFromJson: (responseBody, statusCode) {
          switch (statusCode) {
            case 409: // Marriage & Children Loan CBS
              return BaseResponseData.fromJson(responseBody);
            default: // Only 200
              return StartProcessResponse.fromJson(responseBody);
          }
        });
  }

  static Future<ApiResult<(CompleteTaskResponse, int), ApiException>> completeTask({
    required CompleteTaskRequest completeTaskRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.completeTask,
      data: completeTaskRequest,
      modelFromJson: (responseBody, statusCode) => CompleteTaskResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(Object, int), ApiException>> completeTaskWithCBSCheck({
    required CompleteTaskRequest completeTaskRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.completeTask,
      data: completeTaskRequest,
      modelFromJson: (responseBody, statusCode) {
        switch (statusCode) {
          case 409: // Marriage & Children Loan Submit Guarantee CBS
            return BaseResponseData.fromJson(responseBody);
          default: // Only 200
            return CompleteTaskResponse.fromJson(responseBody);
        }
      },
    );
  }

  static Future<ApiResult<(GetAverageMinimumDepositAmountForLoanResponse, int), ApiException>>
      getAverageMinimumDepositAmountForLoan({
    required GetAverageMinimumDepositAmountForLoanRequest getAverageMinimumDepositAmountForLoanRequest,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getAverageMinimumDepositAmountForLoan,
      data: getAverageMinimumDepositAmountForLoanRequest,
      modelFromJson: (responseBody, statusCode) => GetAverageMinimumDepositAmountForLoanResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CheckPersonalInfoResponseData, int), ApiException>> checkPersonalInfo({
    required CheckPersonalInfoRequestData checkPersonalInfoRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.smartCheckPersonInfo,
      data: checkPersonalInfoRequestData,
      modelFromJson: (responseBody, statusCode) => CheckPersonalInfoResponseData.fromJson(responseBody),
    );
  }
}
