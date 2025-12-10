import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secure_plugin/secure_response_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/parsa_loan/loan_detail.dart';
import '../../model/bpms/parsa_loan/parsa_lending_config.dart';
import '../../model/bpms/parsa_loan/request/parsa_loan_submit_contract_request_data.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_5_request_data.dart';
import '../../model/bpms/parsa_loan/response/parsa_lending_get_loan_detail_response_data.dart';
import '../../model/bpms/parsa_loan/response/parsa_loan_submit_contract_response_data.dart';
import '../../model/common/sign_document_data.dart';
import '../../service/core/api_core.dart';
import '../../service/parsa_loan_services.dart';
import '../../ui/common/contract/contract_preview_screen.dart';
import '../../ui/parsa_loan/parsa_loan_contract/widget/parsa_loan_confirmation_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/file_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ParsaLoanContractController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = true;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  LoanDetail? loanDetail;
  ParsaLendingConfig? config;

  String? signedDocumentBase64;

  ParsaLoanSubmitContractResponseData? submitParsaLoanContractResponseModel;

  final String trackingNumber;

  ParsaLoanContractController({required this.trackingNumber});

  @override
  void onInit() {
    getLoanDetailRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> getLoanDetailRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    ParsaLoanServices.getLoanDetailRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ParsaLendingGetLoanDetailResponseData response, int _)):
          loanDetail = response.data!.loanDetail!;
          config = response.data!.config!;
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

  Future<void> sharePdf() async {
    await FileUtil().shareContractPDF(
      bytes: base64Decode(loanDetail!.unsignedContract!).toList(),
      name: 'Parsa Loan',
    );
  }

  void showPreviewScreen() {
    Get.to(() => ContractPreviewScreen(
          pdfData: base64Decode(loanDetail!.unsignedContract!),
          templateName: 'Parsa',
        ));
  }

  void showMultiSignedContractPreviewScreen() {
    Get.to(() => ContractPreviewScreen(
          pdfData: base64Decode(submitParsaLoanContractResponseModel!.data!.loanDetail!.multiSignedContract!),
          templateName: 'Parsa',
        ));
  }

  Future<void> shareMultiSignedContractPdf() async {
    await FileUtil().shareContractPDF(
      bytes: base64Decode(submitParsaLoanContractResponseModel!.data!.loanDetail!.multiSignedContract!).toList(),
      name: 'Parsa Loan',
    );
  }

  void showConfirmationBottomSheet() {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? Get.context!.theme.colorScheme.surface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const ParsaLoanConfirmationBottomSheet(),
      ),
    );
  }

  Future<void> signDocument() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final SignDocumentData signDocumentData = SignDocumentData(
      documentBase64: loanDetail!.unsignedContract!,
      reason: 'Parsa Loan Request',
      signLocations: config!.signLocation!,
    );

    final SecureResponseData signResponse = await AppUtil.signPdf(signDocumentData: signDocumentData);

    if (signResponse.isSuccess != null && signResponse.isSuccess!) {
      signedDocumentBase64 = signResponse.data;
      update();
      _submitParsaLoanContractRequest();
    } else {
      isLoading = false;
      update();

      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: signResponse.message ?? locale.error_in_signature,
      );

      await Sentry.captureMessage('sign pdf error',
          params: [
            {'status code': signResponse.statusCode},
            {'message': signResponse.message},
          ],
          level: SentryLevel.warning);
    }
  }

  void _submitParsaLoanContractRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ParsaLoanSubmitContractRequestData parsaLoanSubmitContractRequestData =
        ParsaLoanSubmitContractRequestData(signedContract: signedDocumentBase64!);

    isLoading = true;
    update();

    ParsaLoanServices.submitParsaLoanSignedContractRequest(
      parsaLoanSubmitContractRequestData: parsaLoanSubmitContractRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ParsaLoanSubmitContractResponseData response, int _)):
          submitParsaLoanContractResponseModel = response;
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
    hasError = false;
    isLoading = true;
    update();

    final taskCompleteState5RequestData = TaskCompleteState5RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'signContract',
      taskData: [
        {
          'name': 'signedContract',
          'value': signedDocumentBase64,
        }
      ],
    );

    ParsaLoanServices.parsaLendingState5CompleteTaskRequest(
      taskCompleteState5RequestData: taskCompleteState5RequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
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
