import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/pichak/error_response_pichak_data.dart';
import '../../model/pichak/request/confirmation_request.dart';
import '../../model/pichak/request/dynamic_info_inquiry_request.dart';
import '../../model/pichak/response/confirmation_response.dart';
import '../../model/pichak/response/dynamic_info_inquiry_response.dart';
import '../../model/pichak/response/pichak_reason_type_list_response.dart';
import '../../model/pichak/store_shaparak_payment_model.dart';
import '../../service/core/api_core.dart';
import '../../service/pichak_services.dart';
import '../../ui/pichak/receive/widget/check_receive_deny_bottom_sheet.dart';
import '../../ui/pichak/shaparak_payment/shaparak_payment_screen.dart';
import '../../ui/pichak/submit/widget/check_payment_confirm_bottom_sheet.dart';
import '../../ui/scanner/qr_scanner_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/permission_handler.dart';
import '../../util/shared_preferences_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';
import 'pichak_controller.dart';

class CheckReceiveController extends GetxController {
  MainController mainController = Get.find();
  PichakController pichakController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;
  late DynamicInfoInquiryResponse dynamicInfoInquiryResponse;
  late ConfirmationResponse confirmationResponse;
  bool isLoadingReject = false;
  late bool isConfirm;

  TextEditingController chequeIdController = TextEditingController();
  bool isChequeIdValid = true;

  int openBottomSheets = 0;

  bool isShowReceivers = true;

  late PichakReasonTypeListResponse reasonTypeListResponse;
  String reason = '-';

  /// Checks Shaparak payment information and either displays a confirmation bottomSheet or proceeds with a dynamic info inquiry.
  Future<void> getDynamicInfoInquiry() async {
    final StoreShaparakPaymentModel? storeShaparakPaymentModel =
        await SharedPreferencesUtil().getStoreShaparakPayment();
    if (storeShaparakPaymentModel == null ||
        storeShaparakPaymentModel.timestamp! < DateTime.now().millisecondsSinceEpoch ||
        storeShaparakPaymentModel.count! >= 5) {
      _showShaparakConfirmBottomSheet();
    } else {
      _getDynamicInfoInquiryRequest();
    }
  }

  /// Sends a dynamic info inquiry request and handles the response,potentially fetching reason types or navigating to the next page.
  void _getDynamicInfoInquiryRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DynamicInfoInquiryRequest dynamicInfoInquiryRequest = DynamicInfoInquiryRequest();
    dynamicInfoInquiryRequest.chequeId = chequeIdController.text;
    isLoading = true;
    update();
    PichakServices.dynamicInfoInquiry(
      dynamicInfoInquiryRequest: dynamicInfoInquiryRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DynamicInfoInquiryResponse response, int _)):
          dynamicInfoInquiryResponse = response;
          update();
          if (dynamicInfoInquiryResponse.reason != null) {
            _getReasonTypesRequest();
          } else {
            AppUtil.nextPageController(pageController, isClosed);
          }
        case Failure(exception: final ApiException<ErrorResponsePichakData> apiException):
          // TODO: check reference name
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves reason types from the Pichak service and updates the UI with the selected reason.
  Future<void> _getReasonTypesRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    PichakServices.getPichakReasonTypeList().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final PichakReasonTypeListResponse response, int _)):
            reasonTypeListResponse = response;
            reason = reasonTypeListResponse.data!
                    .firstWhereOrNull((element) => element.code == dynamicInfoInquiryResponse.reason)
                    ?.faTitle ??
                '-';
            update();
            AppUtil.nextPageController(pageController, isClosed);
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  void showShaparakPaymentScreen() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Get.to(
      () => ShaparakPaymentScreen(
        returnDataFunction: (bool isPay, String? manaId) async {
          if (isPay) {
            await storePaymentTime(manaId: manaId);
            getDynamicInfoInquiry();
          } else {
            SnackBarUtil.showInfoSnackBar(locale.pay_not_successfull);
          }
        },
      ),
    );
  }

  /// Stores Shaparak payment information in shared preferences with a timestamp and count.
  Future<void> storePaymentTime({String? manaId}) async {
    final storeShaparakPaymentModel = StoreShaparakPaymentModel();
    storeShaparakPaymentModel.manaId = manaId;
    storeShaparakPaymentModel.count = 0;
    storeShaparakPaymentModel.timestamp = DateTime.now().millisecondsSinceEpoch + Constants.halfHourMS;
    await SharedPreferencesUtil().setString(
      Constants.storeShaparakPayment,
      jsonEncode(storeShaparakPaymentModel.toJson()),
    );
  }

  /// Sends a confirmation request to the Pichak service and handles the response, navigating to the next page on success.
  void _confirmationRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ConfirmationRequest confirmationRequest = ConfirmationRequest();
    confirmationRequest.chequeId = dynamicInfoInquiryResponse.chequeId;
    confirmationRequest.chequeInquiryRequestId = dynamicInfoInquiryResponse.requestId;
    confirmationRequest.accepted = true;
    isLoading = true;
    update();
    PichakServices.confirmation(
      confirmationRequest: confirmationRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ConfirmationResponse response, int _)):
          confirmationResponse = response;
          isConfirm = true;
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

  /// Sends a check rejection request to the Pichak service with specified reasons and handles the response.
  void _rejectCheckRequest(List<int?>? rejectReasonList) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ConfirmationRequest confirmationRequest = ConfirmationRequest();
    confirmationRequest.chequeId = dynamicInfoInquiryResponse.chequeId;
    confirmationRequest.chequeInquiryRequestId = dynamicInfoInquiryResponse.requestId;
    confirmationRequest.accepted = false;
    confirmationRequest.rejectionReasons = rejectReasonList!;

    isLoadingReject = true;
    update();

    PichakServices.confirmation(
      confirmationRequest: confirmationRequest,
    ).then((result) {
      isLoadingReject = false;
      update();

      switch (result) {
        case Success(value: (final ConfirmationResponse response, int _)):
          confirmationResponse = response;
          isConfirm = false;
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

  /// Validate values of form before request
  void validateForPayment() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (chequeIdController.text.trim().isNotEmpty &&
        chequeIdController.text.trim().length == Constants.chequeIdLength) {
      isChequeIdValid = true;
    } else {
      isValid = false;
      isChequeIdValid = false;
    }
    update();
    if (isValid) {
      getDynamicInfoInquiry();
    }
  }

  /// Show [QrScannerScreen] for scan barcode and handles the returned barcode data
  void _startQrScannerScreen() {
    Get.to(() => QrScannerScreen(
          returnData: (barCodeString) {
            _setBarcodeValue(barCodeString!);
          },
        ));
  }

  /// Split barcode value with 13 first digits as bill id &
  /// remain digits for pay id
  void _setBarcodeValue(String barcode) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final split = barcode.split('\n');
    bool isFind = false;
    for (final lineString in split) {
      if (lineString.length == Constants.chequeIdLength) {
        chequeIdController.text = lineString;
        isFind = true;
        break;
      }
    }
    if (!isFind) {
      SnackBarUtil.showInfoSnackBar(
        locale.invalid_barcode,
      );
    }
  }

  /// Check for camera permission
  ///
  /// if is not granted, show dialog for confirm request permission with
  /// description
  ///
  /// if is granted, run [_scan] function
  Future<void> permissionMessageDialog() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    mainController.analyticsService.logEvent(name: 'CheckReceive', parameters: {'value': 'Barcode_Scanner_Click'});
    final bool isGranted = await PermissionHandler.camera.isGranted;
    if (!isGranted) {
      DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.camera_access_required,
        description: locale.qr_camera_access_required_description,
        positiveMessage: locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () async {
          Get.back();
          final isGranted = await PermissionHandler.camera.handlePermission();
          if (isGranted) {
            _startQrScannerScreen();
          } else if (Platform.isIOS && !isGranted) {
            AppSettings.openAppSettings();
          }
        },
        negativeFunction: () {
          Get.back();
        },
      );
    } else {
      _startQrScannerScreen();
    }
  }

  void validate() {
    showConfirmationDialog();
  }

  void showConfirmationDialog() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
      buildContext: Get.context!,
      message: locale.confirm_cheque_receive,
      description: locale.cheque_receipt_description,
      positiveMessage: locale.final_confirmation,
      negativeMessage: locale.cancel,
      positiveFunction: () {
        Get.back();
        _confirmationRequest();
      },
      negativeFunction: () {
        Get.back();
      },
    );
  }

  Future<void> showCheckReceiveDenyBottomSheet() async {
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
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => CheckReceiveDenyBottomSheet(
        returnRejectCheckFunction: (rejectionReasonList) {
          _rejectCheckRequest(rejectionReasonList);
        },
      ),
    );
    openBottomSheets--;
  }

  Future<void> _showShaparakConfirmBottomSheet() async {
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
        child: CheckPaymentConfirmBottomSheet(
          confirmFunction: () {
            Get.back();
            showShaparakPaymentScreen();
          },
          denyFunction: () {
            Get.back();
          },
        ),
      ),
    );
    openBottomSheets--;
  }

  void toggleReceiverShow() {
    isShowReceivers = !isShowReceivers;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
