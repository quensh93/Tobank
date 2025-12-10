import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/parsa_loan/request/parsa_loan_inquiry_cbs_request_data.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_6_request_data.dart';
import '../../model/bpms/parsa_loan/response/parsa_loan_check_samat_cbs_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../model/other/response/other_item_data.dart';
import '../../service/core/api_core.dart';
import '../../service/other_services.dart';
import '../../service/parsa_loan_services.dart';
import '../../ui/common/key_value_widget.dart';
import '../../util/app_util.dart';
import '../../util/dialog_util.dart';
import '../../util/snack_bar_util.dart';
import '../../widget/svg/svg_icon.dart';
import '../main/main_controller.dart';

class ParsaLoanGetCustomerScoreController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = true;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  ScrollController scrollbarController = ScrollController();

  OtherItemData? creditOtherItemData;

  bool isInquiryRuleChecked = false;

  final String trackingNumber;

  int cbsCounter = 30;

  Timer? timer;

  String? cbsRiskScore;

  String? orderId;

  String descriptionString = '';

  ParsaLoanGetCustomerScoreController({required this.trackingNumber});

  @override
  void onInit() {
    getParsaLoanCreditRulesRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> getParsaLoanCreditRulesRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    OtherServices.getParsaLoanCreditRuleRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          creditOtherItemData = response;
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

  void setInquiryChecked(bool ruleChecked) {
    isInquiryRuleChecked = ruleChecked;
    update();
  }

  void validateInquiryRules() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isInquiryRuleChecked) {
      _checkSamatCbs();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.read_and_accept_terms_conditions,
      );
    }
  }

  void _checkSamatCbs() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    ParsaLoanServices.checkParsaLoanSamatCbs().then((result) {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final ParsaLoanCheckSamatCbsResponseData response, int _)):
          _handleCheckSamatCbsResponse(response);
          break;
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void inquiryCbs() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    final ParsaLoanInquiryCbsRequestData parsaLoanInquiryCbsRequestData = ParsaLoanInquiryCbsRequestData();
    parsaLoanInquiryCbsRequestData.orderId = orderId;
    ParsaLoanServices.inquiryParsaLoanCbs(parsaLoanInquiryCbsRequestData: parsaLoanInquiryCbsRequestData)
        .then((result) {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final ParsaLoanCheckSamatCbsResponseData response, int _)):
          _handleInquiryCbsResponse(response);
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

  Future<void> _taskComplete() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    final taskCompleteState6RequestData = TaskCompleteState6RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'CustomerScore',
      taskData: [
        {
          'name': 'scoreResult',
          'value': cbsRiskScore,
        }
      ],
    );

    ParsaLoanServices.parsaLendingState6CompleteTaskRequest(
      taskCompleteState6RequestData: taskCompleteState6RequestData,
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

  String getTimer() {
    final DateTime time = DateTime(2024);
    final timer = intl.DateFormat('mm:ss').format(time.add(Duration(seconds: cbsCounter)));
    return timer;
  }

  void _startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (cbsCounter < 1) {
        inquiryCbs();
        timer.cancel();
      } else {
        cbsCounter = cbsCounter - 1;
      }
      update();
    });
  }

  void _handleCheckSamatCbsResponse(ParsaLoanCheckSamatCbsResponseData response) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (response.data!.cbsStatusCode == null) {
      cbsRiskScore = response.data!.loanDetail!.cbsRiskScore;
      final bool hasCbsScore = cbsRiskScore!.contains('A');
      DialogUtil.showAttentionDialogMessage(
        buildContext: Get.context!,
        description: hasCbsScore
            ? locale.parsa_loan_eligibility
            : locale.not_eligible_for_loan_due_to_credit_score,
        keyValue: KeyValueWidget(keyString: locale.credit_rating, valueString: cbsRiskScore),
        positiveMessage: hasCbsScore ? locale.continue_label : locale.return_to_homepage,
        icon: hasCbsScore ? SvgIcons.transactionSuccess : SvgIcons.warningOrangeCircle,
        positiveFunction: () {
          if (hasCbsScore) {
            Get.back();
            _taskComplete();
          } else {
            Get.back();
            Get.back();
          }
        },
      );
    } else {
      if (response.data!.cbsStatusCode == 102) {
        descriptionString = locale.status_recive_report_message;
      } else {
        descriptionString = locale.request_registered_waiting_queue;
      }
      orderId = response.data!.orderId;
      _startTimer();
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void _handleInquiryCbsResponse(ParsaLoanCheckSamatCbsResponseData response) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (response.data!.cbsStatusCode == null) {
      cbsRiskScore = response.data!.loanDetail!.cbsRiskScore;
      final bool hasCbsScore = cbsRiskScore!.contains('A');
      DialogUtil.showAttentionDialogMessage(
        buildContext: Get.context!,
        description: hasCbsScore
            ? locale.parsa_loan_eligibility
            : locale.not_eligible_for_loan_due_to_credit_score,
        keyValue: KeyValueWidget(keyString: locale.credit_rating, valueString: cbsRiskScore),
        positiveMessage: hasCbsScore ? locale.continue_label : locale.return_to_homepage,
        positiveFunction: () {
          if (hasCbsScore) {
            Get.back();
            _taskComplete();
          } else {
            Get.back();
            Get.back();
          }
        },
      );
    } else {
      DialogUtil.showAttentionDialogMessage(
        buildContext: Get.context!,
        description: locale.retry_credit_score_request_after_48_hours,
        positiveMessage: locale.understood_button,
        positiveFunction: () {
          Get.back();
          Get.back();
        },
      );
    }
  }
}
