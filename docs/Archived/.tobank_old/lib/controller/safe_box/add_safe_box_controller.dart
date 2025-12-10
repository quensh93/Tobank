import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/other/response/other_item_data.dart';
import '../../model/safe_box/request/submit_safe_box_request_data.dart';
import '../../model/safe_box/response/branch_list_response_data.dart';
import '../../model/safe_box/response/refer_date_time_list_response_data.dart';
import '../../model/safe_box/response/safe_box_city_list_response_data.dart';
import '../../model/safe_box/response/safe_box_internet_pay_data.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../model/wallet/response/wallet_balance_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/other_services.dart';
import '../../service/safe_box_services.dart';
import '../../service/transaction_services.dart';
import '../../service/wallet_services.dart';
import '../../ui/safe_box/add_safe_box/widget/add_safe_box_confirm_bottom_sheet.dart';
import '../../ui/safe_box/add_safe_box/widget/add_safe_box_select_date_bottom_sheet.dart';
import '../../ui/safe_box/add_safe_box/widget/select_payment_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class AddSafeBoxController extends GetxController {
  PageController pageController = PageController();
  MainController mainController = Get.find();
  String? errorTitle = '';

  bool hasError = false;

  bool isLoading = false;

  ScrollController scrollbarController = ScrollController();

  bool isChecked = false;

  OtherItemData? otherItemData;

  List<BranchResult>? allBranchResultList = [];
  List<BranchResult>? branchResultList = [];

  BranchResult? selectedBranchResult;
  Fund? selectedFund;

  PaymentType currentPaymentType = PaymentType.wallet;

  int walletAmount = 0;

  ReferDateTimeListResponseData? referDateTimeListResponseData;

  int? selectedDate;
  List<Time> times = [];

  int? selectedTime;

  TransactionData? transactionData;
  SafeBoxInternetPayData? safeBoxInternetPayData;

  SafeBoxCityListResponseData? safeBoxCityListResponseData;
  SafeBoxCityData? selectedSafeBoxCityData;

  TextEditingController searchTextController = TextEditingController();

  int openBottomSheets = 0;

  @override
  void onInit() {
    getSafeBoxRulesRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves the rules for the safe box and handles the response.
  void getSafeBoxRulesRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    OtherServices.getSafeBoxRuleRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
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

  void setChecked(bool check) {
    isChecked = check;
    update();
  }

  void searchBranch(String searchText) {
    searchText = AppUtil.getEnglishNumbers(searchText);
    branchResultList = allBranchResultList!.where((element) => element.toSearch().contains(searchText)).toList();
    selectedSafeBoxCityData = safeBoxCityListResponseData!.data![0];
    update();
  }

  void validateFirstPage() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isChecked) {
      _getBranchesRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_read_and_accept_terms,
      );
    }
  }

  /// Retrieves the list of branches and handles the response.
  void _getBranchesRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    SafeBoxServices.getBranchListRequest().then((result) {
      switch (result) {
        case Success(value: (final BranchListResponseData response, int _)):
          branchResultList = response.data!.results;
          allBranchResultList = response.data!.results;
          update();
          _getCityList();
        case Failure(exception: final ApiException apiException):
          isLoading = false;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves the list of cities and handles the response.
  void _getCityList() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    SafeBoxServices.getCityListRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final SafeBoxCityListResponseData response, int _)):
          safeBoxCityListResponseData = response;
          handleSafeBoxCityList();
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          isLoading = false;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void validateSecondPage() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedBranchResult != null) {
      AppUtil.nextPageController(pageController, isClosed);
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_branch,
      );
    }
  }

  void setSelectedBranch(BranchResult branchResult) {
    selectedBranchResult = branchResult;
    update();
  }

  String getSelectedBranchData() {
    return '${selectedBranchResult!.city!.name!} - ${selectedBranchResult!.title!} ${selectedBranchResult!.code!.toString()}';
  }

  void setSelectedFund(Fund fund) {
    selectedFund = fund;
    update();
  }

  void validateThirdPage() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedFund != null) {
      _getListOfReferDateTimeRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_box,
      );
    }
  }

  void setCurrentPaymentType(PaymentType paymentType) {
    currentPaymentType = paymentType;
    update();
  }

  /// Retrieves the list of referral date and time options and handles the response.
  void _getListOfReferDateTimeRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    SafeBoxServices.getReferDateTimeRequest(
      branchId: selectedBranchResult!.id!,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ReferDateTimeListResponseData response, int _)):
          referDateTimeListResponseData = response;
          update();
          _showAddSafeBoxSelectDateBottomSheet();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void selectDate(int index) {
    selectedDate = index;
    times = referDateTimeListResponseData!.data![index].times ?? [];
    update();
  }

  void selectTime(int index) {
    selectedTime = index;
    update();
  }

  void validateSelectedDate() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedTime != null && selectedDate != null) {
      _showConfirmBottomSheet();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_visit_datetime,
      );
    }
  }

  /// Retrieves the user's wallet balance and handles the response.
  Future<void> getWalletDetailRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    WalletServices.getWalletBalance().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final WalletBalanceResponseData response, int _)):
            walletAmount = response.data!.amount!;
            setValidPaymentType();
            update();
            _showPaymentBottomSheet();
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  void validatePaymentPage() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.sure_of_payment,
        description: locale.safe_box_payment_description,
        positiveMessage: locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          validateAmount();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  void validateAmount() {
    if (currentPaymentType == PaymentType.wallet) {
      if (walletAmount >= selectedFund!.paymentAmount!) {
        validatePaymentMethod();
      } else {
        Timer(Constants.duration100, () {
          SnackBarUtil.showNotEnoughWalletMoneySnackBar();
        });
      }
    } else {
      validatePaymentMethod();
    }
  }

  void validatePaymentMethod() {
    final SubmitSafeBoxRequestData submitSafeBoxRequestData = SubmitSafeBoxRequestData();
    submitSafeBoxRequestData.fundId = selectedFund!.id;
    submitSafeBoxRequestData.referTimeId = selectedTime;
    if (currentPaymentType == PaymentType.wallet) {
      submitSafeBoxRequestData.wallet = 1;
      _paySafeBoxWalletRequest(submitSafeBoxRequestData);
    } else {
      submitSafeBoxRequestData.wallet = 0;
      _paySafeBoxInternetRequest(submitSafeBoxRequestData);
    }
  }

  /// Processes the safe box payment using the user's wallet.
  void _paySafeBoxWalletRequest(SubmitSafeBoxRequestData submitSafeBoxRequestData) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    SafeBoxServices.safeBoxWalletPayment(
      submitSafeBoxRequestData: submitSafeBoxRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionData = response.data;
          update();
          _closeBottomSheets();
          AppUtil.changePageController(pageController: pageController, page: 5, isClosed: isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> validateInternetPayment() async {
    _transactionDetailByIdRequest();
  }

  /// Retrieves the details of a transaction by its ID.
  void _transactionDetailByIdRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: safeBoxInternetPayData!.data!.transactionId!,
    ).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            transactionData = response.data;
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

  /// Processes the safe box payment using internet banking.
  void _paySafeBoxInternetRequest(SubmitSafeBoxRequestData submitSafeBoxRequestData) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    SafeBoxServices.safeBoxInternetPayment(
      submitSafeBoxRequestData: submitSafeBoxRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final SafeBoxInternetPayData response, int _)):
          safeBoxInternetPayData = response;
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

  void handleSafeBoxCityList() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final SafeBoxCityData safeBoxCityData = SafeBoxCityData();
    safeBoxCityData.id = -1;
    safeBoxCityData.name = locale.all;
    safeBoxCityListResponseData!.data!.insert(0, safeBoxCityData);
    selectedSafeBoxCityData = safeBoxCityData;
    update();
  }

  void setSelectedSafeBoxCityData(SafeBoxCityData safeBoxCityData) {
    if (safeBoxCityData.id != selectedSafeBoxCityData!.id) {
      searchTextController.text = '';
      selectedSafeBoxCityData = safeBoxCityData;
      selectedBranchResult = null;
      if (safeBoxCityData.id != -1) {
        branchResultList = allBranchResultList!.where((element) => element.city!.id == safeBoxCityData.id).toList();
      } else {
        branchResultList = allBranchResultList;
      }
      update();
    }
  }

  /// Handles back press actions within the current context.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 ||
          pageController.page == 1 ||
          pageController.page == 4 ||
          pageController.page == 5) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  void setValidPaymentType() {
    final int? correctAmount = selectedFund!.paymentAmount;
    if (walletAmount < correctAmount!) {
      setCurrentPaymentType(PaymentType.gateway);
    } else {
      setCurrentPaymentType(PaymentType.wallet);
    }
  }

  Future<void> _showAddSafeBoxSelectDateBottomSheet() async {
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
        child: const AddSafeBoxSelectDateBottomSheet(),
      ),
    );
    selectedDate = null;
    selectedTime = null;
    times = [];
    openBottomSheets--;
  }

  Future<void> _showPaymentBottomSheet() async {
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
        child: const SelectPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  void clearSearchTextField() {
    searchTextController.clear();
    searchBranch('');
  }

  Future<void> _showConfirmBottomSheet() async {
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
        child: const AddSafeBoxConfirmBottomSheet(),
      ),
    );
    openBottomSheets--;
  }
}
