import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_3_request_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../model/other/response/other_item_data.dart';
import '../../service/core/api_core.dart';
import '../../service/other_services.dart';
import '../../service/parsa_loan_services.dart';
import '../../util/app_util.dart';
import '../../util/dialog_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ParsaLoanInquiryController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = true;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  ScrollController scrollbarController = ScrollController();

  OtherItemData? otherItemData;

  bool isCustomerCommittalChecked = false;

  bool isSanaChecked = false;

  final String trackingNumber;

  ParsaLoanInquiryController({required this.trackingNumber});

  @override
  void onInit() {
    getParsaLoanCommitmentRulesRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> getParsaLoanCommitmentRulesRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    OtherServices.getParsaLoanRuleRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setCustomerCommittalChecked(bool ruleChecked) {
    isCustomerCommittalChecked = ruleChecked;
    update();
  }

  void validateCustomerCommitment() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isCustomerCommittalChecked) {
      if (isSanaChecked) {
        _taskComplete();
      } else {
        _checkSanaRequest();
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_read_and_accept_terms,
      );
    }
  }

  void _checkSanaRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    ParsaLoanServices.checkSanaRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          isSanaChecked = true;
          update();
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
    isLoading = true;
    update();

    final taskCompleteState3RequestData = TaskCompleteState3RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'CustomerLoanInquiry',
      taskData: [
        {
          'name': 'customerLoanBlackListInquiryResult',
          'value': true,
        },
        {
          'name': 'customerLoanCheckInquiryResult',
          'value': true,
        },
        {
          'name': 'customerLoanSanaInquiryResult',
          'value': true,
        },
        {
          'name': 'customerLoanSamatInquiryResult',
          'value': true,
        },
        {
          'name': 'customerSamatInquiryResult',
          'value': true,
        }
      ],
    );

    ParsaLoanServices.parsaLendingState3CompleteTaskRequest(
      taskCompleteState3RequestData: taskCompleteState3RequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TaskCompleteResponseData response, int _)):
          AppUtil.handleParsaTask(taskList: response.data!.taskList, trackingNumber: trackingNumber);
          break;
        case Failure(exception: final ApiException apiException):
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
