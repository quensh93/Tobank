import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/pichak/request/tracking_inquiry_request.dart';
import '../../model/pichak/response/pichak_reason_type_list_response.dart';
import '../../model/pichak/response/tracking_inquiry_response.dart';
import '../../model/pichak/store_shaparak_payment_model.dart';
import '../../service/core/api_core.dart';
import '../../service/pichak_services.dart';
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

class TrackingCreditController extends GetxController {
  MainController mainController = Get.find();
  PichakController pichakController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;
  late TrackingInquiryResponse trackingInquiryResponse;
  TextEditingController chequeIdController = TextEditingController();
  bool isIdValid = true;

  int openBottomSheets = 0;

  late PichakReasonTypeListResponse reasonTypeListResponse;
  String reason = '-';

  /// Tracks credit inquiry and displays a confirmation bottom sheet if necessary.
  Future<void> trackingCreditInquiry() async {
    final StoreShaparakPaymentModel? storeShaparakPaymentModel =
        await SharedPreferencesUtil().getStoreShaparakPayment();
    if (storeShaparakPaymentModel == null ||
        storeShaparakPaymentModel.timestamp! < DateTime.now().millisecondsSinceEpoch ||
        storeShaparakPaymentModel.count! >= 5) {
      _showShaparakConfirmBottomSheet();
    } else {
      _trackingCreditInquiryRequest();
    }
  }

  /// Sends a tracking credit inquiry request and handles the response,
  /// either retrieving reason types or navigating to the next page.
  void _trackingCreditInquiryRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final TrackingInquiryRequest trackingInquiryRequest = TrackingInquiryRequest();
    trackingInquiryRequest.chequeId = chequeIdController.text;
    isLoading = true;
    update();
    PichakServices.trackingInquiry(
      trackingInquiryRequest: trackingInquiryRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TrackingInquiryResponse response, int _)):
          storeShaparakPaymentCount();
          trackingInquiryResponse = response;
          update();
          if (trackingInquiryResponse.reason != null) {
            _getReasonTypesRequest();
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

  /// Retrieves reason types and updates the UI, then navigates to the next page.
  Future<void> _getReasonTypesRequest() async {//locale
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
                    .firstWhereOrNull((element) => element.code == trackingInquiryResponse.reason)
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

  void showShaparakPaymentScreen() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Get.to(
      () => ShaparakPaymentScreen(
        returnDataFunction: (bool isPay, String? manaId) async {
          if (isPay) {
            await storePaymentTime(manaId: manaId);
            trackingCreditInquiry();
          } else {
            SnackBarUtil.showInfoSnackBar(locale.pay_not_successfull);
          }
        },
      ),
    );
  }

  /// Stores the payment time and Mana ID in shared preferences.
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

  /// Increments the Shaparak payment count stored in shared preferences.
  Future<void> storeShaparakPaymentCount() async {
    final StoreShaparakPaymentModel? storeShaparakPaymentModel =
        await SharedPreferencesUtil().getStoreShaparakPayment();

    storeShaparakPaymentModel!.count = storeShaparakPaymentModel.count! + 1;
    await SharedPreferencesUtil().setString(
      Constants.storeShaparakPayment,
      jsonEncode(storeShaparakPaymentModel.toJson()),
    );
  }

  /// Validate values of form before request
  void validateForPayment() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (chequeIdController.text.isNotEmpty && chequeIdController.text.trim().length == Constants.chequeIdLength) {
      isIdValid = true;
    } else {
      isValid = false;
      isIdValid = false;
    }
    update();
    if (isValid) {
      trackingCreditInquiry();
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
  void _setBarcodeValue(String barcode) {//locale
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
  Future<void> permissionMessageDialog() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    mainController.analyticsService.logEvent(name: 'TrackingCredit', parameters: {'value': 'Barcode_Scanner_Click'});
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
          });
    } else {
      _startQrScannerScreen();
    }
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

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
