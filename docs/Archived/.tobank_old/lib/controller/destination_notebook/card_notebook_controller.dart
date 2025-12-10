import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bank_list_data.dart';
import '../../model/card/request/edit_remote_card_request_data.dart';
import '../../model/card/request/submit_card_request_data.dart';
import '../../model/card/response/card_data_response.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/common/card_scanner_data.dart';
import '../../service/card_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/card_scanner/card_scanner_screen.dart';
import '../../ui/destination_notebook/card_notebook/widget/add_card_notebook_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/theme/theme_util.dart';
import '../main/main_controller.dart';

class CardNotebookController extends GetxController {
  MainController mainController = Get.find();
  CustomerCard? notebookCustomerCard;
  CustomerCard? selectedCustomerCard;
  OperationType currentOperationType = OperationType.insert;
  List<CustomerCard> notebookCardDataList = [];
  List<BankInfo> bankInfoList = [];
  bool isLoading = false;
  bool isDeleteLoading = false;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController customerController = TextEditingController();

  bool cardNumberValid = true;
  bool isTitleValid = true;

  bool showAddButton = true;

  String errorTitle = '';

  bool hasError = false;

  List<BankDataItem> bankDataItemList = [];

  @override
  Future<void> onInit() async {
    await _getBankListData();
    requestListOfCards();
    super.onInit();
  }

  Future<void> _getBankListData() async {
    final String data = await DefaultAssetBundle.of(Get.context!).loadString('assets/json/bank_list_data.json');
    final BankListData bankListData = bankListDataFromJson(data);
    bankDataItemList = bankListData.data ?? [];
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// If in operationType == [OperationType.update]
  /// set values of card to TextFields
  /// else, empty all values
  void _setCardData(CustomerCard? notebookCustomerCard) {
    if (notebookCustomerCard != null && currentOperationType == OperationType.update) {
      cardNumberController.text = AppUtil.splitCardNumber(notebookCustomerCard.cardNumber!, '-');
      customerController.text = notebookCustomerCard.title!;
    } else {
      cardNumberController.text = '';
      customerController.text = '';
    }
  }

  /// Get data of [CardData] from server request
  void requestListOfCards() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    notebookCardDataList = [];
    hasError = false;
    isLoading = true;
    update();
    CardServices.getCustomerCardsRequest().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final CustomerCardResponseData response, int _)):
            hasError = false;
            notebookCardDataList = response.data!.cards ?? [];
            bankInfoList = response.data!.bankInfo ?? [];
            notebookCardDataList = notebookCardDataList.where((element) => element.isMine == false).toList();
            update();
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

  void showInsertPage() {
    currentOperationType = OperationType.insert;
    cardNumberController = TextEditingController();
    customerController = TextEditingController();
    notebookCustomerCard = null;
    cardNumberValid = true;
    isTitleValid = true;
    update();
    _showAddCardNotebookBottomSheet();
  }

  void _showAddCardNotebookBottomSheet() {
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
        child: const AddCardNotebookBottomSheet(),
      ),
    );
  }

  void setAddButtonVisible(bool value) {
    showAddButton = value;
    update();
  }

  void showEditCardPage(CustomerCard? notebookCustomerCard) {
    this.notebookCustomerCard = notebookCustomerCard;
    currentOperationType = OperationType.update;
    _setCardData(notebookCustomerCard);
    update();
    _showAddCardNotebookBottomSheet();
  }

  /// Show confirm message before remove card from local db
  void deleteCard(CustomerCard? notebookCustomerCard) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    selectedCustomerCard = notebookCustomerCard;
    final bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == selectedCustomerCard!.bankId);
    DialogUtil.showCardConfirmDialogMessage(
      buildContext: Get.context!,
      title: locale.delete_card,
      titleDescription: locale.confirm_card_deletion,
      confirmMessage: locale.delete,
      cancelMessage: locale.cancel,
      pan: selectedCustomerCard!.cardNumber!,
      symbol: bankInfo!.symbol!,
      positiveFunction: () {
        isDeleteLoading = true;
        Get.back(closeOverlays: true);
        _deleteCardRequest(notebookCustomerCard!);
      },
      negativeFunction: () {
        Get.back(closeOverlays: true);
      },
      buttonColor: ThemeUtil.primaryColor,
    );
  }

  /// Sends a request to delete a customer card.
  void _deleteCardRequest(CustomerCard notebookCustomerCard) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isDeleteLoading = true;
    update();
    CardServices.deleteUserCardRequest(
      notebookCustomerCard.id!,
    ).then((result) {
      isDeleteLoading = false;
      update();
      switch (result) {
        case Success(value: _):
          requestListOfCards();
          SnackBarUtil.showSuccessSnackBar(locale.delete_card_successfully);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Get data of [CardDataModel] from server request
  void _editUserCardRequest(CustomerCard customerCard) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final editNotebookCardDataRequest = EditNotebookCardDataRequest();
    editNotebookCardDataRequest.id = customerCard.id;
    editNotebookCardDataRequest.title = customerCard.title;
    editNotebookCardDataRequest.cardNumber = customerCard.cardNumber;
    isLoading = true;
    update();
    CardServices.updateNotebookCardRequest(
      editNotebookCardDataRequest: editNotebookCardDataRequest,
    ).then((result) {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: _):
          Get.back();
          SnackBarUtil.showSuccessSnackBar(locale.card_information_updated_successfully);
          requestListOfCards();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Sends a request to submit a customer card to the notebook.
  void _submitCardToNoteBookRequest(CustomerCard customerCard) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final SubmitCardRequest submitCardRequest = SubmitCardRequest(
      title: customerCard.title!,
      cardNumber: cardNumberController.text.replaceAll('-', ''),
      cardExpMonth: null,
      cardExpYear: null,
      isMine: false,
    );

    CardServices.submitCardRequest(
      submitCardRequest: submitCardRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CardDataResponse _, int _)):
          Get.back();
          SnackBarUtil.showSuccessSnackBar(locale.card_registration_success);
          requestListOfCards();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }


  /// Validate values of form before request
  void validate() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (cardNumberController.text.length == Constants.cardNumberWithDashLength) {
      cardNumberValid = true;
    } else {
      isValid = false;
      cardNumberValid = false;
    }
    if (customerController.text.isNotEmpty) {
      isTitleValid = true;
    } else {
      isValid = false;
      isTitleValid = false;
    }
    update();

    if (isValid) {
      final CustomerCard cardData = CustomerCard(
        cardNumber: cardNumberController.text.replaceAll('-', ''),
        title: customerController.text,
        id: currentOperationType == OperationType.insert
            ? DateTime.now().millisecondsSinceEpoch
            : notebookCustomerCard!.id,
      );
      if (currentOperationType == OperationType.insert) {
        _submitCardToNoteBookRequest(cardData);
      } else {
        _editUserCardRequest(cardData);
      }
    }
  }

  void copyToClipboard(CustomerCard customerCard) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Clipboard.setData(ClipboardData(text: customerCard.cardNumber ?? ''));
    SnackBarUtil.showInfoSnackBar(locale.card_number_copied);
  }

  void showCardScannerScreen() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Get.to(() => CardScannerScreen(
          returnDataFunction: (CardScannerData cardScannerData) {
            if (cardScannerData.isSuccess == true && cardScannerData.cardNumber != null) {
              final BankDataItem? bankDataItem = bankDataItemList
                  .firstWhereOrNull((element) => element.preCode == cardScannerData.cardNumber!.substring(0, 6));
              if (bankDataItem != null) {
                cardNumberController.text = AppUtil.splitCardNumber(cardScannerData.cardNumber!, '-');
              } else {
                SnackBarUtil.showSnackBar(
                  title: locale.announcement,
                  message: locale.card_scan_failed,
                );
              }
            } else {
              SnackBarUtil.showSnackBar(
                title: locale.announcement,
                message: locale.card_scan_failed,
              );
            }
          },
        ));
  }
}
