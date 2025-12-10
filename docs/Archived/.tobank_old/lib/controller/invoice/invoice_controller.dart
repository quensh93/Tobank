import 'dart:async';
import 'package:universal_io/io.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_validator/string_validator.dart' as string_validator;

import '../../model/contact_match/custom_contact.dart';
import '../../model/customer_club/response/customer_club_discount_effect_response.dart';
import '../../model/invoice/bill_type_data.dart';
import '../../model/invoice/invoice_data.dart';
import '../../model/invoice/request/bill_data_request.dart';
import '../../model/invoice/request/get_bill_detail_by_pay_id_bill_id_request.dart';
import '../../model/invoice/response/bill_data_response.dart';
import '../../model/invoice/response/bill_detail_data.dart';
import '../../model/invoice/response/bill_inquiry_response.dart';
import '../../model/invoice/response/list_bill_data.dart';
import '../../model/invoice/response/pay_bill_data.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../service/core/api_core.dart';
import '../../service/customer_club_services.dart';
import '../../service/invoice_services.dart';
import '../../service/transaction_services.dart';
import '../../ui/contact/contact_screen.dart';
import '../../ui/invoice/widget/bill_id_inquiry_bottom_sheet.dart';
import '../../ui/invoice/widget/customer_id_inquiry_bottom_sheet.dart';
import '../../ui/invoice/widget/edit_bill_bottom_sheet.dart';
import '../../ui/invoice/widget/invoice_barcode_bottom_sheet.dart';
import '../../ui/invoice/widget/invoice_select_payment_bottom_sheet.dart';
import '../../ui/invoice/widget/phone_inquiry_bottom_sheet.dart';
import '../../ui/invoice/widget/phone_midterm_bottom_sheet.dart';
import '../../ui/invoice/widget/select_bill_type_bottom_sheet.dart';
import '../../ui/scanner/qr_scanner_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/data_constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/permission_handler.dart';
import '../../util/snack_bar_util.dart';
import '../../util/web_only_utils/token_util.dart';
import '../main/main_controller.dart';
import "package:universal_html/html.dart" as html;

//locale
final locale = AppLocalizations.of(Get.context!)!;
class InvoiceController extends GetxController {
  MainController mainController = Get.find();
  List<BillData>? billDataList = [];
  List<BillData>? filteredBillDataList = [];
  bool isLoading = false;
  bool isDeleteLoading = false;
  bool isListLoading = false;
  BillData? selectedBillData;

  TextEditingController titleController = TextEditingController();

  BillTypeData selectedBillTypeData = DataConstants.getBllTypeDataList()[0];

  PageController pageController = PageController();

  String errorTitle = '';

  bool hasError = false;

  PaymentType currentPaymentType = PaymentType.wallet;

  int walletAmount = 0;

  CustomerClubDiscountEffectResponse? customerClubDiscountEffectResponse;

  bool useDiscount = false;
  InvoiceData? invoiceDataForPayment;

  PayBillData? payBillData;
  TransactionData? transactionData;

  TextEditingController payIdController = TextEditingController();
  TextEditingController billIdHasBarcodeController = TextEditingController();
  bool isPayIdValid = true;
  bool isBillIdHasBarcodeValid = true;

  TextEditingController phoneNumberController = TextEditingController();
  bool isPhoneNumberValid = true;
  String? billTitle;
  TextEditingController billIdController = TextEditingController();
  bool isBillIdValid = true;
  MobileTermType? selectedMobileTermType = MobileTermType.finalTerm;
  bool isStoreBill = false;
  bool isTitleValid = true;

  String confirmButtonTitle = locale.confirm_button_title;

  TextEditingController customerIdController = TextEditingController();
  bool isCustomerIdValid = true;

  int openBottomSheets = 0;

  bool showAddButton = true;

  /// Check for status of internet connection
  /// if internet is connect run the [_requestTransactionDetailById] function
  /// if not showing message with [FlushBarUtil.showFlushBarNoInternet] function
  Future<void> validateInternetPayment() async {
    _transactionDetailByIdRequest();
  }

  /// Get data of [TransactionDataResponse] from server request
  void _transactionDetailByIdRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: payBillData!.data!.transactionId!,
    ).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            transactionData = response.data;
            if (useDiscount) {
              mainController.updateWallet();
            }
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

  int? getCorrectAmount() {
    if (useDiscount) {
      if (customerClubDiscountEffectResponse != null) {
        return customerClubDiscountEffectResponse!.data!.newAmount;
      } else {
        return 0;
      }
    } else {
      if (invoiceDataForPayment != null) {
        return invoiceDataForPayment!.amount;
      } else {
        return 0;
      }
    }
  }

  @override
  void onInit() {
    billDataListRequest();
    super.onInit();
  }

  /// Get data of [ListGiftCardData] from server request
  void billDataListRequest() {
    isListLoading = true;
    update();
    update();

    InvoiceServices.getBillListRequest().then((result) {
      isListLoading = true;
      update();

      switch (result) {
        case Success(value: (final ListBillData response, int _)):
          billDataList = response.data;
          filteredBillDataList = billDataList;
          hasError = false;
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

  Future<void> showEditBillDataBottomSheet(BillData billData) async {
    if (isClosed) {
      return;
    }
    selectedBillData = billData;
    titleController.text = selectedBillData!.title ?? '';
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: GestureDetector(
          onTap: () {
            AppUtil.hideKeyboard(context);
          },
          child: const EditBillWidgetBottomSheet(),
        ),
      ),
    );
    selectedBillData = null;
    titleController.text = '';
    isTitleValid = true;
    update();
    openBottomSheets--;
  }

  /// Sends a request to edit bill data.
  ///
  /// creates a [BillDataRequest] with the updated bill information
  /// and sends it to the InvoiceServices.
  void _editBillDataRequest(BillData billData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final BillDataRequest billDataRequest = BillDataRequest();
    billDataRequest.title = billData.title;
    billDataRequest.billIdentifier = billData.billIdentifier;
    InvoiceServices.updateBillRequest(
      billDataRequest: billDataRequest,
      billId: billData.id!,
    ).then((result) {
      switch (result) {
        case Success(value: _):
          Get.back();
          SnackBarUtil.showSuccessSnackBar(locale.bill_updated_successfully);
          AppUtil.previousPageController(pageController, isClosed);
          Timer(Constants.duration500, () {
            billDataListRequest();
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title:locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void confirmDeleteBillData(BillData billData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    selectedBillData = billData;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.are_you_sure_to_delete_bill,
        description: locale.bill_will_be_removed_from_list,
        positiveMessage: locale.delete,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _deleteBillDataRequest();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  /// Sends a request to delete bill data.
  void _deleteBillDataRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isDeleteLoading = true;
    update();

    InvoiceServices.deleteBillRequest(
      billId: selectedBillData!.id!,
    ).then((result) {
      isDeleteLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          SnackBarUtil.showSuccessSnackBar(locale.bill_deleted_successfully);
          AppUtil.previousPageController(pageController, isClosed);
          Timer(Constants.duration500, () {
            billDataListRequest();
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Sends a request to inquire about a bill.
  void inquiryBillRequest(BillData billData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    selectedBillData = billData;

    isLoading = true;
    update();

    InvoiceServices.inquiryBillRequest(
      billId: selectedBillData!.id!,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final BillInquiryDataResponse response, int _)):
          if (response.data!.amount == 0) {
            _closeBottomSheets();
            Timer(Constants.duration500, () {
              SnackBarUtil.showInfoSnackBar(locale.bill_already_paid);
            });
          } else {
            invoiceDataForPayment = InvoiceData();
            invoiceDataForPayment!.billId = response.data!.billId;
            invoiceDataForPayment!.payId = response.data!.payId;
            invoiceDataForPayment!.title = response.data!.type;
            invoiceDataForPayment!.amount = response.data!.amount;
            _getDiscountEffectRequest();
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Sends a request to get the discount effect for a payment.
  Future<void> _getDiscountEffectRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    CustomerClubServices.getDiscountEffectRest(amount: invoiceDataForPayment!.amount!).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final CustomerClubDiscountEffectResponse response, int _)):
            walletAmount = response.data!.wallet!;
            setValidPaymentType();
            customerClubDiscountEffectResponse = response;
            update();
            _showPaymentBottomSheet();
          case Failure(exception: final ApiException apiException):
            hasError = true;
            errorTitle = apiException.displayMessage;
            update();
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  bool isInvoiceListEmpty() {
    return (filteredBillDataList!.isEmpty);
  }

  void validateEditInvoiceName() {
    AppUtil.hideKeyboard(Get.context!);
    if (titleController.text.isNotEmpty) {
      selectedBillData!.title = titleController.text;
      _editBillDataRequest(selectedBillData!);
    }
  }

  void setSelectedBillTypeData(BillTypeData newValue) {
    selectedBillTypeData = newValue;
    if (selectedBillTypeData.id == -1) {
      filteredBillDataList = billDataList;
    } else {
      filteredBillDataList = billDataList!.where((element) => element.typeId == selectedBillTypeData.id).toList();
    }
    update();
  }

  /// Split barcode value with 13 first digits as bill id &
  /// remain digits for pay id
  void setBarcode(String? barcode) {
    if (barcode != null) {
      final InvoiceData invoiceData = InvoiceData();
      invoiceData.billId = barcode.substring(0, 13);
      invoiceData.payId = barcode.substring(13, barcode.length);
      billIdHasBarcodeController.text = invoiceData.billId ?? '';
      payIdController.text = invoiceData.payId ?? '';
      Timer(Constants.duration200, () {
        update();
      });
    }
  }

  Future<void> _showPaymentBottomSheet() async {
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
        child: InvoiceSelectPaymentBottomSheet(
          invoiceData: invoiceDataForPayment!,
        ),
      ),
    );
    openBottomSheets--;
    useDiscount = false;
    update();
  }

  void setCurrentPaymentType(PaymentType paymentType) {
    currentPaymentType = paymentType;
    update();
  }

  void setValidPaymentType() {
    final int? correctAmount = getCorrectAmount();
    if (walletAmount < correctAmount!) {
      setCurrentPaymentType(PaymentType.gateway);
    } else {
      setCurrentPaymentType(PaymentType.wallet);
    }
  }

  void validatePayment() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.are_you_sure_to_pay_bill,
        description: locale.bill_will_be_paid,
        positiveMessage: locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _validateAmount();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  void _validateAmount() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (useDiscount) {
      if (customerClubDiscountEffectResponse!.data!.newAmount! < 1000 && currentPaymentType != PaymentType.wallet) {
        Timer(Constants.duration100, () {
          SnackBarUtil.showInfoSnackBar(
            locale.payment_must_be_wallet_for_small_amounts,
          );
        });
        return;
      }
      if (customerClubDiscountEffectResponse!.data!.newAmount! > walletAmount &&
          currentPaymentType == PaymentType.wallet) {
        Timer(Constants.duration100, () {
          SnackBarUtil.showNotEnoughWalletMoneySnackBar();
        });
        return;
      } else {
        _payBillRequest();
      }
    } else {
      if (currentPaymentType == PaymentType.wallet) {
        if (walletAmount >= invoiceDataForPayment!.amount!) {
          _payBillRequest();
        } else {
          Timer(Constants.duration100, () {
            SnackBarUtil.showNotEnoughWalletMoneySnackBar();
          });
        }
      } else {
        _payBillRequest();
      }
    }
  }

  // Sends a request to pay a bill.
  // Sends a request to pay a bill.
  void _payBillRequest() {
    invoiceDataForPayment!.isWallet = currentPaymentType == PaymentType.wallet;
    invoiceDataForPayment!.discount = useDiscount ? 1 : 0;

    if (currentPaymentType == PaymentType.wallet) {
      _payBillWalletRequest();
    } else if (GetPlatform.isWeb) {
      // For web, directly trigger the internet request without additional UI
      _payBillInternetRequest();
    } else {
      // For mobile, proceed with existing flow
      _payBillInternetRequest();
    }
  }

  /// Sends a request to pay a bill using internet payment.
  void _payBillInternetRequest() async {

    final locale = AppLocalizations.of(Get.context!)!;

    isLoading = true;
    update();

    try {
      // Generate a short-lived token if required
      final tokenData = await _generateToken();
      final token = tokenData['token'];
      invoiceDataForPayment!.token = token; // Assuming InvoiceData has a token field

      InvoiceServices.payBillInternetRequest(
        invoiceData: invoiceDataForPayment!,
      ).then((result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final PayBillData response, int _)):
            payBillData = response;
            update();
            if (GetPlatform.isWeb) {
              if (payBillData?.data?.url != null) {
                html.window.location.href = payBillData!.data!.url!;
              } else {
                SnackBarUtil.showSnackBar(
                  title: locale.error,
                  message: locale.pay_url_not_recieve,
                );
              }
            } else {
              _closeBottomSheets();
              AppUtil.nextPageController(pageController, isClosed);
            }
            break;
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      });
    } catch (e) {
      isLoading = false;
      update();
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: locale.error_in_pay_request,
      );
    }
  }

// Private function to generate a short-lived token
  Future<Map<String, dynamic>> _generateToken() async {
    try {
      // Assuming TokenUtil is available in your project
      final tokenData = await TokenUtil.generateShortLivedToken();
      return tokenData;
    } catch (e) {
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: locale.problem_in_generating_token,
      );
      rethrow;
    }
  }

  /// Sends a request to pay a bill using the wallet.
  void _payBillWalletRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    InvoiceServices.payBillWalletRequest(
      invoiceData: invoiceDataForPayment!,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionData = response.data;
          if (useDiscount) {
            mainController.updateWallet();
          }
          update();
          _closeBottomSheets();
          AppUtil.changePageController(
            pageController: pageController,
            page: 3,
            isClosed: isClosed,
          );
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> showBillTypeSelectorBottomSheet() async {
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
        child: const SelectBillTypeBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void handleBillTypeDataClick(BillTypeData billTypeData) {
    if (billTypeData.id == 1) {
      _showPhoneInquiryBottomSheet();
    } else if (billTypeData.id == 2 || billTypeData.id == 3) {
      _showUsingBillIdBottomSheet();
    } else if (billTypeData.id == 4) {
      _showCustomerIdInquiryBottomSheet();
    }
  }

  Future<void> showInvoiceBarcodeBottomSheet() async {
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
        child: const InvoiceBarcodeBottomSheet(),
      ),
    );
    billIdHasBarcodeController.text = '';
    isBillIdHasBarcodeValid = true;
    payIdController.text = '';
    isPayIdValid = true;
    update();
    openBottomSheets--;
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
    AppUtil.hideKeyboard(Get.context!);
    mainController.analyticsService.logEvent(name: 'Invoice_Event', parameters: {'value': 'Barcode_Scanner_Click'});
    final bool isGranted = await PermissionHandler.camera.isGranted;
    if (!isGranted) {
      DialogUtil.showDialogMessage(
          buildContext: Get.context!,
          message: locale.camera_access_required,
          description: locale.camera_access_required_description,
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

  /// Show [QrScannerScreen] for scan barcode
  void _startQrScannerScreen() {
    Get.to(
      () => QrScannerScreen(
        isInvoice: true,
        returnData: (barCodeString) {
          _splitBarcode(barCodeString!);
        },
      ),
    );
  }

  /// Split barcode value with 13 first digits as bill id &
  /// remain digits for pay id
  void _splitBarcode(String barcode) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (string_validator.isNumeric(barcode) && barcode.length == 26) {
      billIdHasBarcodeController.text = barcode.substring(0, 13);
      payIdController.text = barcode.substring(13, barcode.length);
      billIdHasBarcodeController.text = billIdHasBarcodeController.text;
      payIdController.text = payIdController.text;
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.invalid_barcode,
      );
    }
  }

  void validateInvoiceBarcode() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (billIdHasBarcodeController.text.trim().isNotEmpty) {
      isBillIdHasBarcodeValid = true;
    } else {
      isValid = false;
      isBillIdHasBarcodeValid = false;
    }
    if (payIdController.text.trim().isNotEmpty) {
      isPayIdValid = true;
    } else {
      isValid = false;
      isPayIdValid = false;
    }
    update();
    if (isValid) {
      _getBillDataByPayAndBillRequest();
    }
  }

  /// Get data of [BillDetailData] from server request
  void _getBillDataByPayAndBillRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final GetBillDetailByPayIdBillIdRequest getBillDetailRequest = GetBillDetailByPayIdBillIdRequest();
    getBillDetailRequest.payId = payIdController.text;
    getBillDetailRequest.billId = billIdHasBarcodeController.text;

    isLoading = true;
    update();

    InvoiceServices.getBillDetailWithPayIdBillId(
      getBillDetailRequest: getBillDetailRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final BillDetailData response, int _)):
          if (response.data!.amount == 0) {
            _closeBottomSheets();
            Timer(Constants.duration500, () {
              SnackBarUtil.showInfoSnackBar(locale.bill_already_paid);
            });
          } else {
            invoiceDataForPayment = InvoiceData();
            invoiceDataForPayment!.billId = response.data!.requestData!.billId;
            invoiceDataForPayment!.payId = response.data!.requestData!.payId;
            invoiceDataForPayment!.title = response.data!.billType;
            invoiceDataForPayment!.amount = response.data!.amount;
            _getDiscountEffectRequest();
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _showPhoneInquiryBottomSheet() async {
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
        child: const PhoneInquiryBottomSheet(),
      ),
    );
    phoneNumberController.text = '';
    titleController.text = '';
    isPhoneNumberValid = true;
    isTitleValid = true;
    isStoreBill = false;
    update();
    openBottomSheets--;
  }

  Future<void> showSelectMidtermBottomSheet() async {
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
        child: const PhoneMidtermBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void setMobileTermType(MobileTermType? value) {
    selectedMobileTermType = value;
    update();
  }

  void setIsStoreBill(bool value) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (value) {
      confirmButtonTitle = locale.save_bill_and_cheque_cost;
    } else {
      confirmButtonTitle = locale.confirm_button_title;
      titleController.clear();
    }
    isStoreBill = value;
    update();
  }

  void validatePhoneInquiry() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (phoneNumberController.text.trim().isNotEmpty &&
        (phoneNumberController.text.trim().length == Constants.mobileNumberLength ||
            phoneNumberController.text.trim().length == Constants.phoneNumberLength)) {
      isPhoneNumberValid = true;
    } else {
      isValid = false;
      isPhoneNumberValid = false;
    }
    if (isStoreBill) {
      if (titleController.text.isNotEmpty) {
        isTitleValid = true;
      } else {
        isTitleValid = false;
        isValid = false;
      }
    }
    update();
    if (isValid) {
      showSelectMidtermBottomSheet();
    }
  }

  void validatePhoneMidterm() {
    final BillDataRequest billDataRequest = BillDataRequest();
    billDataRequest.title = titleController.text;
    if (phoneNumberController.text.trim().length == Constants.mobileNumberLength &&
        phoneNumberController.text.startsWith(Constants.mobileStartingDigits)) {
      billDataRequest.mobile = phoneNumberController.text;
    } else {
      billDataRequest.phone = phoneNumberController.text;
    }
    billDataRequest.isStore = isStoreBill;
    billDataRequest.isMidTerm = selectedMobileTermType == MobileTermType.midTerm;
    _billDetailDataRequest(billDataRequest);
  }

  /// Get data of [BillDetailData] from server request
  void _billDetailDataRequest(BillDataRequest billDataRequest) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    InvoiceServices.getBillDetailDataRequest(
      billDataRequest: billDataRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final BillInquiryDataResponse response, int _)):
          if (response.data!.amount == 0) {
            _closeBottomSheets();
            Timer(Constants.duration500, () {
              SnackBarUtil.showInfoSnackBar(locale.bill_already_paid);
            });
          } else {
            invoiceDataForPayment = InvoiceData();
            invoiceDataForPayment!.billId = response.data!.billId;
            invoiceDataForPayment!.payId = response.data!.payId;
            invoiceDataForPayment!.title = response.data!.type;
            invoiceDataForPayment!.amount = response.data!.amount;
            _getDiscountEffectRequest();
            if (billDataRequest.isStore == true) {
              AppUtil.previousPageController(pageController, isClosed);
              Timer(Constants.duration500, () {
                billDataListRequest();
              });
            }
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _showUsingBillIdBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
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
        child: const BillIdInquiryBottomSheet(),
      ),
    );
    billIdController.text = '';
    titleController.text = '';
    isBillIdValid = true;
    isTitleValid = true;
    isStoreBill = false;
    update();
    openBottomSheets--;
  }

  /// Validate values of form before request
  void validateInvoiceOnlyBillId() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (billIdController.text.trim().isNotEmpty) {
      isBillIdValid = true;
    } else {
      isValid = false;
      isBillIdValid = false;
    }
    if (isStoreBill) {
      if (titleController.text.isNotEmpty) {
        isTitleValid = true;
      } else {
        isValid = false;
        isTitleValid = false;
      }
    }
    update();
    if (isValid) {
      final BillDataRequest billDataRequest = BillDataRequest();
      billDataRequest.billIdentifier = billIdController.text;
      billDataRequest.title = titleController.text;
      billDataRequest.isStore = isStoreBill;
      _billDetailDataRequest(billDataRequest);
    }
  }

  Future<void> _showCustomerIdInquiryBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
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
        child: const CustomerIdInquiryBottomSheet(),
      ),
    );
    customerIdController.text = '';
    titleController.text = '';
    isCustomerIdValid = true;
    isTitleValid = true;
    isStoreBill = false;
    update();
    openBottomSheets--;
  }

  /// Validate values of form before request
  void validateCustomerIdInquiry() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (customerIdController.text.trim().isNotEmpty) {
      isCustomerIdValid = true;
    } else {
      isValid = false;
      isCustomerIdValid = false;
    }
    if (isStoreBill) {
      if (titleController.text.isNotEmpty) {
        isTitleValid = true;
      } else {
        isTitleValid = false;
        isValid = false;
      }
    }
    update();
    if (isValid) {
      final BillDataRequest billDataRequest = BillDataRequest();
      billDataRequest.title = titleController.text;
      billDataRequest.isStore = isStoreBill;
      billDataRequest.customerId = customerIdController.text;
      _billDetailDataRequest(billDataRequest);
    }
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

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  void showSelectContactScreen() {
    AppUtil.hideKeyboard(Get.context!);
    Get.to(
      () => ContactScreen(
        returnDataFunction: (contact) {
          setSelectedPhoneNumber(contact);
        },
      ),
    )!
        .then((value) => AppUtil.hideKeyboard(Get.context!));
  }

  void setSelectedPhoneNumber(CustomContact contact) {
    phoneNumberController.text =
        contact.phones!.toList()[0].replaceAll(' ', '').replaceAll(Constants.iranCountryCode, '0');
    update();
  }

  void setUseDiscount(bool value) {
    useDiscount = value;
    update();
    setValidPaymentType();
  }

  bool isDiscountEnabled() {
    return mainController.walletDetailData!.data!.havadary == true &&
        customerClubDiscountEffectResponse!.data!.pointsLost != '0';
  }

  void setAddButtonVisible(bool value) {
    showAddButton = value;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
