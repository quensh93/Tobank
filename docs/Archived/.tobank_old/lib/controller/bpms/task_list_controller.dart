import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/request/get_task_data_request_data.dart';
import '../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../model/bpms/response/get_task_data_response_data.dart';
import '../../service/bpms_services.dart';
import '../../service/core/api_exception.dart';
import '../../service/core/api_result_model.dart';
import '../../ui/bpms/card_physical_issue/card_physical_issue_edit_address/card_physical_issue_edit_address_screen.dart';
import '../../ui/bpms/card_physical_issue/card_physical_issue_new_address_applicant/card_physical_issue_new_address_applicant_screen.dart';
import '../../ui/bpms/children_loan_procedure/children_loan_add_guarantee/children_loan_add_guarantee_screen.dart';
import '../../ui/bpms/children_loan_procedure/children_loan_add_warranty/children_loan_add_warranty_screen.dart';
import '../../ui/bpms/children_loan_procedure/children_loan_child/children_loan_child_screen.dart';
import '../../ui/bpms/children_loan_procedure/children_loan_customer_additional_document/children_loan_customer_additional_document_screen.dart';
import '../../ui/bpms/children_loan_procedure/children_loan_customer_address/children_loan_customer_address_screen.dart';
import '../../ui/bpms/children_loan_procedure/children_loan_customer_document/children_loan_customer_document_screen.dart';
import '../../ui/bpms/children_loan_procedure/children_loan_guarantee_address/children_loan_guarantee_address_screen.dart';
import '../../ui/bpms/children_loan_procedure/children_loan_guarantee_confirm/children_loan_guarantee_confirm_screen.dart';
import '../../ui/bpms/children_loan_procedure/children_loan_guarantee_document/children_loan_guarantee_document_screen.dart';
import '../../ui/bpms/close_long_term_deposit/close_long_term_deposit_screen.dart';
import '../../ui/bpms/credit_card_facility/credit_card_add_guarantee/credit_card_add_guarantee_screen.dart';
import '../../ui/bpms/credit_card_facility/credit_card_add_warranty/credit_card_add_warranty_screen.dart';
import '../../ui/bpms/credit_card_facility/credit_card_customer_additional_document/credit_card_customer_additional_document_screen.dart';
import '../../ui/bpms/credit_card_facility/credit_card_customer_address/credit_card_customer_address_screen.dart';
import '../../ui/bpms/credit_card_facility/credit_card_customer_document/credit_card_customer_document_screen.dart';
import '../../ui/bpms/credit_card_facility/credit_card_guarantee_address/credit_card_guarantee_address_screen.dart';
import '../../ui/bpms/credit_card_facility/credit_card_guarantee_confirm/credit_card_guarantee_confirm_screen.dart';
import '../../ui/bpms/credit_card_facility/credit_card_guarantee_document/credit_card_guarantee_document_screen.dart';
import '../../ui/bpms/document_completion/document_completion_get_customer_documents/document_completion_get_customer_documents_screen.dart';
import '../../ui/bpms/guarantee_delete/guarantee_delete_screen.dart';
import '../../ui/bpms/marriage_loan_procedure/marriage_loan_add_guarantee/marriage_loan_add_guarantee_screen.dart';
import '../../ui/bpms/marriage_loan_procedure/marriage_loan_add_warranty/marriage_loan_add_warranty_screen.dart';
import '../../ui/bpms/marriage_loan_procedure/marriage_loan_customer_additional_document/marriage_loan_customer_additional_document_screen.dart';
import '../../ui/bpms/marriage_loan_procedure/marriage_loan_customer_address/marriage_loan_customer_address_screen.dart';
import '../../ui/bpms/marriage_loan_procedure/marriage_loan_customer_document/marriage_loan_customer_document_screen.dart';
import '../../ui/bpms/marriage_loan_procedure/marriage_loan_guarantee_address/marriage_loan_guarantee_address_screen.dart';
import '../../ui/bpms/marriage_loan_procedure/marriage_loan_guarantee_confirm/marriage_loan_guarantee_confirm_screen.dart';
import '../../ui/bpms/marriage_loan_procedure/marriage_loan_guarantee_document/marriage_loan_guarantee_document_screen.dart';
import '../../ui/bpms/marriage_loan_procedure/marriage_loan_marriage_license/marriage_loan_marriage_license_screen.dart';
import '../../ui/bpms/marriage_loan_procedure/marriage_loan_spouse/marriage_loan_spouse_screen.dart';
import '../../ui/bpms/military_guarantee/militarty_guarantee_balance_warning/military_guarantee_charge_deposit_screen.dart';
import '../../ui/bpms/military_guarantee/militarty_guarantee_confirm_receipt/military_guarantee_confirm_receipt_lg_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_collateral_type/military_guarantee_collateral_type_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_complete_employment_documents/military_guarantee_complete_employment_documents_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_draft_file/military_guarantee_draft_file_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_employment_emploee/military_guarantee_employment_employee_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_employment_type/military_guarantee_employment_type_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_letter/military_guarantee_letter_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_lg_info/military_guarantee_lg_info_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_other_employment/military_guarantee_other_employment_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_person_address/military_guarantee_person_address_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_self_employed/military_guarantee_self_employed_screen.dart';
import '../../ui/bpms/military_guarantee/military_guarantee_send_lg_location/military_guarantee_send_lg_location_screen.dart';
import '../../ui/bpms/military_guarantee/millitary_guarantee_customer_additional_document/millitary_guarantee_customer_additional_document_screen.dart';
import '../../ui/bpms/military_guarantee/millitary_guarantee_customer_address/millitary_guarantee_customer_address_screen.dart';
import '../../ui/bpms/military_guarantee/millitary_guarantee_sign_contract/millitary_guarantee_sign_contract_screen.dart';
import '../../ui/bpms/rayan_card_facility/rayan_card_add_warranty/rayan_card_add_warranty_screen.dart';
import '../../ui/bpms/rayan_card_facility/rayan_card_customer_additional_document/rayan_card_customer_additional_document_screen.dart';
import '../../ui/bpms/rayan_card_facility/rayan_card_customer_address/rayan_card_customer_address_screen.dart';
import '../../ui/bpms/rayan_card_facility/rayan_card_customer_document/rayan_card_customer_document_screen.dart';
import '../../ui/bpms/rayan_card_facility/rayan_card_sign_contract/rayan_card_sign_contract_screen.dart';
import '../../ui/bpms/retail_loan/retail_loan_add_warranty/retail_loan_add_warranty_screen.dart';
import '../../ui/bpms/retail_loan/retail_loan_customer_address/retail_loan_customer_address_screen.dart';
import '../../ui/bpms/retail_loan/retail_loan_customer_document/retail_loan_customer_document_screen.dart';
import '../../ui/bpms/retail_loan/retail_loan_sign_contract/retail_loan_sign_contract_screen.dart';
import '../../ui/card_management/card_reissue/card_reissue_edit_address/card_reissue_edit_address_screen.dart';
import '../../ui/card_management/card_reissue/card_reissue_new_address_applicant/card_reissue_new_address_applicant_screen.dart';
import '../../ui/common/document_state/document_state_screen.dart';
import '../../ui/common/document_value_state/document_value_state_screen.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class TaskListController extends GetxController {
  TaskListController({required this.refreshCallback});

  late List<Task> taskList;

  final Function(bool shouldUpdateCustomerStatus) refreshCallback;

  MainController mainController = Get.find();

  bool isLoading = false;

  Task? selectedTaskListItem;

  /// Retrieves the task data for a specific task.
  Future<void> getTaskDataRequestRequest(Task task) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final GetTaskDataRequest getTaskDataRequest = GetTaskDataRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
    );
    selectedTaskListItem = task;

    isLoading = true;
    update();

    BPMSServices.getTaskData(
      getTaskDataRequest: getTaskDataRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final GetTaskDataResponse response, int _)):
          _handleTask(task, response.data!.formFields!);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Handles the task data based on the process key.
  void _handleTask(Task task, List<TaskDataFormField> taskData) {
    final String processKey = task.processDefinitionId!.split(':')[0];
    switch (processKey) {
      case 'CreditCardReception':
        _handleCreditCardFacilityTask(task, taskData);
        break;
      case 'RayanCardRequest':
        _handleRayanCardFacilityTask(task, taskData);
        break;
      case 'MarriageLoan':
        _handleMarriageLoanTask(task, taskData);
        break;
      case 'DepositClosing':
        _handleDepositClosingTask(task, taskData);
        break;
      case 'ChildrenLoan':
        _handleChildrenLoanTask(task, taskData);
        break;
      case 'CardIssuanceRequest':
        _handleCardIssuanceTask(task, taskData);
        break;
      case 'CardReissuanceRequest':
        _handleCardReIssuanceTask(task, taskData);
        break;
      case 'InternetBankingAccountCreationRequest':
        break;
      case 'MobileBankingAccountCreationRequest':
        break;
      case 'DocumentsCompletion':
        _handleDocumentsCompletion(task, taskData);
        break;
      case 'MilitaryLG':
        _handleMilitaryLGTask(task, taskData);
        break;
      case 'RetailLoan':
        _handleRetailLoanTask(task, taskData);
        break;
      default:
        break;
    }
  }

  /// Handles Rayan Card facility tasks based on the task definition key.
  Future<void> _handleRayanCardFacilityTask(Task task, List<TaskDataFormField> taskData) async {
    switch (task.taskDefinitionKey!) {
      case 'GetCustomerDocuments':
        await Get.to(() => RayanCardCustomerDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerLocation':
        await Get.to(() => RayanCardCustomerAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerCollateralInfo':
        await Get.to(() => RayanCardAddWarrantyScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'SignContract':
        await Get.to(() => RayanCardSignContractScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'EditCustomerLocation':
      case 'EditCustomerDocuments':
        await Get.to(() => DocumentStateScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerAdditionalDocuments':
        await Get.to(() => RayanCardCustomerAdditionalDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      default:
        break;
    }
  }

  /// Handles Credit Card facility tasks based on the task definition key.
  Future<void> _handleCreditCardFacilityTask(Task task, List<TaskDataFormField> taskData) async {
    switch (task.taskDefinitionKey!) {
      case 'GetCustomerDocuments':
        await Get.to(() => CreditCardCustomerDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerLocation':
        await Get.to(() => CreditCardCustomerAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetGuarantorInfo':
        await Get.to(() => CreditCardAddGuaranteeScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'DeleteGuarantor':
        await Get.to(() => GuaranteeDeleteScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GuarantorAcceptance':
        await Get.to(() => CreditCardGuaranteePanelScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetGuarantorDocuments':
        await Get.to(() => CreditCardGuaranteeDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetGuarantorLocation':
        await Get.to(() => CreditCardGuaranteeAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerCollateralInfo':
        await Get.to(() => CreditCardAddWarrantyScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'EditGuarantorDocuments':
      case 'EditGuarantorLocation':
      case 'EditCustomerLocation':
      case 'EditCustomerDocuments':
        await Get.to(() => DocumentStateScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerAdditionalDocuments':
        await Get.to(() => CreditCardCustomerAdditionalDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      default:
        break;
    }
  }

  /// Handles Marriage Loan tasks based on the task definition key.
  Future<void> _handleMarriageLoanTask(Task task, List<TaskDataFormField> taskData) async {
    switch (task.taskDefinitionKey!) {
      case 'GetCustomerDocuments':
        await Get.to(() => MarriageLoanProcedureCustomerDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerLocation':
        await Get.to(() => MarriageLoanProcedureCustomerAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetSpouseInfo':
        await Get.to(() => MarriageLoanProcedureSpouseScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetMarriageLicense':
        await Get.to(() => MarriageLoanProcedureMarriageLicenseScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetGuarantorInfo':
        await Get.to(() => MarriageLoanProcedureAddGuaranteeScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'DeleteGuarantor':
        await Get.to(() => GuaranteeDeleteScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GuarantorAcceptance':
        await Get.to(() => MarriageLoanProcedureGuaranteePanelScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetGuarantorDocuments':
        await Get.to(() => MarriageLoanProcedureGuaranteeDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetGuarantorLocation':
        await Get.to(() => MarriageLoanProcedureGuaranteeAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerCollateralInfo':
        await Get.to(() => MarriageLoanProcedureAddWarrantyScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerAdditionalDocuments':
        await Get.to(() => MarriageLoanProcedureCustomerAdditionalDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'EditpouseInfo':
      case 'EditMarriageLicense':
      case 'EditGuarantorDocuments':
      case 'EditGuarantorLocation':
      case 'EditCustomerLocation':
      case 'EditCustomerDocuments':
      case 'EditMarriageCertificate':
      case 'EditSpouseInfo':
        await Get.to(() => DocumentValueStateScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      default:
        break;
    }
  }

  /// Handles Deposit Closing tasks based on the task definition key.
  Future<void> _handleDepositClosingTask(Task task, List<TaskDataFormField> taskData) async {
    switch (task.taskDefinitionKey!) {
      case 'GetClosingType':
        await Get.to(() => CloseLongTermDepositScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
    }
  }

  /// Handles Children Loan tasks based on the task definition key.
  Future<void> _handleChildrenLoanTask(Task task, List<TaskDataFormField> taskData) async {
    switch (task.taskDefinitionKey!) {
      case 'GetCustomerDocuments':
        await Get.to(() => ChildrenLoanProcedureCustomerDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerLocation':
        await Get.to(() => ChildrenLoanProcedureCustomerAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetChildInfo':
        await Get.to(() => ChildrenLoanProcedureChildScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetGuarantorInfo':
        await Get.to(() => ChildrenLoanProcedureAddGuaranteeScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'DeleteGuarantor':
        await Get.to(() => GuaranteeDeleteScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GuarantorAcceptance':
        await Get.to(() => ChildrenLoanProcedureGuaranteePanelScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetGuarantorDocuments':
        await Get.to(() => ChildrenLoanProcedureGuaranteeDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetGuarantorLocation':
        await Get.to(() => ChildrenLoanProcedureGuaranteeAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerCollateralInfo':
        await Get.to(() => ChildrenLoanProcedureAddWarrantyScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerAdditionalDocuments':
        await Get.to(() => ChildrenLoanProcedureCustomerAdditionalDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'EditGuarantorDocuments':
      case 'EditGuarantorLocation':
      case 'EditCustomerLocation':
      case 'EditCustomerDocuments':
      case 'EditChildInfo':
        await Get.to(() => DocumentValueStateScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      default:
        break;
    }
  }

  /// Handles Card Issuance tasks based on the task definition key.
  Future<void> _handleCardIssuanceTask(Task task, List<TaskDataFormField> taskData) async {
    switch (task.taskDefinitionKey!) {
      case 'EditAddress':
        await Get.to(() => CardPhysicalIssueEditAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetNewAddressFromApplicant':
        await Get.to(() => CardPhysicalIssueNewAddressApplicantScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      default:
        break;
    }
  }

  /// Handles Card Re-Issuance tasks based on the task definition key.
  Future<void> _handleCardReIssuanceTask(Task task, List<TaskDataFormField> taskData) async {
    switch (task.taskDefinitionKey!) {
      case 'EditAddress':
        await Get.to(() => CardReissueEditAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetNewAddressFromApplicant':
        await Get.to(() => CardReissueNewAddressApplicantScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      default:
        break;
    }
  }

  /// Handles Documents Completion tasks based on the task definition key.
  Future<void> _handleDocumentsCompletion(Task task, List<TaskDataFormField> taskData) async {
    switch (task.taskDefinitionKey!) {
      case 'GetCustomerDocuments':
        await Get.to(() => DocumentCompletionGetCustomerDocumentsScreen(task: task, taskData: taskData));
        refreshCallback(true);
        break;
      default:
        break;
    }
  }

  /// Handles Military LG tasks based on the task definition key.
  Future<void> _handleMilitaryLGTask(Task task, List<TaskDataFormField> taskData) async {
    switch (task.taskDefinitionKey!) {
      case 'GetLGInfo':
        await Get.to(() => MilitaryGuaranteeLGInfoScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetDraftFile':
        await Get.to(() => MilitaryGuaranteeDraftFileScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetMilitaryLetter':
      case 'EditMilitaryLetter':
        await Get.to(() => MilitaryGuaranteeLetterScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerLocation':
        await Get.to(() => MilitaryGuaranteePersonAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetEmploymentType':
      case 'EditEmploymentType':
        await Get.to(() => MilitaryGuaranteeEmploymentTypeScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'CompleteEmploymentDocuments':
        await Get.to(() => MilitaryGuaranteeCompleteEmploymentDocumentsScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetEmploymentEmployee':
      case 'EditEmploymentEmployee':
        await Get.to(() => MilitaryGuaranteeEmploymentEmployeeScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetEmploymentSelfEmployed':
      case 'EditEmploymentSelfEmployed':
        await Get.to(() => MilitaryGuaranteeSelfEmployedScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetEmploymentOthers':
      case 'EditEmploymentOthers':
        await Get.to(() => MilitaryGuaranteeOtherEmploymentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetSendLGLocation':
      case 'EditSendLGLocation':
      case 'EditAddress':
        await Get.to(() => MilitaryGuaranteeSendLGLocationScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCollateralType':
        await Get.to(() => MilitaryGuaranteeCollateralTypeScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'SignContract':
        await Get.to(() => MillitaryGuaranteeSignContractScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'EditCustomerLocation':
        await Get.to(() => MillitaryGuaranteeCustomerAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerAdditionalDocuments':
        await Get.to(() => MillitaryGuaranteeCustomerAdditionalDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'ChargeDeposit':
        await Get.to(() => MilitaryGuaranteeChargeDepositScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'ConfirmReceiptLG':
        await Get.to(() => MilitaryGuaranteeConfirmReceiptLGScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      default:
        break;
    }
  }

  /// Handles Retail Loan tasks based on the task definition key.
  Future<void> _handleRetailLoanTask(Task task, List<TaskDataFormField> taskData) async {
    switch (task.taskDefinitionKey!) {
      case 'GetCustomerDocuments':
        await Get.to(() => RetailLoanCustomerDocumentScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerLocation':
        await Get.to(() => RetailLoanCustomerAddressScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'GetCustomerCollateralInfo':
        await Get.to(() => RetailLoanAddWarrantyScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'SignContract':
        await Get.to(() => RetailLoanSignContractScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      case 'EditCustomerLocation':
      case 'EditCustomerDocuments':
        await Get.to(() => DocumentStateScreen(task: task, taskData: taskData));
        refreshCallback(false);
        break;
      default:
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
