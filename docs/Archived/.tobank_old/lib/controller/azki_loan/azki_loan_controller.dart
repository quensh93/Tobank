import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:secure_plugin/secure_response_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../model/azki_loan/request/submit_azki_loan_collateral_promissory_request_data.dart';
import '../../model/azki_loan/request/submit_azki_loan_contract_request_data.dart';
import '../../model/azki_loan/response/get_azki_loan_collateral_promissory_data_response_data.dart';
import '../../model/azki_loan/response/get_azki_loan_contract_response_data.dart';
import '../../model/azki_loan/response/get_azki_loan_current_step_response_data.dart';
import '../../model/azki_loan/response/submit_azki_loan_contract_response_data.dart';
import '../../model/common/sign_document_data.dart';
import '../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../model/promissory/collateral_promissory/collateral_promissory_request_data.dart';
import '../../service/azki_loan_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/azki_loan/widget/azki_loan_confirmation_bottom_sheet.dart';
import '../../ui/common/contract/contract_preview_screen.dart';
import '../../ui/promissory/collateral_promissory/select_collateral_promissory_bottom_sheet.dart';
import '../../ui/promissory/promissory_preview/promissory_preview_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/file_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';
import '../tobank_services/tobank_services_controller.dart';
//locale
final locale = AppLocalizations.of(Get.context!)!;
class AzkiLoanController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;

  GetAzkiLoanCurrentStepResponse? getAzkiLoanCurrentStepResponse;
  GetAzkiLoanDetailResponse? getAzkiLoanDetailResponse;
  CollateralPromissoryPublishResultData? collateralPromissoryPublishResultData;

  GetAzkiLoanContractResponse? getAzkiLoanContractResponse;
  String? signedDocumentBase64;

  SubmitAzkiLoanContractResponseModel? submitAzkiLoanContractResponseModel;

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }

  void validateInfoPage() {
    _getCurrentStepRequest();
  }

  /// Retrieves the current step in the Azki loan process and handles the response,
  /// either proceeding to the next step or displaying an error.
  void _getCurrentStepRequest() {
    isLoading = true;
    update();

    AzkiLoanServices.getCurrentStep().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final GetAzkiLoanCurrentStepResponse response, int _)):
          getAzkiLoanCurrentStepResponse = response;
          update();
          _getAzkiLoanCollateralPromissoryDataRequest();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves Azki loan collateral promissory data and handles the response,
  /// either proceeding to the contract step or the next page.
  void _getAzkiLoanCollateralPromissoryDataRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    AzkiLoanServices.getAzkiLoanDetail().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final GetAzkiLoanDetailResponse response, int _)):
          getAzkiLoanDetailResponse = response;
          update();
          if (getAzkiLoanCurrentStepResponse!.data == 'contract') {
            _getAzkiLoanContractRequest();
          } else {
            AppUtil.nextPageController(pageController, isClosed);
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void showSelectCollateralPromissoryBottomSheet() {
    if (isClosed) {
      return;
    }

    final collateralPromissoryRequestData = CollateralPromissoryRequestData(
      amount: getAzkiLoanDetailResponse!.data!.amount!,
      dueDate: getAzkiLoanDetailResponse!.data!.dueDate,
      description: getAzkiLoanDetailResponse!.data!.description!,
      recipientNN: getAzkiLoanDetailResponse!.data!.recipientNationalNumber!,
      recipientCellPhone: getAzkiLoanDetailResponse!.data!.recipientCellPhone!,
      transferable: getAzkiLoanDetailResponse!.data!.transferable!,
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
//locale
            final locale = AppLocalizations.of(Get.context!)!;
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
      _submitPromissoryIdRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(locale.select_electronic_promissory);
    }
  }

  void _submitPromissoryIdRequest() {
    final submitAzkiLoanCollateralPromissoryRequest = SubmitAzkiLoanCollateralPromissoryRequest(
      azkiLoanId: getAzkiLoanDetailResponse!.data!.azkiLoan!.id!,
      promissoryId: collateralPromissoryPublishResultData!.promissoryId!,
    );

    isLoading = true;
    update();

    AzkiLoanServices.submitCollateralPromissoryData(
      submitAzkiLoanCollateralPromissoryRequest: submitAzkiLoanCollateralPromissoryRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          _getAzkiLoanContractRequest();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves the Azki loan contract and handles the response,
  /// either navigating to the contract page or displaying an error.
  void _getAzkiLoanContractRequest() {
    isLoading = true;
    update();

    AzkiLoanServices.getAzkiLoanContractRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final GetAzkiLoanContractResponse response, int _)):
          getAzkiLoanContractResponse = response;
          update();
          AppUtil.gotoPageController(pageController: pageController, page: 3, isClosed: isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> sharePdf() async {
    await FileUtil().shareContractPDF(
      bytes: base64Decode(getAzkiLoanContractResponse!.data!.contractAnswer!).toList(),
      name: 'Azki Loan',
    );
  }

  void showPreviewScreen() {
    Get.to(() => ContractPreviewScreen(
          pdfData: base64Decode(getAzkiLoanContractResponse!.data!.contractAnswer!),
          templateName: 'Azki',
        ));
  }

  void showMultiSignedContractPreviewScreen() {
    Get.to(() => ContractPreviewScreen(
          pdfData: base64Decode(submitAzkiLoanContractResponseModel!.data!.loan!.contract!),
          templateName: 'Azki',
        ));
  }

  Future<void> shareMultiSignedContractPdf() async {
    await FileUtil().shareContractPDF(
      bytes: base64Decode(submitAzkiLoanContractResponseModel!.data!.loan!.contract!).toList(),
      name: 'Azki Loan',
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
        child: const AzkiLoanConfirmationBottomSheet(),
      ),
    );
  }

  /// Signs the document using a digital signature and initiates an upload request.
  Future<void> signDocument() async {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final SignDocumentData signDocumentData = SignDocumentData(
      documentBase64: getAzkiLoanContractResponse!.data!.contractAnswer!,
      reason: 'Azki Loan Request',
      signLocations: getAzkiLoanContractResponse!.data!.signLocation!,
    );

    final SecureResponseData signResponse = await AppUtil.signPdf(signDocumentData: signDocumentData);

    if (signResponse.isSuccess != null && signResponse.isSuccess!) {
      signedDocumentBase64 = signResponse.data;
      update();
      _submitAzkiLoanContractRequest();
    } else {
      isLoading = false;
      update();

      SnackBarUtil.showSnackBar(
        title: locale.warning,
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

  /// Submits the signed Azki loan contract and handles the response,
  /// either updating the UI and navigating to the next page or displaying an error.
  void _submitAzkiLoanContractRequest() {
    final SubmitAzkiLoanContractRequestModel submitAzkiLoanContractRequestModel =
        SubmitAzkiLoanContractRequestModel(signedContract: signedDocumentBase64!);

//locale
    final locale = AppLocalizations.of(Get.context!)!;

    isLoading = true;
    update();

    AzkiLoanServices.submitSignedAzkiLoanContractRequest(
      documentId: getAzkiLoanContractResponse!.data!.id!,
      submitAzkiLoanContractRequestModel: submitAzkiLoanContractRequestModel,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final SubmitAzkiLoanContractResponseModel response, int _)):
          mainController.azkiMenu = false;
          mainController.update();
          final tobankServices = Get.find<TobankServicesController>();
          tobankServices.getMenuItemList();
          submitAzkiLoanContractResponseModel = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }
}
