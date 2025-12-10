import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../model/bpms/close_deposit/request/close_deposit_start_process_variables_data.dart';
import '../../../model/bpms/request/get_task_data_request_data.dart';
import '../../../model/bpms/request/start_process_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/bpms/response/start_process_response_data.dart';
import '../../../model/deposit/request/customer_deposits_request_data.dart';
import '../../../model/deposit/request/deposit_balance_request_data.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../model/deposit/response/deposit_balance_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/deposit_services.dart';
import '../../../ui/bpms/close_long_term_deposit/close_long_term_deposit_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/dialog_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CloseDepositController extends GetxController {
  bool isRuleChecked = false;

  Deposit deposit;
  MainController mainController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;
  DepositBalanceResponseData? depositBalanceResponseData;
  List<Deposit> depositList = [];
  Deposit? selectedDeposit;

  String? errorTitle = '';

  bool hasError = false;

  late Task _task;

  CloseDepositController({required this.deposit});

  @override
  void onInit() {
    getDepositBalanceRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void validateConfirmPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isRuleChecked) {
      _getDepositListRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_read_and_accept_deposit_closure_terms,
      );
    }
  }

  void setChecked(bool isChecked) {
    isRuleChecked = isChecked;
    update();
  }

  void validateSelectorPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (getBalance() == 0) {
      _showConfirmDialog();
    } else {
      if (depositList.isNotEmpty && selectedDeposit != null) {
        _showConfirmDialog();
      } else {
        if (depositList.isEmpty) {
          SnackBarUtil.showInfoSnackBar(
            locale.closing_deposit_possible_only_with_existing_deposit,
          );
        } else {
          SnackBarUtil.showInfoSnackBar(
            locale.please_select_a_deposit,
          );
        }
      }
    }
  }

  /// Retrieves the customer's deposit list and handles the response
  void _getDepositListRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CustomerDepositsRequest customerDepositsRequest = CustomerDepositsRequest(
      customerNumber: mainController.authInfoData!.customerNumber ?? '',
      trackingNumber: const Uuid().v4(),
    );

    isLoading = true;
    update();

    DepositServices.getCustomerDeposits(
      customerDepositsRequest: customerDepositsRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerDepositsResponse response, int _)):
          _handleResponse(response);
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setSelectedDeposit(Deposit deposit) {
    selectedDeposit = deposit;
    update();
  }

  void _showConfirmDialog() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showConfirmCloseDeposit(
      buildContext: Get.context!,
      positiveFunction: () {
        _closeDepositRequest();
        Get.back();
      },
      negativeFunction: () {
        Get.back();
      },
      depositNumber: deposit.depositNumber!,
      title: locale.deposit_closure_confirmation_title,
      confirmMessage: locale.close_deposit,
      cancelMessage: locale.cancel,
    );
  }

  void _handleResponse(CustomerDepositsResponse response) {
    for (final depositItem in response.data!.deposits!) {
      if (depositItem.depositNumber != deposit.depositNumber) {
        depositList.add(depositItem);
      }
    }
    update();
  }

  void _closeDepositRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final StartProcessRequest startProcessRequest = StartProcessRequest(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      processDefinitionKey: 'DepositClosing',
      businessKey: '1234567890',
      returnNextTasks: true,
      variables: CloseDepositStartProcessVariables(
        customerNumber: mainController.authInfoData!.customerNumber!,
        sourceDeposit: deposit.depositNumber!,
        destinationDeposit: selectedDeposit?.depositNumber,
      ),
    );

    isLoading = true;
    update();
    BPMSServices.startProcess(
      startProcessRequest: startProcessRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final StartProcessResponse response, int _)):
          if (response.data!.taskList == null || response.data!.taskList!.isEmpty) {
            AppUtil.nextPageController(pageController, isClosed);
          } else {
            AppUtil.gotoPageController(
              pageController: pageController,
              page: 4,
              isClosed: isClosed,
            );
            _handleTask(response.data!.taskList!);
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _handleTask(List<Task> taskList) {
    _task = taskList.first;
    getTaskDataRequest();
  }

  /// Retrieves task data and handles the response
  Future<void> getTaskDataRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final GetTaskDataRequest getTaskDataRequest = GetTaskDataRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: _task.id!,
    );

    BPMSServices.getTaskData(
      getTaskDataRequest: getTaskDataRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final GetTaskDataResponse response, int _)):
          Get.back();
          Get.to(() => CloseLongTermDepositScreen(
                task: _task,
                taskData: response.data!.formFields!,
              ));
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves the deposit balance and handles the response
  void getDepositBalanceRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DepositBalanceRequestData depositBalanceRequestData = DepositBalanceRequestData();
    depositBalanceRequestData.trackingNumber = const Uuid().v4();
    depositBalanceRequestData.depositNumber = deposit.depositNumber;
    depositBalanceRequestData.customerNumber = mainController.authInfoData!.customerNumber!;

    hasError = false;
    isLoading = true;
    update();

    DepositServices.getDepositBalanceRequest(
      depositBalanceRequestData: depositBalanceRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DepositBalanceResponseData response, int _)):
          depositBalanceResponseData = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  int getBalance() {
    int amount = 0;
    if (depositBalanceResponseData != null &&
        depositBalanceResponseData!.data != null &&
        depositBalanceResponseData!.data!.balance != null) {
      amount = depositBalanceResponseData!.data!.balance!;
    }
    return amount;
  }
}
