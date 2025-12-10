import '../model/bpms/parsa_loan/request/check_deposit_request_data.dart';
import '../model/bpms/parsa_loan/request/choose_branch_request_data.dart';
import '../model/bpms/parsa_loan/request/choose_occupation_request_data.dart';
import '../model/bpms/parsa_loan/request/choose_residency_type_request_data.dart';
import '../model/bpms/parsa_loan/request/parsa_loan_inquiry_cbs_request_data.dart';
import '../model/bpms/parsa_loan/request/parsa_loan_submit_contract_request_data.dart';
import '../model/bpms/parsa_loan/request/parsa_loan_submit_plan_request_data.dart';
import '../model/bpms/parsa_loan/request/parsa_loan_submit_price_request_data.dart';
import '../model/bpms/parsa_loan/request/parsa_loan_submit_promissory_request_data.dart';
import '../model/bpms/parsa_loan/request/task/parsa_lending_start_process_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_10_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_11_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_12_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_1_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_2_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_3_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_4_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_5_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_6_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_7_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_8_request_data.dart';
import '../model/bpms/parsa_loan/request/task/task_complete_state_9_request_data.dart';
import '../model/bpms/parsa_loan/request/upload_document_request_data.dart';
import '../model/bpms/parsa_loan/response/branch_list_response_data.dart';
import '../model/bpms/parsa_loan/response/check_access_response_data.dart';
import '../model/bpms/parsa_loan/response/check_deposit_response_data.dart';
import '../model/bpms/parsa_loan/response/choose_branch_response_data.dart';
import '../model/bpms/parsa_loan/response/choose_occupation_response_data.dart';
import '../model/bpms/parsa_loan/response/choose_residency_type_response_data.dart';
import '../model/bpms/parsa_loan/response/deposit_list_response_data.dart';
import '../model/bpms/parsa_loan/response/occupation_list_response_data.dart';
import '../model/bpms/parsa_loan/response/parsa_lending_get_current_step_response_data.dart';
import '../model/bpms/parsa_loan/response/parsa_lending_get_loan_detail_response_data.dart';
import '../model/bpms/parsa_loan/response/parsa_loan_check_samat_cbs_response_data.dart';
import '../model/bpms/parsa_loan/response/parsa_loan_check_sana_response_data.dart';
import '../model/bpms/parsa_loan/response/parsa_loan_get_promissory_response_data.dart';
import '../model/bpms/parsa_loan/response/parsa_loan_submit_contract_response_data.dart';
import '../model/bpms/parsa_loan/response/parsa_loan_submit_plan_response_data.dart';
import '../model/bpms/parsa_loan/response/parsa_loan_submit_price_response_data.dart';
import '../model/bpms/parsa_loan/response/parsa_loan_submit_promissory_response_data.dart';
import '../model/bpms/parsa_loan/response/residency_type_list_response_data.dart';
import '../model/bpms/parsa_loan/response/task/parsa_lending_start_process_response_data.dart';
import '../model/bpms/parsa_loan/response/task/parsa_lending_upload_document_response_data.dart';
import '../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import 'core/api_core.dart';

class ParsaLoanServices {
  ParsaLoanServices._();

  static Future<ApiResult<(ParsaLoanCheckSanaResponseData, int), ApiException>> checkSanaRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCheckSana,
        modelFromJson: (responseBody, statusCode) => ParsaLoanCheckSanaResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(OccupationListResponseData, int), ApiException>> getOccupationListRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingOccupationList,
        modelFromJson: (responseBody, statusCode) => OccupationListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ChooseOccupationResponseData, int), ApiException>> chooseOccupationRequest(
      {required ChooseOccupationRequestData chooseOccupationRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingChooseOccupation,
        data: chooseOccupationRequestData,
        modelFromJson: (responseBody, statusCode) => ChooseOccupationResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(BranchListResponseData, int), ApiException>> getBranchListRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingBranchList,
        modelFromJson: (responseBody, statusCode) => BranchListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ChooseBranchResponseData, int), ApiException>> chooseBranchRequest(
      {required ChooseBranchRequestData chooseBranchRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingChooseBranch,
        data: chooseBranchRequestData,
        modelFromJson: (responseBody, statusCode) => ChooseBranchResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ResidencyTypeListResponseData, int), ApiException>> getResidencyTypeListRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingResidencyList,
        modelFromJson: (responseBody, statusCode) => ResidencyTypeListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ChooseResidencyTypeResponseData, int), ApiException>> chooseResidencyTypeRequest(
      {required ChooseResidencyTypeRequestData chooseResidencyTypeRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingChooseResidency,
        data: chooseResidencyTypeRequestData,
        modelFromJson: (responseBody, statusCode) => ChooseResidencyTypeResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(CheckAccessResponseData, int), ApiException>> checkAccessRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCheckAccess,
        modelFromJson: (responseBody, statusCode) => CheckAccessResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(DepositListResponseData, int), ApiException>> getDepositList() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingDepositList,
        modelFromJson: (responseBody, statusCode) => DepositListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(CheckDepositResponseData, int), ApiException>> checkDepositRequest(
      {required CheckDepositRequestData checkDepositRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCheckDeposit,
        data: checkDepositRequestData,
        modelFromJson: (responseBody, statusCode) => CheckDepositResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLendingGetCurrentStepResponseData, int), ApiException>> getCurrentStepRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingGetCurrentStep,
        modelFromJson: (responseBody, statusCode) => ParsaLendingGetCurrentStepResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLendingGetLoanDetailResponseData, int), ApiException>> getLoanDetailRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingGetLoanDetail,
        modelFromJson: (responseBody, statusCode) => ParsaLendingGetLoanDetailResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLoanGetPromissoryResponseData, int), ApiException>>
      getParsaLoanPromissoryRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingGetPromissory,
        modelFromJson: (responseBody, statusCode) => ParsaLoanGetPromissoryResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLoanSubmitPromissoryResponseData, int), ApiException>> submitParsaLoanPromissoryRequest(
      {required ParsaLoanSubmitPromissoryRequestData parsaLoanSubmitPromissoryRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingSubmitPromissory,
        data: parsaLoanSubmitPromissoryRequestData,
        modelFromJson: (responseBody, statusCode) => ParsaLoanSubmitPromissoryResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLendingStartProcessResponseData, int), ApiException>> parsaLendingStartProcessRequest(
      {required ParsaLendingStartProcessRequestData parsaLendingStartProcessRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingStartProcess,
        data: parsaLendingStartProcessRequestData,
        modelFromJson: (responseBody, statusCode) => ParsaLendingStartProcessResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState1CompleteTaskRequest(
      {required TaskCompleteState1RequestData taskCompleteState1RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState1RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState2CompleteTaskRequest(
      {required TaskCompleteState2RequestData taskCompleteState2RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState2RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState3CompleteTaskRequest(
      {required TaskCompleteState3RequestData taskCompleteState3RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState3RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState4CompleteTaskRequest(
      {required TaskCompleteState4RequestData taskCompleteState4RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState4RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState5CompleteTaskRequest(
      {required TaskCompleteState5RequestData taskCompleteState5RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState5RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState6CompleteTaskRequest(
      {required TaskCompleteState6RequestData taskCompleteState6RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState6RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState7CompleteTaskRequest(
      {required TaskCompleteState7RequestData taskCompleteState7RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState7RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState8CompleteTaskRequest(
      {required TaskCompleteState8RequestData taskCompleteState8RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState8RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState9CompleteTaskRequest(
      {required TaskCompleteState9RequestData taskCompleteState9RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState9RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState10CompleteTaskRequest(
      {required TaskCompleteState10RequestData taskCompleteState10RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState10RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState11CompleteTaskRequest(
      {required TaskCompleteState11RequestData taskCompleteState11RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState11RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(TaskCompleteResponseData, int), ApiException>> parsaLendingState12CompleteTaskRequest(
      {required TaskCompleteState12RequestData taskCompleteState12RequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCompleteTask,
        data: taskCompleteState12RequestData,
        modelFromJson: (responseBody, statusCode) => TaskCompleteResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLendingUploadDocumentResponseData, int), ApiException>>
      parsaLendingUploadDocumentRequest({required UploadDocumentRequestData uploadDocumentRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingUploadDocument,
        data: uploadDocumentRequestData,
        modelFromJson: (responseBody, statusCode) => ParsaLendingUploadDocumentResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLoanSubmitPlanResponseData, int), ApiException>> submitParsaLoanPlanRequest(
      {required ParsaLoanSubmitPlanRequestData parsaLoanSubmitPlanRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingSubmitPlan,
        data: parsaLoanSubmitPlanRequestData,
        modelFromJson: (responseBody, statusCode) => ParsaLoanSubmitPlanResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLoanSubmitPriceResponseData, int), ApiException>> submitParsaLoanPriceRequest(
      {required ParsaLoanSubmitPriceRequestData parsaLoanSubmitPriceRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingSubmitPrice,
        data: parsaLoanSubmitPriceRequestData,
        modelFromJson: (responseBody, statusCode) => ParsaLoanSubmitPriceResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLoanSubmitContractResponseData, int), ApiException>>
      submitParsaLoanSignedContractRequest(
          {required ParsaLoanSubmitContractRequestData parsaLoanSubmitContractRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingSubmitContract,
        data: parsaLoanSubmitContractRequestData,
        modelFromJson: (responseBody, statusCode) => ParsaLoanSubmitContractResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLoanCheckSamatCbsResponseData, int), ApiException>> checkParsaLoanSamatCbs() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingCheckSamatCbs,
        modelFromJson: (responseBody, statusCode) => ParsaLoanCheckSamatCbsResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(ParsaLoanCheckSamatCbsResponseData, int), ApiException>> inquiryParsaLoanCbs(
      {required ParsaLoanInquiryCbsRequestData parsaLoanInquiryCbsRequestData}) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.parsaLendingInquiryCbs,
        data: parsaLoanInquiryCbsRequestData,
        modelFromJson: (responseBody, statusCode) => ParsaLoanCheckSamatCbsResponseData.fromJson(responseBody));
  }
}
