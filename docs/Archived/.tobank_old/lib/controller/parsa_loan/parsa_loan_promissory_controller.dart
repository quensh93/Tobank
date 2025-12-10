import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/parsa_loan/request/parsa_loan_submit_promissory_request_data.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_10_request_data.dart';
import '../../model/bpms/parsa_loan/response/parsa_loan_get_promissory_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../model/promissory/collateral_promissory/collateral_promissory_request_data.dart';
import '../../service/core/api_core.dart';
import '../../service/parsa_loan_services.dart';
import '../../ui/promissory/collateral_promissory/select_collateral_promissory_bottom_sheet.dart';
import '../../ui/promissory/promissory_preview/promissory_preview_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ParsaLoanPromissoryController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = true;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  ParsaLoanGetPromissoryResponseData? promissoryDetail;

  CollateralPromissoryPublishResultData? collateralPromissoryPublishResultData;

  bool isPromissorySubmited = false;

  final String trackingNumber;

  ParsaLoanPromissoryController({required this.trackingNumber});

  @override
  void onInit() {
    getParsaLoanPromissoryDetailRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> getParsaLoanPromissoryDetailRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    ParsaLoanServices.getParsaLoanPromissoryRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ParsaLoanGetPromissoryResponseData response, int _)):
          promissoryDetail = response;
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

  void showSelectCollateralPromissoryBottomSheet() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isClosed) {
      return;
    }

    final collateralPromissoryRequestData = CollateralPromissoryRequestData(
      amount: promissoryDetail!.data!.amount!,
      dueDate: promissoryDetail!.data!.dueDate,
      description: promissoryDetail!.data!.description!,
      recipientNN: promissoryDetail!.data!.recipientNationalNumber!,
      recipientCellPhone: promissoryDetail!.data!.recipientCellPhone!,
      transferable: promissoryDetail!.data!.transferable!,
    );

    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Get.isDarkMode ? Get.context!.theme.colorScheme.surface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SelectCollateralPromissoryBottomSheet(
          collateralPromissoryRequestData: collateralPromissoryRequestData,
          returnDataFunction: (CollateralPromissoryPublishResultData? resultData) {
            collateralPromissoryPublishResultData = resultData;
            update();
            Future.delayed(Constants.duration300, () {
              SnackBarUtil.showInfoSnackBar(locale.continue_process_register_promissory);
            });
          },
        ),
      ),
    );
  }

  void showPromissoryPreviewScreen() {
    Get.to(() => PromissoryPreviewScreen(
          pdfData: base64Decode(collateralPromissoryPublishResultData!.promissoryPdfBase64!),
          promissoryId: collateralPromissoryPublishResultData!.promissoryId!,
        ));
  }

  void validateCollateralPromissory() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (collateralPromissoryPublishResultData != null) {
      if (isPromissorySubmited) {
        _taskComplete();
      } else {
        _submitPromissoryIdRequest();
      }
    } else {
      SnackBarUtil.showInfoSnackBar(locale.select_electronic_promissory);
    }
  }

  void _submitPromissoryIdRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final parsaLoanSubmitPromissoryRequestData = ParsaLoanSubmitPromissoryRequestData(
      loanId: promissoryDetail!.data!.loanDetail!.id!,
      promissoryId: collateralPromissoryPublishResultData!.promissoryId!,
    );

    isLoading = true;
    update();

    ParsaLoanServices.submitParsaLoanPromissoryRequest(
      parsaLoanSubmitPromissoryRequestData: parsaLoanSubmitPromissoryRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          isPromissorySubmited = true;
          update();
          _taskComplete();
        case Failure(exception: final ApiException apiException):
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

    final taskCompleteState10RequestData = TaskCompleteState10RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'PromissoryAssurance',
      taskData: [
        {
          'name': 'promissoryAssuranceID',
          'value': collateralPromissoryPublishResultData!.promissoryId!,
        }
      ],
    );

    ParsaLoanServices.parsaLendingState10CompleteTaskRequest(
      taskCompleteState10RequestData: taskCompleteState10RequestData,
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
