import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/error_response_data.dart';
import '../../model/common/sign_document_data.dart';
import '../../model/deposit/request/customer_deposits_request_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/promissory/request/promissory_guarantee_finalize_request_data.dart';
import '../../model/promissory/request/promissory_guarantee_request_data.dart';
import '../../model/promissory/request/promissory_inquiry_request_data.dart';
import '../../model/promissory/response/promissory_guarantee_finalize_response_data.dart';
import '../../model/promissory/response/promissory_guarantee_response_data.dart';
import '../../model/promissory/response/promissory_inquiry_response_data.dart';
import '../../model/register/request/customer_info_request_data.dart';
import '../../model/register/response/customer_info_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../service/promissory_services.dart';
import '../../ui/promissory/promissory_guarantee/widget/promissory_guarantee_deposit_bottom_sheet.dart';
import '../../ui/promissory/promissory_preview/promissory_preview_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/file_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class PromissoryGuaranteeController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  TextEditingController nationalCodeController = TextEditingController();

  bool isNationalCodeValid = true;

  TextEditingController promissoryIdController = TextEditingController();

  bool isPromissoryIdValid = true;

  int amount = 0;

  TextEditingController dateController = TextEditingController();

  PromissoryInquiryResponseData? promissoryInquiryResponseData;

  Deposit? selectedDeposit;
  List<Deposit> depositList = [];

  PromissoryGuaranteeResponseData? promissoryGuaranteeResponseData;

  bool hasError = false;

  String? errorTitle = '';

  CustomerInfoResponse? customerInfoResponse;

  TextEditingController paymentAddressController = TextEditingController();

  bool isPaymentAddressValid = true;

  TextEditingController descriptionController = TextEditingController();

  bool isDescriptionValid = true;

  String? base64SignedPdf;

  String? multiSignPath;

  PromissoryGuaranteeFinalizeResponseData? promissoryGuaranteeFinalizeResponseData;

  int openBottomSheets = 0;

  @override
  void onInit() {
    getCustomerInfoRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves customer information
  void getCustomerInfoRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CustomerInfoRequest customerInfoRequest = CustomerInfoRequest(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      forceCacheUpdate: false,
      forceInquireAddressInfo: true,
      getCustomerStartableProcesses: false,
      getCustomerDeposits: false,
      getCustomerActiveCertificate: false,
    );

    hasError = false;
    isLoading = true;
    update();

    AuthorizationServices.getCustomerInfo(customerInfoRequest: customerInfoRequest).then((result) async {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final CustomerInfoResponse response, int _)):
          customerInfoResponse = response;
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

  Future<void> validateGuaranteeInfoPage() async {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (promissoryIdController.text.isNotEmpty) {
      isPromissoryIdValid = true;
    } else {
      isPromissoryIdValid = false;
      isValid = false;
    }
    if (nationalCodeController.text.length == Constants.nationalCodeLength &&
        AppUtil.validateNationalCode(nationalCodeController.text)) {
      isNationalCodeValid = true;
    } else {
      isNationalCodeValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _checkUserSanaRequest();
    }
  }

  /// Checks the user's Sana status and proceeds with guarantee inquiry.+
  void _checkUserSanaRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    PromissoryServices.checkUserSana().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          _guaranteeInquiryRequest();
        case Failure(exception: final ApiException<ErrorResponseData> apiException):
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showPositiveDialogMessage(
              buildContext: Get.context!,
              description: apiException.errorResponse!.message ?? '',
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

  /// Sends a guarantee inquiry request
  void _guaranteeInquiryRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final PromissoryInquiryRequestData promissoryInquiryRequestData = PromissoryInquiryRequestData(
      promissoryId: promissoryIdController.text,
      nationalNumber: nationalCodeController.text,
    );

    PromissoryServices.promissoryInquiryRequest(
      promissoryInquiryRequestData: promissoryInquiryRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryInquiryResponseData response, int _)):
          promissoryInquiryResponseData = response;
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

  void validateConfirmPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (paymentAddressController.text.trim().length >= 5) {
      isPaymentAddressValid = true;
    } else {
      isPaymentAddressValid = false;
      isValid = false;
    }

    if (descriptionController.text.trim().length >= 5) {
      isDescriptionValid = true;
    } else {
      isDescriptionValid = false;
      isValid = false;
    }

    update();
    if (isValid) {
      _getDepositListRequest();
    }
  }

  /// Retrieves the customer's deposit list and displays a bottom sheet.
  void _getDepositListRequest() {//locale
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
          depositList = response.data!.deposits!;
          update();
          _showPromissoryGuaranteeDepositBottomSheet();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Signs a PDF document and proceeds with the guarantee finalization.
  Future<void> _signPdf() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final signDocumentData = SignDocumentData.fromPromissoryMainController(
      documentBase64: promissoryGuaranteeResponseData!.data!.unSignedPdf!,
    );
    final response = await AppUtil.signPdf(signDocumentData: signDocumentData);

    if (response.isSuccess != null && response.isSuccess!) {
      base64SignedPdf = response.data;
      final PromissoryGuaranteeFinalizeRequestData promissoryGuaranteeFinalizeRequestData =
          PromissoryGuaranteeFinalizeRequestData(
        id: promissoryGuaranteeResponseData!.data!.id!,
        signedPdf: base64SignedPdf!,
      );

      _promissoryGuaranteeFinalizeRequest(promissoryGuaranteeFinalizeRequestData);
    } else {
      isLoading = false;
      update();
      SnackBarUtil.showSnackBar(title: locale.error, message: response.message ?? locale.error_in_signature);

      await Sentry.captureMessage('sign pdf error',
          params: [
            {'status code': response.statusCode},
            {'message': response.message},
          ],
          level: SentryLevel.warning);
    }
  }

  /// Finalizes the promissory note guarantee process.
  void _promissoryGuaranteeFinalizeRequest(
      PromissoryGuaranteeFinalizeRequestData promissoryGuaranteeFinalizeRequestData) {
    isLoading = true;
    update();

    PromissoryServices.promissoryGuaranteeFinalize(
      promissoryGuaranteeFinalizeRequestData: promissoryGuaranteeFinalizeRequestData,
    ).then((result) async {//locale
      final locale = AppLocalizations.of(Get.context!)!;
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryGuaranteeFinalizeResponseData response, int _)):
          promissoryGuaranteeFinalizeResponseData = response;
          await setValues();
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

  void validateDepositPage() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedDeposit != null) {
      _promissoryGuaranteeRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_account,
      );
    }
  }

  /// Initiates a promissory note guarantee request.
  Future<void> _promissoryGuaranteeRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryGuaranteeRequestData promissoryGuaranteeRequestData = PromissoryGuaranteeRequestData();

    // Guarantee
    promissoryGuaranteeRequestData.guaranteeType = PromissoryCustomerType.individual;
    promissoryGuaranteeRequestData.guaranteeNn = mainController.authInfoData!.nationalCode;
    promissoryGuaranteeRequestData.guaranteeCellphone = mainController.authInfoData!.mobile!;
    promissoryGuaranteeRequestData.guaranteeFullName =
        '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
    promissoryGuaranteeRequestData.guaranteeAccountNumber = selectedDeposit!.depositIban;
    promissoryGuaranteeRequestData.guaranteeAddress = customerInfoResponse!.data!.address;
    promissoryGuaranteeRequestData.guaranteeSanaCheck =
        true; // Unnecessary value is set. this will be checked on the server side

    // Promissory
    promissoryGuaranteeRequestData.promissoryId = promissoryIdController.text;
    promissoryGuaranteeRequestData.nationalNumber = nationalCodeController.text;
    promissoryGuaranteeRequestData.paymentPlace = paymentAddressController.text.trim();
    promissoryGuaranteeRequestData.description = descriptionController.text.trim();

    isLoading = true;
    update();
    PromissoryServices.guaranteeRequest(
      promissoryGuaranteeRequestData: promissoryGuaranteeRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryGuaranteeResponseData response, int _)):
          promissoryGuaranteeResponseData = response;
          update();
          _closeBottomSheets();
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

  void showConfirmDialog() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.sure_sign_promissory_warranty,
        description: '',
        positiveMessage: locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _signPdf();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  void showPreviewScreen() {
    Get.to(() => PromissoryPreviewScreen(
          pdfData: File(multiSignPath!).readAsBytesSync(),
          promissoryId: promissoryIdController.text,
        ));
  }

  void sharePromissoryPdf() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (Platform.isIOS) {
      Share.shareXFiles([XFile(multiSignPath!)], subject: locale.promissory_file);
    } else {
      Share.shareXFiles([XFile(multiSignPath!)], text: locale.promissory_file);
    }
  }

  Future<void> setValues() async {
    multiSignPath = await FileUtil().writeAsBytesMultiSignedPDF(
      source: promissoryGuaranteeFinalizeResponseData!.data!.multiSignedPdf!,
    );
  }

  /// Handles the back press action based on the current page.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 ||
          pageController.page == 1 ||
          pageController.page == 3 ||
          pageController.page == 4) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  Future<void> _showPromissoryGuaranteeDepositBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const PromissoryGuaranteeDepositBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }
}
