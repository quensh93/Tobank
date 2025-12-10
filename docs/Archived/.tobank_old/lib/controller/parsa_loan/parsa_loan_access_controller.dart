import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_1_request_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/parsa_loan_services.dart';
import '../../util/app_util.dart';
import '../../util/dialog_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ParsaLoanAccessController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = true;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  final String trackingNumber;

  ParsaLoanAccessController({required this.trackingNumber});

  @override
  void onInit() {
    checkLoanAccessRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> checkLoanAccessRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    ParsaLoanServices.checkAccessRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          _taskComplete();
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showAttentionDialogMessage(
              buildContext: Get.context!,
              description: apiException.displayMessage,
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
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

  Future<void> _taskComplete() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final taskCompleteState1RequestData = TaskCompleteState1RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'CustomerActiveAccountInquiry',
      taskData: [
        TaskData(
          hasActiveAccountResult: true,
        ),
      ],
    );

    ParsaLoanServices.parsaLendingState1CompleteTaskRequest(
      taskCompleteState1RequestData: taskCompleteState1RequestData,
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
