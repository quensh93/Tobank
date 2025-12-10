import 'package:universal_io/io.dart';
import 'dart:typed_data';
import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/add_deposit/response/deposit_list_data_response.dart';
import '../../../model/common/menu_data.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../model/transfer/purpose_data.dart';
import '../../../model/transfer/request/iban_inquiry_request_data.dart';
import '../../../model/transfer/request/transfer_request_data.dart';
import '../../../model/transfer/response/iban_inquiry_response_data.dart';
import '../../../model/transfer/response/transfer_response_data.dart';
import '../../../model/transfer/transfer_method_data.dart';
import '../../../service/core/api_core.dart';
import '../../../service/deposit_notebook_services.dart';
import '../../../service/transfer_services.dart';
import '../../../ui/common/share_transaction_bottom_sheet.dart';
import '../../../ui/deposit/deposit_transfer/widget/deposit_transfer_type_bottom_sheet.dart';
import '../../../ui/deposit/deposit_transfer/widget/transaction_purpose_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/dialog_util.dart';
import '../../../util/digit_to_word.dart';
import '../../../util/enums_constants.dart';
import '../../../util/file_util.dart';
import '../../../util/permission_handler.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/web_only_utils/image_share_util.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../main/main_controller.dart';

class DepositTransferController extends GetxController {
  List<DepositDataModel> destinationDepositDataModelList = [];
  List<DepositDataModel> destinationIbanDataModelList = [];
  MainController mainController = Get.find();
  bool hasError = false;
  String errorTitle = '';
  bool isLoading = false;
  int destinationPageNumber = 0;

  TextEditingController depositDestinationController = TextEditingController();
  bool isDestinationNumberValid = true;

  TextEditingController ibanDestinationController = TextEditingController();

  GlobalKey globalKey = GlobalKey();
  Deposit? deposit;
  String destinationDeposit = '';
  PageController pageController = PageController();
  bool isDestinationDepositValid = true;
  TextEditingController amountDepositController = TextEditingController();
  bool isAmountDepositValid = true;

  int amount = 0;
  bool isSourceDepositValid = true;
  TransferMethodData? selectedTransferMethodData;
  IbanInquiryResponseData? ibanInquiryResponseData;
  TransferResponseData? transferResponseData;
  TextEditingController transactionPurposeController = TextEditingController();
  TextEditingController localDescriptionController = TextEditingController();
  TextEditingController referenceNumberController = TextEditingController();
  TextEditingController transactionDescriptionController = TextEditingController();
  PurposeData? selectedPurposeData;
  bool isPurposeValid = true;
  String destinationErrorText = '';
  bool isIBAN = false;

  int openBottomSheets = 0;

  bool storeLoading = false;

  bool shareLoading = false;

  DepositTransferController({
    required this.hideTabViewFunction,
    this.deposit,
  });

  late TransferTypeEnum currentTransferType;
  final Function(bool isHideTabView) hideTabViewFunction;

  @override
  void onInit() {
    getDepositNotebookRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void setCurrentTransferType(TransferTypeEnum transferTypeEnum) {
    currentTransferType = transferTypeEnum;
  }

  Future getDepositNotebookRequest() async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    destinationDepositDataModelList = [];
    destinationIbanDataModelList = [];

    hasError = false;
    isLoading = true;
    update();
    DepositNotebookServices.getDepositList().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final DepositListDataResponse response, int _)):
            for (final DepositDataModel element in response.data!) {
              if (element.iban != null && element.iban != '') {
                element.type = DestinationType.iban;
                destinationIbanDataModelList.add(element);
              } else {
                element.type = DestinationType.deposit;
                destinationDepositDataModelList.add(element);
              }
            }
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
      },
    );
  }

  void setSelectedDepositData(DepositDataModel depositModel) {
    if (depositModel.type == DestinationType.iban) {
      final String ibanString = depositModel.iban!;
      ibanDestinationController.text = ibanString.replaceAll('IR', '');
    } else {
      depositDestinationController.text = depositModel.accountNumber!;
    }
    update();
  }

  void validateDepositSelector() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    isIBAN = false;
    if (depositDestinationController.text.isNotEmpty) {
      isDestinationNumberValid = true;
    } else {
      isDestinationNumberValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      destinationDeposit = depositDestinationController.text;
      hideTabViewFunction(true);
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void changePage(int value) {
    destinationPageNumber = value;
    update();
  }

  void validateIbanSelector() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    isIBAN = true;
    if (ibanDestinationController.text.isNotEmpty && ibanDestinationController.text.length == Constants.ibanLength) {
      isDestinationNumberValid = true;
    } else {
      destinationErrorText = locale.invalid_sheba_number_length;
      isDestinationNumberValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      destinationDeposit = 'IR${ibanDestinationController.text}';
      hideTabViewFunction(true);
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  /// Formatting value of amount with each three number one separation
  ///  1000 => 1,000
  void validateAmountValue(String value, TextEditingController amountController) {
    value.replaceAll(',', '');
    if (value.length > 3) {
      amountController.text = AppUtil.formatMoney(value);
      amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
      amount = int.parse(value);
    }
    update();
  }

  void clearAmountTextField() {
    amountDepositController.clear();
    amount = 0;
    update();
  }

  Future<void> validateTransferAmountPage() async {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (amount >= Constants.minValidAmount) {
      isAmountDepositValid = true;
    } else {
      isValid = false;
      isAmountDepositValid = false;
    }
    if (selectedPurposeData != null) {
      isPurposeValid = true;
    } else {
      isPurposeValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _ibanInquiryRequest();
    }
  }

  String getAmountDetail() {
    if (amountDepositController.text.isEmpty || amountDepositController.text.length == 1) {
      return '';
    } else {
      final int amountInToman = amount ~/ 10;
      return DigitToWord.toWord(amountInToman.toString(), StrType.numWord, isMoney: true).replaceAll('  ', ' ');
    }
  }

  Future<void> showTransactionPurposeBottomSheet() async {
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
        child: const TransactionPurposeBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  Future<void> showDepositTransferTransferTypeBottomSheet() async {
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
        child: const DepositTransferTypeBottomSheet(),
      ),
    );
    openBottomSheets++;
  }

  void validateTransferTypeSelection() {
    AppUtil.hideKeyboard(Get.context!);
    if (selectedTransferMethodData != null) {
      Get.back();
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void setSelectedTransferMethodData(TransferMethodData transferMethodData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (!ibanInquiryResponseData!.data!.supportedTransferTypes!.contains(transferMethodData.id)) {
      SnackBarUtil.showInfoSnackBar(
        locale.method_not_available,
      );
    } else {
      selectedTransferMethodData = transferMethodData;
      update();
      validateTransferTypeSelection();
    }
  }

  Future<void> validateDepositConfirmPage() async {
    AppUtil.hideKeyboard(Get.context!);
    _transferRequest();
  }

  /// Sends an API request to inquire about the IBAN (International Bank Account Number)
  /// associated with a destination deposit account.
  void _ibanInquiryRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final IbanInquiryRequestData ibanInquiryRequestData = IbanInquiryRequestData();
    //ibanInquiryRequestData.referenceNumber = '123456';
    ibanInquiryRequestData.referenceNumber = referenceNumberController.text.isEmpty ? null : referenceNumberController.text;
    ibanInquiryRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    ibanInquiryRequestData.trackingNumber = const Uuid().v4();
    if (destinationDeposit.toUpperCase().contains('IR')) {
      ibanInquiryRequestData.destinationIban = AppUtil.getEnglishNumbers(destinationDeposit).toUpperCase();
    } else {
      ibanInquiryRequestData.destinationDepositNumber = AppUtil.getEnglishNumbers(destinationDeposit);
    }
    ibanInquiryRequestData.amount = amount;
    isLoading = true;
    update();

    TransferServices.ibanInquiryRequest(
      ibanInquiryRequestData: ibanInquiryRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final IbanInquiryResponseData response, int _)):
          ibanInquiryResponseData = response;
          update();
          showDepositTransferTransferTypeBottomSheet();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves the destination customer's name.
  String getDestinationCustomer() {
    String customer = '';
    if (ibanInquiryResponseData!.data!.firstName != null && ibanInquiryResponseData!.data!.firstName!.isNotEmpty) {
      customer = '${ibanInquiryResponseData!.data!.firstName} ';
    }
    if (ibanInquiryResponseData!.data!.lastName != null && ibanInquiryResponseData!.data!.lastName!.isNotEmpty) {
      customer += ibanInquiryResponseData!.data!.lastName!;
    }
    return customer;
  }

  /// Sends a transfer request to the server
  /// to initiate a transfer between two deposit accounts.
  void _transferRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final TransferRequestData transferRequestData = TransferRequestData();
    //transferRequestData.referenceNumber = "123456";
    transferRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    transferRequestData.trackingNumber = const Uuid().v4();
    transferRequestData.sourceDepositNumber = deposit!.depositNumber ?? '';
    transferRequestData.destinationIban = ibanInquiryResponseData!.data!.iban;
    transferRequestData.amount = amount;
    transferRequestData.approvalCode = ibanInquiryResponseData!.data!.approvalCode;
    transferRequestData.preferredTransferType = selectedTransferMethodData!.id;
    transferRequestData.localDescription = localDescriptionController.text.isEmpty ? null : localDescriptionController.text;
    transferRequestData.referenceNumber = referenceNumberController.text.isEmpty ? null : referenceNumberController.text;
    transferRequestData.transactionDescription =
        transactionDescriptionController.text.isEmpty ? null : transactionDescriptionController.text;
    if (ibanInquiryResponseData!.data!.firstName != null && ibanInquiryResponseData!.data!.firstName!.isNotEmpty) {
      transferRequestData.receiverFirstName = ibanInquiryResponseData!.data!.firstName!;
    } else {
      transferRequestData.receiverFirstName = ibanInquiryResponseData!.data!.lastName!;
    }
    if (ibanInquiryResponseData!.data!.lastName != null && ibanInquiryResponseData!.data!.lastName!.isNotEmpty) {
      transferRequestData.receiverLastName = ibanInquiryResponseData!.data!.lastName!;
    } else {
      transferRequestData.receiverLastName = ibanInquiryResponseData!.data!.firstName!;
    }

    transferRequestData.purpose = selectedPurposeData!.id;
    isLoading = true;
    update();
    TransferServices.transferRequest(
      transferRequestData: transferRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransferResponseData response, int _)):
          transferResponseData = response;
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

  void setSelectedPurposeData(PurposeData? purposeData) {
    selectedPurposeData = purposeData;
    transactionPurposeController.text = purposeData!.title;
    update();
    Get.back();
  }

  void showShareTransactionBottomSheet() {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
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
        child: ShareTransactionBottomSheet(
          returnDataFunction: (MenuData virtualBranchMenuData) {
            handleShareTransactionServices(virtualBranchMenuData);
          },
        ),
      ),
    );
  }

  Future<void> captureAndSaveTransactionImage() async {
    try {
      storeLoading = true;
      update();
      final RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 6);
      final ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      storeLoading = false;
      update();
      _storeTransactionImagePng(pngBytes);
    } on Exception catch (e) {
      storeLoading = false;
      update();
      AppUtil.printResponse(e.toString());
    }
  }

  /// Stores the transaction image as a PNG file.
  Future<void> _storeTransactionImagePng(Uint8List pngBytes) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (Platform.isAndroid) {
      final bool isGranted = await PermissionHandler.storage.isGranted;
      if (isGranted) {
        await FileSaver.instance.saveAs(
            name: '${transferResponseData!.data!.transactionId ?? DateTime.now().millisecondsSinceEpoch}-transaction',
            bytes: pngBytes,
            ext: 'png',
            mimeType: MimeType.png);
      } else {
        DialogUtil.showDialogMessage(
            buildContext: Get.context!,
            message: locale.access_to_device_storage,
            description: locale.storage_permission_transaction_description,
            positiveMessage: locale.confirmation,
            negativeMessage: locale.cancel_laghv,
            positiveFunction: () async {
              Get.back();
              final isGranted = await PermissionHandler.storage.handlePermission();
              if (isGranted) {
                await FileSaver.instance.saveAs(
                    name:
                        '${transferResponseData!.data!.transactionId ?? DateTime.now().millisecondsSinceEpoch}-transaction',
                    bytes: pngBytes,
                    ext: 'png',
                    mimeType: MimeType.png);
              } else if (Platform.isIOS && !isGranted) {
                AppSettings.openAppSettings();
              }
            },
            negativeFunction: () {
              Get.back();
            });
      }
    }
  }

  void handleShareTransactionServices(MenuData virtualBranchMenuData) {
    if (virtualBranchMenuData.id == 1) {
      captureAndShareTransactionImage();
    } else if (virtualBranchMenuData.id == 2) {
      shareTransactionText();
    }
    Get.back();
  }

  /// Generate image from transaction data and share it with intent
  Future<void> captureAndShareTransactionImage() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    try {
      shareLoading = true;
      update();
      /*final RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 6);
      final ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      final File file = await File(FileUtil().generateImagePngPath()).create();
      file.writeAsBytesSync(pngBytes);*/

      await ImageShareUtil.captureAndShareWidget(
        globalKey: globalKey,
        pixelRatio: 6.0,
        fileName: '${locale.transaction_receipt_file_name}.png',
        shareText: locale.transaction_receipt,
      );

      shareLoading = false;
      update();
    } on Exception catch (e) {
      shareLoading = false;
      update();
      AppUtil.printResponse(e.toString());
    }
  }

  void shareTransactionText() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    String text = '';
    text += '${locale.transfer_type}: ${selectedTransferMethodData!.title}\n';
    if (transferResponseData!.data!.transactionId != null) {
      text += '${locale.tracking_number}: ${transferResponseData!.data!.transactionId.toString()}\n';
    }
    text +=
        '${locale.transfer_time}: ${DateConverterUtil.getJalaliDateTimeFromTimestamp(transferResponseData!.data!.registrationDate!)}\n';
    text += '${locale.source_deposit_number}: ${deposit!.depositNumber}\n';
    if (isIBAN) {
      text += '${locale.destination_shaba}: $destinationDeposit\n';
    } else {
      text += '${locale.destination_deposit_number}: $destinationDeposit\n';
    }
    text += '${locale.destination_account_owner}: ${getDestinationCustomer()}\n';
    text += '${locale.transfer_amount}: ${AppUtil.formatMoney(amount)} ${locale.rial}\n';
    text += '\n${locale.tobank_website}\n';
    Share.share(text, subject: locale.transaction_receipt);
  }

  SvgIcons getStatusIcon() {
    if (transferResponseData!.data!.transferStatus == 1) {
      return SvgIcons.transactionSuccess;
    } else if (transferResponseData!.data!.transferStatus == 0) {
      return SvgIcons.transactionFailed;
    } else {
      return SvgIcons.transactionPending;
    }
  }

  /// Handles the back press action in the current screen
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 || pageController.page == 1 || pageController.page == 4) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        if (pageController.page == 2) {
          hideTabViewFunction(false);
        }
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  String getTransferStatus() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (transferResponseData!.data!.financialTransactionId == '1') {
      return locale.transfer_success;
    } else if (transferResponseData!.data!.financialTransactionId == '0') {
      return locale.transaction_failed;
    } else {
      return locale.check_transaction_status_click_recheck_button;
    }
  }

  bool showExternalTransactionId() {
    final transferType =
        AppUtil.transferMethodDataList().where((element) => element.id == selectedTransferMethodData!.id).first;
    if (transferType.id != 0) {
      // PAYA & SATNA
      return transferResponseData!.data!.externalTransactionId != null;
    } else {
      return false;
    }
  }

  String getTrackingCode() {
    final String trackingCode = showExternalTransactionId()
        ? transferResponseData!.data!.externalTransactionId!
        : transferResponseData!.data!.transactionId ?? '-';
    return trackingCode;
  }

  bool isIbanContinueButtonEnabled() {
    return ibanDestinationController.text.isNotEmpty && ibanDestinationController.text.length == Constants.ibanLength;
  }

  bool isDepositContinueButtonEnabled() {
    return depositDestinationController.text.isNotEmpty;
  }
}
