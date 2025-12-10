import 'dart:async';
import 'dart:convert';
import 'package:universal_io/io.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/pichak/customer_type_data.dart';
import '../../model/pichak/request/dynamic_info_inquiry_request.dart';
import '../../model/pichak/request/receiver_inquiry_request.dart';
import '../../model/pichak/request/transfer_request.dart';
import '../../model/pichak/response/confirmation_response.dart';
import '../../model/pichak/response/dynamic_info_inquiry_response.dart';
import '../../model/pichak/response/pichak_reason_type_list_response.dart';
import '../../model/pichak/response/receiver_inquiry_response.dart';
import '../../model/pichak/store_shaparak_payment_model.dart';
import '../../service/core/api_core.dart';
import '../../service/pichak_services.dart';
import '../../ui/pichak/shaparak_payment/shaparak_payment_screen.dart';
import '../../ui/pichak/submit/widget/check_payment_confirm_bottom_sheet.dart';
import '../../ui/pichak/transfer/widget/check_receiver_bottom_sheet.dart';
import '../../ui/scanner/qr_scanner_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/data_constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/permission_handler.dart';
import '../../util/shared_preferences_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';
import 'pichak_controller.dart';

class CheckTransferController extends GetxController {
  MainController mainController = Get.find();
  PichakController pichakController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;
  TransferRequest transferRequest = TransferRequest();
  late ReceiverInquiryRequest receiverInquiryRequest;
  CheckTransferStatus? checkTransferStatus;
  late ConfirmationResponse confirmationResponse;

  TextEditingController chequeIdController = TextEditingController();
  TextEditingController chequeDescriptionController = TextEditingController();
  bool isChequeIdValid = true;
  bool isChequeDescriptionValid = true;

  final TextEditingController codeController = TextEditingController();
  CustomerTypeData selectedCustomerTypeData = DataConstants.getCustomerTypeDataList()[0];

  int openBottomSheets = 0;

  late PichakReasonTypeListResponse reasonTypeListResponse;
  ReasonType? selectedReasonType;

  bool isReasonTypeValid = true;

  @override
  void onInit() {
    transferRequest.receiverInquiryResponseList = [];
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> getDynamicInfoData() async {
    transferRequest.dynamicInfoInquiryRequest = DynamicInfoInquiryRequest();
    transferRequest.dynamicInfoInquiryRequest!.chequeId = chequeIdController.text;
    _getDynamicInfo();
  }

  Future<void> _getDynamicInfo() async {
    final StoreShaparakPaymentModel? storeShaparakPaymentModel =
        await SharedPreferencesUtil().getStoreShaparakPayment();
    if (storeShaparakPaymentModel == null ||
        storeShaparakPaymentModel.timestamp! < DateTime.now().millisecondsSinceEpoch ||
        storeShaparakPaymentModel.count! >= 5) {
      _showShaparakConfirmBottomSheet();
    } else {
      _getDynamicInfoRequest();
    }
  }

  /// Sends a dynamic info inquiry request to the Pichak service and handles the response, fetching reason types on success.
  void _getDynamicInfoRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    PichakServices.dynamicInfoInquiry(
      dynamicInfoInquiryRequest: transferRequest.dynamicInfoInquiryRequest!,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DynamicInfoInquiryResponse response, int _)):
          transferRequest.dynamicInfoInquiryResponse = response;
          update();
          _getReasonTypesRequest();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Sends a receiver data inquiry request to the Pichak service and handles the response, updating the transfer request with the receiver data.
  void _getReceiverDataRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    receiverInquiryRequest.chequeId = transferRequest.dynamicInfoInquiryResponse!.chequeId;
    receiverInquiryRequest.chequeInquiryRequestId = transferRequest.dynamicInfoInquiryResponse!.requestId;

    isLoading = true;
    update();
    PichakServices.receiverInquiry(
      receiverInquiryRequest: receiverInquiryRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ReceiverInquiryResponse response, int _)):
          transferRequest.receiverInquiryResponseList?.add(response);
          update();
          _closeBottomSheets();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves reason types from the Pichak service and updates the UI, navigating to the next page on success.
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

  void setSelectedReasonType(ReasonType newValue) {
    selectedReasonType = newValue;
    update();
  }

  /// Sends a check transfer request to the Pichak service and handles the response, navigating to the next page on success.
  Future<void> transferCheckRequest(bool isTransfer) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    transferRequest.accepted = true;
    transferRequest.reason = selectedReasonType?.code;
    isLoading = true;
    update();

    if(isTransfer){
      transferRequest.transferReversal = true;
      transferRequest.receiverInquiryResponseList = null;
    }

    print('');
    PichakServices.transfer(
      transferRequest: transferRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ConfirmationResponse response, int _)):
          storeShaparakPaymentCount();
          confirmationResponse = response;
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
  void validateCheckId() {
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
      getDynamicInfoData();
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
    mainController.analyticsService.logEvent(name: 'CheckTransfer', parameters: {'value': 'Barcode_Scanner_Click'});
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

  /// third page
  ///
  ///
  void validate(bool isReversal) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);

    if(isReversal){
      if(chequeDescriptionController.text.isEmpty){
        isChequeDescriptionValid = false;
        update();
        return;
      }else{
        isChequeDescriptionValid = true;
        update();
      }
    }else{
      if (transferRequest.receiverInquiryResponseList!.isEmpty) {
        SnackBarUtil.showInfoSnackBar(
          locale.at_least_one_cheque_receiver_required,
        );
        return;
      }
    }

    if (transferRequest.dynamicInfoInquiryResponse!.amount! > Constants.minReasonValidationChequeAmount) {
      if (selectedReasonType != null) {
        isReasonTypeValid = true;
      } else {
        isReasonTypeValid = false;
      }
    }
    update();

    if (isReasonTypeValid) {
      if(isReversal){
        transferRequest.dynamicInfoInquiryResponse!.description = chequeDescriptionController.text;
      }
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  Future<void> showAddReceiverBottomSheet() async {
    AppUtil.hideKeyboard(Get.context!);
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
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const CheckReceiverBottomSheetWidget(),
            ));
    openBottomSheets--;
  }

  void deleteReceiverData(ReceiverInquiryResponse receiverData) {
    transferRequest.receiverInquiryResponseList!.remove(receiverData);
    update();
  }

  void showShaparakPaymentScreen() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Get.to(
      () => ShaparakPaymentScreen(
        returnDataFunction: (bool isPay, String? manaId) async {
          if (isPay) {
            await storePaymentTime(manaId: manaId);
            _getDynamicInfo();
          } else {
            SnackBarUtil.showInfoSnackBar(
              locale.pay_not_successfull,
            );
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

  /// Increments the Shaparak payment count stored in shared preferences, if available.
  Future<void> storeShaparakPaymentCount() async {
    final StoreShaparakPaymentModel? storeShaparakPaymentModel =
        await SharedPreferencesUtil().getStoreShaparakPayment();
    if (storeShaparakPaymentModel != null) {
      storeShaparakPaymentModel.count = storeShaparakPaymentModel.count! + 1;
      await SharedPreferencesUtil().setString(
        Constants.storeShaparakPayment,
        jsonEncode(storeShaparakPaymentModel.toJson()),
      );
    }
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 || pageController.page == 3) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  void setSelectedCustomerTypeData(CustomerTypeData? value) {
    selectedCustomerTypeData = value!;
    update();
  }

  void addReceiver() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (codeController.text.trim().isNotEmpty) {
    } else {
      isValid = false;
    }
    if (isValid) {
      receiverInquiryRequest = ReceiverInquiryRequest();
      receiverInquiryRequest.nationalId = codeController.text.trim();
      receiverInquiryRequest.personType = selectedCustomerTypeData.id;
      _getReceiverDataRequest();
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

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }
}
