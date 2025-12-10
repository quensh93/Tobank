import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bank_list_data.dart';
import '../../model/card/expire_data.dart';
import '../../model/card/request/submit_card_request_data.dart';
import '../../model/card/response/card_data_response.dart';
import '../../model/card/response/list_bank_data.dart';
import '../../model/common/card_scanner_data.dart';
import '../../service/card_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/card_scanner/card_scanner_screen.dart';
import '../../ui/common/card_expire_select_view.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class AddCardController extends GetxController {
  MainController mainController = Get.find();

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  bool cardNumberValid = true;
  bool cardExpYearValid = true;
  bool cardExpMonthValid = true;
  bool isTitleValid = true;

  bool isLoading = false;
  bool isBankLoading = false;
  List<BankInfoData>? bankInfoList = [];

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;
  List<BankDataItem> bankDataItemList = [];

  @override
  Future<void> onInit() async {
    await _getBankListData();
    getListBankDataRequest();
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

  /// Sends a request to get a list of bank data and handles the response.
  void getListBankDataRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isBankLoading = true;
    update();

    CardServices.getListBankData(isTransfer: true).then((result) {
      isBankLoading = false;
      update();
      switch (result) {
        case Success(value: (final ListBankData response, int _)):
          bankInfoList = response.data!;
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

  /// Validate form values before request to store
  void validate() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (cardNumberController.text.trim().length == Constants.cardNumberWithDashLength) {
      cardNumberValid = true;
    } else {
      isValid = false;
      cardNumberValid = false;
    }
    if (yearController.text.length == 2) {
      cardExpYearValid = true;
    } else {
      isValid = false;
      cardExpYearValid = false;
    }

    if (monthController.text.length == 2 &&
        int.parse(monthController.text) > 0 &&
        int.parse(monthController.text) <= 12) {
      cardExpMonthValid = true;
    } else {
      isValid = false;
      cardExpMonthValid = false;
    }
    if (titleController.text.trim().isNotEmpty) {
      isTitleValid = true;
    } else {
      isValid = false;
      isTitleValid = false;
    }
    update();

    if (isValid) {
      _submitUserCardRequest();
    }
  }

  /// Get data of [CardData] from server request
  void _submitUserCardRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final SubmitCardRequest submitCardRequest = SubmitCardRequest(
      title: titleController.text,
      cardNumber: cardNumberController.text.replaceAll('-', ''),
      cardExpMonth: monthController.text,
      cardExpYear: yearController.text,
      isMine: true,
    );

    CardServices.submitCardRequest(
      submitCardRequest: submitCardRequest,
    ).then((result) {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final CardDataResponse _, int _)):
          mainController.walletDetailData!.data!.hasAnyCards = true;
          Get.back();
          SnackBarUtil.showSuccessSnackBar(locale.card_registration_success);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void showExpireDateBottomSheet() {
    if (isClosed) {
      return;
    }
    AppUtil.hideKeyboard(Get.context!);
    final ExpireData expireData = ExpireData();
    expireData.expireMonth = monthController.text;
    expireData.expireYear = yearController.text;
    showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 9 / 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: CardExpireSelectWidget(
          expireData: expireData,
          returnData: (selectedExpireData) {
            yearController.text = selectedExpireData.expireYear ?? '';
            monthController.text = selectedExpireData.expireMonth ?? '';
            update();
          },
        ),
      ),
    );
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
