import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/deposit/request/customer_deposits_request_data.dart';
import '../../model/deposit/request/long_term_deposit_request_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/deposit/response/deposit_type_response_data.dart';
import '../../model/deposit/response/long_term_deposit_response_data.dart';
import '../../model/other/response/other_item_data.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../service/other_services.dart';
import '../../ui/open_long_term_deposit/widget/long_term_deposit_amount_bottom_sheet.dart';
import '../../ui/open_long_term_deposit/widget/long_term_deposit_confirm_bottom_sheet.dart';
import '../../ui/open_long_term_deposit/widget/long_term_deposit_destination_selector_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/digit_to_word.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class OpenLongTermDepositController extends GetxController {
  final DepositType selectedDepositType;
  MainController mainController = Get.find();

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  bool isLoading = false;

  bool issuanceCard = false;

  ScrollController scrollbarController = ScrollController();

  bool isChecked = false;

  TextEditingController addressController = TextEditingController();

  late DepositTypeResponseData depositTypeResponseData;

  late OtherItemData otherItemData;

  List<Deposit> depositList = [];
  Deposit? selectedSourceDeposit;

  Deposit? selectedDestinationDeposit;

  int amount = 0;

  TextEditingController amountController = TextEditingController();

  bool isAmountValid = true;

  int? selectedDepositYearType;

  String amountInvalidMessage = '';

  LongTermDepositResponseData? longTermDepositResponseData;
  int openBottomSheets = 0;
  int? branchCode;

  OpenLongTermDepositController({required this.selectedDepositType, this.branchCode});

  void setIssuanceCard(bool? isChecked) {
    issuanceCard = isChecked!;
    update();
  }

  void setChecked(bool isCheck) {
    isChecked = isCheck;
    update();
  }

  void nextPage() {
    AppUtil.nextPageController(pageController, isClosed);
  }

  void validateFirstPage() {
    _getShabahangDepositLongTermRulesRequest();
  }

  void validateSecondPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isChecked) {
      _getDepositListRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_read_and_accept_terms,
      );
    }
  }

  /// Retrieves Shabahang Deposit Long-Term rules from the server.
  void _getShabahangDepositLongTermRulesRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    OtherServices.getShabahangDepositLongTermRules().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
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

  /// Retrieves the list of deposits for the customer.
  void _getDepositListRequest() {
//locale
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
          _handleListOfDeposit(response);
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void validateThirdPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (selectedSourceDeposit != null) {
      if (amount >= Constants.minValidDepositAmount) {
        if (amount % 50 == 0) {
          isAmountValid = true;
          update();
          _showSelectDestinationDepositBottomSheet();
        } else {
          isAmountValid = false;
          amountInvalidMessage = locale.amount_invalid_message_multiple_of_50;
          update();
        }
      } else {
        isAmountValid = false;
        amountInvalidMessage = locale.amount_invalid_message_below_minimum;
        update();
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_one_of_deposit,
      );
    }
  }

  void setSelectedDeposit(Deposit deposit) {
    selectedSourceDeposit = deposit;
    update();
  }

  void setSelectedDestinationDeposit(Deposit deposit) {
    selectedDestinationDeposit = deposit;
    update();
  }

  void validateFourthPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedDestinationDeposit != null) {
      _showLongTermDepositConfirmBottomSheet();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_one_of_deposit,
      );
    }
  }

  void validateFifthPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final LongTermDepositRequestData longTermDepositRequestData = LongTermDepositRequestData();
    longTermDepositRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    longTermDepositRequestData.amount = amount;
    longTermDepositRequestData.trackingNumber = const Uuid().v4();
    longTermDepositRequestData.depositTypeCode = selectedDepositType.typeCode;
    longTermDepositRequestData.sourceDepositNumber = selectedSourceDeposit!.depositNumber;
    longTermDepositRequestData.interestDepositNumber = selectedDestinationDeposit!.depositNumber;
    longTermDepositRequestData.branchCode = branchCode.toString();

    isLoading = true;
    update();

    DepositServices.openLongTermDeposit(
      longTermDepositRequestData: longTermDepositRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final LongTermDepositResponseData response, int _)):
          longTermDepositResponseData = response;
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

  void validateAmountValue(String value) {
    value.replaceAll(',', '');
    if (value.length > 3) {
      amountController.text = AppUtil.formatMoney(value);
      amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
    }
    if (value != '') {
      amount = int.parse(value.replaceAll(',', ''));
    } else {
      amount = 0;
    }
    update();
  }

  void _handleListOfDeposit(CustomerDepositsResponse response) {
    depositList = [];
    for (final deposit in response.data!.deposits!) {
      if (deposit.depositeKind != 3 && deposit.depositeKind != 4) {
        depositList.add(deposit);
      }
    }
    update();
  }

  String getAmountDetail() {
    if (amountController.text.isEmpty || amountController.text.length == 1) {
      return '';
    } else {
      final int amountInToman = amount ~/ 10;
      return DigitToWord.toWord(amountInToman.toString(), StrType.numWord, isMoney: true).replaceAll('  ', ' ');
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

  Future<void> showLongTermDepositAmountBottomSheet() async {
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
        child: const LongTermDepositAmountBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  Future<void> _showSelectDestinationDepositBottomSheet() async {
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
        child: const LongTermDepositDestinationSelectorBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  Future<void> _showLongTermDepositConfirmBottomSheet() async {
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
        child: const LongTermDepositConfirmBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void clearAmountTextField() {
    amountController.clear();
    amount = 0;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
