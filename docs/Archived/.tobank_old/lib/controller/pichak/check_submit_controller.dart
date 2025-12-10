import 'dart:async';
import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/pichak/check_material_data.dart';
import '../../model/pichak/check_type_data.dart';
import '../../model/pichak/customer_type_data.dart';
import '../../model/pichak/request/receiver_inquiry_request.dart';
import '../../model/pichak/request/registration_request.dart';
import '../../model/pichak/request/static_info_inquiry_request.dart';
import '../../model/pichak/response/pichak_reason_type_list_response.dart';
import '../../model/pichak/response/receiver_inquiry_response.dart';
import '../../model/pichak/response/registration_response.dart';
import '../../model/pichak/response/static_info_inquiry_response.dart';
import '../../model/pichak/store_shaparak_payment_model.dart';
import '../../service/core/api_core.dart';
import '../../service/pichak_services.dart';
import '../../ui/common/date_selector_bottom_sheet.dart';
import '../../ui/pichak/shaparak_payment/shaparak_payment_screen.dart';
import '../../ui/pichak/submit/widget/check_payment_confirm_bottom_sheet.dart';
import '../../ui/pichak/submit/widget/check_receiver_bottom_sheet.dart';
import '../../ui/scanner/qr_scanner_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/data_constants.dart';
import '../../util/date_converter_util.dart';
import '../../util/dialog_util.dart';
import '../../util/digit_to_word.dart';
import '../../util/permission_handler.dart';
import '../../util/shared_preferences_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';
import 'pichak_controller.dart';

class CheckSubmitController extends GetxController {
  MainController mainController = Get.find();
  PichakController pichakController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;
  late RegistrationResponse registrationResponse;
  RegistrationRequest registrationRequest = RegistrationRequest();
  late ReceiverInquiryRequest receiverInquiryRequest;

  String initDateString = '';
  String startDateString = '';
  String endDateString = '';

  String dateJalaliString = '';

  TextEditingController chequeIdController = TextEditingController();
  bool isChequeIdValid = true;

  CheckTypeData? selectedCheckTypeData = DataConstants.getCheckTypeDataList()[0];
  CheckMaterialData selectedCheckMaterialData = DataConstants.getCheckMaterialDataList()[0];

  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int _amount = 0;

  bool isDateValid = true;
  bool isAmountValid = true;
  bool isDescriptionValid = true;

  int openBottomSheets = 0;

  final TextEditingController codeController = TextEditingController();
  CustomerTypeData selectedCustomerTypeData = DataConstants.getCustomerTypeDataList()[0];

  late PichakReasonTypeListResponse reasonTypeListResponse;
  ReasonType? selectedReasonType;

  bool isReasonTypeValid = true;

  @override
  void onInit() {
    super.onInit();
    final DateTime dateTime = DateTime.now();
    initDateString = DateConverterUtil.getDateJalali(gregorianDate: intl.DateFormat('yyyy-MM-dd').format(dateTime));
    startDateString = DateConverterUtil.getStartOfYearJalali(
        gregorianDate: intl.DateFormat('yyyy-MM-dd').format(dateTime.add(const Duration(days: -5 * 365))));
    endDateString = DateConverterUtil.getEndOfYearJalali(
        gregorianDate: intl.DateFormat('yyyy-MM-dd').format(dateTime.add(const Duration(days: 10 * 365))));
    registrationRequest.receiverInquiryResponseList = [];
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void _getStaticInfoRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    PichakServices.staticInfoInquiry(
      staticInfoInquiryRequest: registrationRequest.staticInfoInquiryRequest!,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final StaticInfoInquiryResponse response, int _)):
          storeShaparakPaymentCount();
          print('mjp is here 2 - staticInfoInquiryRequest');

          print(response.toJson());
          registrationRequest.staticInfoInquiryResponse = response;
          print('mjp is here 3');
          print(registrationRequest.staticInfoInquiryResponse?.toJson());
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

  void _getReceiverDataRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    receiverInquiryRequest.chequeId = registrationRequest.staticInfoInquiryRequest!.chequeId;
    print('mjp is here 4');
    print(registrationRequest.staticInfoInquiryResponse!.requestId);
    receiverInquiryRequest.chequeInquiryRequestId = registrationRequest.staticInfoInquiryResponse!.requestId;

    isLoading = true;
    update();
    PichakServices.receiverInquiry(
      receiverInquiryRequest: receiverInquiryRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ReceiverInquiryResponse response, int _)):
          _closeBottomSheets();
          registrationRequest.receiverInquiryResponseList!.add(response);
          update();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> getReasonTypes() async {
    _getReasonTypesRequest();
  }

  /// Retrieves reason types from the Pichak service.
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

  void showShaparakPaymentScreen() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Get.to(
      () => ShaparakPaymentScreen(
        returnDataFunction: (bool isPay, String? manaId) async {
          if (isPay) {
            await storePaymentTime(manaId: manaId);
            _getStaticInfoData();
          } else {
            SnackBarUtil.showInfoSnackBar(locale.pay_not_successfull);
          }
        },
      ),
    );
  }

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

  /// Sends a cheque registration request to the Pichak service and handles the response, navigating to the next page on success.
  Future<void> registerChequeRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final result = await PichakServices.registration(
      registrationRequest: registrationRequest,
    );

    isLoading = false;
    update();

    switch (result) {
      case Success(value: (final RegistrationResponse response, int _)):
        print("⭕⭕ We have problem here");
        registrationResponse = response;
        update();
        AppUtil.printResponse(jsonEncode(registrationResponse.toJson()));
        AppUtil.nextPageController(pageController, isClosed);
      case Failure(exception: final ApiException apiException):
        SnackBarUtil.showSnackBar(
          title: locale.show_error(apiException.displayCode),
          message: apiException.displayMessage,
        );
    }
  }

  void setStaticInquiryRequest(StaticInfoInquiryRequest staticInfoInquiryRequest) {
    print("⭕");
    registrationRequest.staticInfoInquiryRequest = staticInfoInquiryRequest;
    update();
  }

  void setRegistrationRequest(RegistrationRequest registrationRequest) {
    this.registrationRequest = registrationRequest;
    update();
  }

  /// Validate values of form before request
  void validate() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (chequeIdController.text.trim().isNotEmpty &&
        chequeIdController.text.trim().length == Constants.chequeIdLength) {
      isChequeIdValid = true;
    } else {
      isValid = false;
      isChequeIdValid = false;
    }
    if (selectedCheckTypeData != null) {
    } else {
      isValid = false;
    }
    update();
    if (isValid) {
      _getStaticInfoData();
    }
  }

  /// Retrieves static info data, either displaying a confirmation bottomSheet or proceeding with a static info request.
  ///
  /// If the stored payment information is null, outdated, or the request count has exceeded the limit, it displays the confirmation bottomSheet using `_showShaparakConfirmBottomSheet()`.
  /// Otherwise, it creates a static info inquiry request, sets its properties, updates the registration request with the static info request, and proceeds with the static info request using [_getStaticInfoRequest()].
  Future<void> _getStaticInfoData() async {
    final StoreShaparakPaymentModel? storeShaparakPaymentModel =
        await SharedPreferencesUtil().getStoreShaparakPayment();
    if (storeShaparakPaymentModel == null ||
        storeShaparakPaymentModel.timestamp! < DateTime.now().millisecondsSinceEpoch ||
        storeShaparakPaymentModel.count! >= 5) {
      _showShaparakConfirmBottomSheet();
    } else {
      final StaticInfoInquiryRequest staticInfoInquiryRequest = StaticInfoInquiryRequest();
      staticInfoInquiryRequest.chequeId = chequeIdController.text;
      staticInfoInquiryRequest.selectedCheckTypeData = selectedCheckTypeData;
      staticInfoInquiryRequest.selectedCheckMaterialData = selectedCheckMaterialData;
      setStaticInquiryRequest(staticInfoInquiryRequest);
      _getStaticInfoRequest();
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
    mainController.analyticsService.logEvent(name: 'CheckSubmit', parameters: {'value': 'Barcode_Scanner_Click'});
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

  void setCheckType(CheckTypeData newValue) {
    selectedCheckTypeData = newValue;
    update();
  }

  /// Hide keyboard & show date picker dialog modal
  Future<void> showSelectDateDialog(BuildContext context) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
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
        builder: (context) {
          return DateSelectorBottomSheet(
            initDateString: initDateString,
            startDateString: startDateString,
            endDateString: endDateString,
            title: locale.select_cheque_date,
            onDateSelected: (selectedDate) {
              dateJalaliString = selectedDate;
            },
            callback: () {
              dateController.text = dateJalaliString.replaceAll('/', '-');
              initDateString = dateJalaliString;
              update();
              Get.back();
            },
          );
        });
    openBottomSheets--;
  }

  /// Formatting value of amount with each three number one separation
  ///  1000 => 1,000
  void validateAmountValue(String value) {
    value.replaceAll(',', '');
    if (value.length > 3) {
      amountController.text = AppUtil.formatMoney(value);
      amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
    }
    if (value != '') {
      _amount = int.parse(value.replaceAll(',', ''));
    } else {
      _amount = 0;
    }
    update();
  }

  void validateFourthPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (dateController.text.trim().isNotEmpty) {
      isDateValid = true;
    } else {
      isValid = false;
      isDateValid = false;
    }
    if (_amount > 0) {
      isAmountValid = true;
    } else {
      isValid = false;
      isAmountValid = false;
    }
    if (descriptionController.text.trim().isNotEmpty) {
      isDescriptionValid = true;
    } else {
      isValid = false;
      isDescriptionValid = false;
    }
    if (_amount > Constants.minReasonValidationChequeAmount) {
      if (selectedReasonType != null) {
        isReasonTypeValid = true;
      } else {
        isValid = false;
        isReasonTypeValid = false;
      }
    }
    update();
    if (registrationRequest.receiverInquiryResponseList!.isNotEmpty) {
    } else {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(
        locale.at_least_one_cheque_receiver_required,
      );
    }

    if (isValid) {
      registrationRequest.amount = _amount;
      registrationRequest.description = descriptionController.text;
      registrationRequest.dueDate = dateController.text;
      registrationRequest.chequeName = '';
      registrationRequest.reason = selectedReasonType?.code;
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  Future<void> showAddReceiverBottomSheet() async {
    if (isClosed) {
      return;
    }
    codeController.clear();
    selectedCustomerTypeData = DataConstants.getCustomerTypeDataList()[0];
    update();
    AppUtil.hideKeyboard(Get.context!);
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
      ),
    );
    openBottomSheets--;
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

  void deleteReceiverData(ReceiverInquiryResponse receiverData) {
    registrationRequest.receiverInquiryResponseList!.remove(receiverData);
    update();
  }

  String getAmountDetail() {
    if (amountController.text.isEmpty || amountController.text.length == 1) {
      return '';
    } else {
      final int amountInToman = _amount ~/ 10;
      return DigitToWord.toWord(amountInToman.toString(), StrType.numWord, isMoney: true).replaceAll('  ', ' ');
    }
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 || pageController.page == 4) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
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

  /// Validates receiver information and initiates a receiver data request if valid.
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

  void setSelectedCustomerTypeData(CustomerTypeData? value) {
    selectedCustomerTypeData = value!;
    update();
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  void clearAmountTextField() {
    amountController.clear();
    _amount = 0;
    update();
  }
}
