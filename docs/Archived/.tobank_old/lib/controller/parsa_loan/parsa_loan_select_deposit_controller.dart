import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/parsa_loan/request/check_deposit_request_data.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_2_request_data.dart';
import '../../model/bpms/parsa_loan/response/deposit_list_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/parsa_loan_services.dart';
import '../../util/app_util.dart';
import '../../util/dialog_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ParsaLoanSelectDepositController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = true;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  Deposit? selectedDeposit;
  List<Deposit> depositList = [];

  final String trackingNumber;

  ParsaLoanSelectDepositController({required this.trackingNumber});

  @override
  void onInit() {
    getDepositsRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void getDepositsRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    ParsaLoanServices.getDepositList().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DepositListResponseData response, int _)):
          depositList.clear();
          depositList.addAll(response.data!.depositList!);
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

  void setSelectedDeposit(Deposit deposit) {
    selectedDeposit = deposit;
    update();
  }

  void validateSelectDepositPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedDeposit != null) {
      _checkDepositRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_deposit,
      );
    }
  }

  void _checkDepositRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final parsaLendingSubmitDepositRequest = CheckDepositRequestData(
      depositNumber: selectedDeposit!.depositNumber!,
    );

    ParsaLoanServices.checkDepositRequest(
      checkDepositRequestData: parsaLendingSubmitDepositRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          _taskComplete();
        case Failure(exception: final ApiException apiException):
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showAttentionDialogMessage(
              buildContext: Get.context!,
              description: apiException.displayMessage,
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
              },
            );
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  Future<void> _taskComplete() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final taskCompleteState2RequestData = TaskCompleteState2RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'CustomerLoanAccountNumber',
      taskData: [
        TaskData(
          loanAccountNumber: selectedDeposit!.depositNumber!,
        ),
      ],
    );

    ParsaLoanServices.parsaLendingState2CompleteTaskRequest(
      taskCompleteState2RequestData: taskCompleteState2RequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TaskCompleteResponseData response, int _)):
          AppUtil.handleParsaTask(taskList: response.data!.taskList, trackingNumber: trackingNumber);
          break;
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

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }
}
