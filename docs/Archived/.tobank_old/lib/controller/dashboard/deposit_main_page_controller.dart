import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/banner_ids_data.dart';
import '../../model/common/menu_data.dart';
import '../../model/common/menu_data_model.dart';
import '../../model/deposit/request/customer_deposits_request_data.dart';
import '../../model/deposit/request/deposit_balance_request_data.dart';
import '../../model/deposit/request/deposit_statement_request_data.dart';
import '../../model/deposit/request/deposit_type_request_data.dart';
import '../../model/deposit/request/increase_deposit_balance_request_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/deposit/response/deposit_balance_response_data.dart';
import '../../model/deposit/response/deposit_statement_response_data.dart';
import '../../model/deposit/response/deposit_type_response_data.dart';
import '../../model/deposit/response/increase_deposit_balance_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../ui/bpms/card_physical_issue/card_physical_issue_start/card_physical_issue_start_screen.dart';
import '../../ui/bpms/close_deposit/close_deposit_screen.dart';
import '../../ui/customer_club/customer_club_screen.dart';
import '../../ui/dashboard_screen/widget/add_deposit_amount_bottom_sheet.dart';
import '../../ui/dashboard_screen/widget/create_deposit_widget.dart';
import '../../ui/dashboard_screen/widget/deposit_item_widget.dart';
import '../../ui/dashboard_screen/widget/deposit_services_bottom_sheet.dart';
import '../../ui/dashboard_screen/widget/deposit_transaction_bottom_sheet.dart';
import '../../ui/dashboard_screen/widget/select_deposit_type_bottom_sheet.dart';
import '../../ui/dashboard_screen/widget/share_deposit_bottom_sheet.dart';
import '../../ui/deposit/deposit_charge_balance/deposit_charge_balance_screen.dart';
import '../../ui/deposit/deposit_transaction/deposit_transaction_screen.dart';
import '../../ui/deposit/transfer_amount/transfer_amount_screen.dart';
import '../../ui/open_deposit/open_deposit_screen.dart';
import '../../ui/open_long_term_deposit/open_long_term_deposit_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/digit_to_word.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';
import 'card_main_page_controller.dart';

class DepositMainPageController extends GetxController {
  final String eventName = 'vb_dashboard_click_event';
  MainController mainController = Get.find();
  PageController pageController = PageController();
  List<Deposit> depositList = [];
  bool isLoading = false;

  String? errorTitle = '';

  bool hasError = false;

  int selectedDepositIndex = 0;

  Map<String, bool> depositBalanceLoadingMap = {};

  int depositWidgetListCount = 0;

  TextEditingController dateFromController = TextEditingController();

  TextEditingController dateToController = TextEditingController();

  late JalaliRange selectedDateRange;

  int openBottomSheets = 0;

  bool isDepositTransactionLoading = false;

  DepositTypeResponseData? depositTypeResponseData;

  bool isDepositTypeLoading = false;

  TextEditingController depositAmountController = TextEditingController();

  bool depositAmountValid = true;

  int amount = 0;

  BannerIdsData? bannerIdsData;

  List<List<Deposit>> depositChunkList = [];
  int chunkIndex = 0;
  final int chunkSize = 3;

  DepositTransactionFilterType? selectedDepositTransactionFilter;

  bool isChargeDepositBalanceLoading = false;

  @override
  void onInit() {
    selectedDateRange = JalaliRange(
      start: Jalali.now().addDays(-30),
      end: Jalali.now(),
    );
    getDepositListRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves the customer's deposit list from the server.
  void getDepositListRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CustomerDepositsRequest customerDepositsRequest = CustomerDepositsRequest(
      customerNumber: mainController.authInfoData!.customerNumber ?? '',
      trackingNumber: const Uuid().v4(),
    );
    hasError = false;
    isLoading = true;
    update();

    DepositServices.getCustomerDeposits(
      customerDepositsRequest: customerDepositsRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerDepositsResponse response, int _)):
          depositList = response.data!.deposits!;
          update();
          if (depositList.isNotEmpty) {
            _initDepositChunkList();
          }
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Navigates to the deposit transfer screen if the deposit type allows it.
  Future<void> goToTransferDepositScreen(Deposit deposit) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (deposit.depositeKind != 3) {
      if (isLoading == false && hasError == false) {
        await Get.to(() => DepositAmountScreen(
              deposit: deposit,
            ));
        _getDepositBalanceRequest(deposit, false);
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.transfer_not_allowed_for_deposit_type,
      );
    }
  }

  void setSelectedDepositIndex(int page) {
    selectedDepositIndex = page;
    update();
    if (page < depositList.length) {
      final Deposit deposit = depositList[page];
      if (page == chunkIndex &&
          deposit.balance == null &&
          !(depositBalanceLoadingMap[deposit.depositNumber] ?? false)) {
        _getDepositBalanceAutomatic();
      }
    }
  }

  /// Initializes the deposit chunk list by dividing the deposit list into smaller chunks.
  void _initDepositChunkList() {
    for (int i = 0; i < depositList.length; i += chunkSize) {
      final int end = (i + chunkSize < depositList.length) ? i + chunkSize : depositList.length;
      depositChunkList.add(depositList.sublist(i, end));
    }
    _getDepositBalanceAutomatic();
  }

  /// Retrieves the deposit balances for a chunk of deposits automatically.
  void _getDepositBalanceAutomatic() {
    final List<Deposit> list = depositChunkList[chunkIndex ~/ chunkSize];
    for (final deposit in list) {
      _getDepositBalanceRequest(deposit, true);
    }
    chunkIndex += chunkSize;
  }

  /// Sends a request to get the deposit balance for a specific card and updates the UI.
  void _getDepositBalanceRequest(Deposit deposit, bool isAuto) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DepositBalanceRequestData depositBalanceRequestData = DepositBalanceRequestData();
    depositBalanceRequestData.trackingNumber = const Uuid().v4();
    depositBalanceRequestData.depositNumber = deposit.depositNumber;
    depositBalanceRequestData.customerNumber = mainController.authInfoData!.customerNumber!;

    depositBalanceLoadingMap[deposit.depositNumber!] = true;
    update();

    DepositServices.getDepositBalanceRequest(
      depositBalanceRequestData: depositBalanceRequestData,
    ).then((result) {
      depositBalanceLoadingMap[deposit.depositNumber!] = false;
      update();

      switch (result) {
        case Success(value: (final DepositBalanceResponseData response, int _)):
          deposit.balance = response.data?.balance;
          update();
        case Failure(exception: final ApiException apiException):
          if (!isAuto) {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  void copyIban(Deposit deposit) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Clipboard.setData(ClipboardData(text: deposit.depositIban ?? ''));
    SnackBarUtil.showInfoSnackBar(locale.shaba_number_copied);
  }

  void copyDeposit(Deposit deposit) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Clipboard.setData(ClipboardData(text: deposit.depositNumber ?? ''));
    SnackBarUtil.showInfoSnackBar(locale.shaba_number_copied);
  }

  /// Creates a list of widgets to display deposit information.
  List<Widget> depositListWidget() {
    depositWidgetListCount = 0;
    final List<Widget> list = [];
    for (final item in depositList) {
      list.add(
        DepositItemWidget(
          deposit: item,
          activateIncreaseDepositBalance: mainController.activateIncreaseDepositBalance,
          transferFunction: (deposit) {
            goToTransferDepositScreen(deposit);
          },
          transactionFunction: (deposit) {
            _showDepositTransactionBottomSheet(deposit);
          },
          balanceFunction: (deposit) {
            _getDepositBalanceRequest(deposit, false);
          },
          depositBalanceLoading: depositBalanceLoadingMap[item.depositNumber!],
          moreFunction: (deposit) {
            _showDepositMoreBottomSheet(deposit);
          },
          addAmountFunction: (deposit) {
            _showAddAmountBottomSheet(deposit);
          },
          balanceVisibilityFunction: (deposit, bool isHide) {
            _balanceVisibility(deposit, isHide);
          },
        ),
      );
    }
    list.add(
      const CreateDepositWidget(),
    );
    depositWidgetListCount = list.length;
    return list;
  }

  Future<void> dateRangePicker() async {
    selectedDateRange = JalaliRange(
      start: Jalali.now().addDays(-30),
      end: Jalali.now(),
    );
    final picked = await showPersianDateRangePicker(
      context: Get.context!,
      initialDateRange: selectedDateRange,
      firstDate: Jalali(1398, 10),
      lastDate: Jalali.now(),
      fontFamily: 'IranYekan',
      showEntryModeIcon: false,
    );
    if (picked != null) {
      selectedDateRange = picked;
      dateFromController.text = picked.start.formatCompactDate();
      dateToController.text = picked.end.formatCompactDate();
    }
  }

  Future<void> _showDepositTransactionBottomSheet(Deposit deposit) async {
    if (isClosed) {
      return;
    }
    dateFromController.text = '';
    dateToController.text = '';
    selectedDepositTransactionFilter = null;
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
        child: DepositTransactionBottomSheet(deposit: deposit),
      ),
    );
    openBottomSheets--;
  }

  /// Retrieves deposit transactions based on selected filters.
  Future<void> getDepositTransaction(Deposit deposit) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedDepositTransactionFilter != null) {
      if (selectedDepositTransactionFilter == DepositTransactionFilterType.byTime) {
        if (dateFromController.text.isEmpty || dateToController.text.isEmpty) {
          SnackBarUtil.showInfoSnackBar(
            locale.select_date_warning,
          );
          return;
        }
      }
      _depositTransactionRequest(1, deposit);
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_option_warning,
      );
    }
  }

  /// Retrieves deposit transaction statements from the server.
  Future _depositTransactionRequest(int page, Deposit deposit) async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DepositStatementRequestData depositStatementRequestData = DepositStatementRequestData();
    depositStatementRequestData.trackingNumber = const Uuid().v4();
    depositStatementRequestData.depositNumber = deposit.depositNumber;
    depositStatementRequestData.customerNumber = mainController.authInfoData!.customerNumber!;
    depositStatementRequestData.pageNumber = 1;
    depositStatementRequestData.pageSize = 10;
    if (selectedDepositTransactionFilter == DepositTransactionFilterType.byTime) {
      depositStatementRequestData.fromDate = dateFromController.text;
      depositStatementRequestData.toDate = dateToController.text;
    } else {
      depositStatementRequestData.fromDate = Jalali.now().addYears(-1).formatCompactDate();
      depositStatementRequestData.toDate = Jalali.now().formatCompactDate();
    }

    isDepositTransactionLoading = true;
    update();

    DepositServices.getDepositStatementRequest(
      depositStatementRequestData: depositStatementRequestData,
    ).then((result) {
      isDepositTransactionLoading = false;
      update();

      switch (result) {
        case Success(value: (final DepositStatementResponseData response, int _)):
          closeBottomSheets();
          Get.to(() => DepositTransactionScreen(
              deposit: deposit,
              turnOvers: response.data!.turnOvers ?? [],
              selectedDateRange: selectedDateRange,
              depositTransactionFilterType: selectedDepositTransactionFilter!));
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  Future<void> showCustomerClubScreen() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (mainController.menuDataModel.customerClub!.isDisable == false) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'CustomerClubMenuScreen'});
      Get.to(() => const CustomerClubScreen());
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.announcement,
        message: mainController.menuDataModel.customerClub!.message ?? locale.selected_service_unavailable,
      );
    }
  }

  Future<void> _showDepositMoreBottomSheet(Deposit deposit) async {
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
        child: DepositServicesBottomSheet(deposit: deposit),
      ),
    );
    openBottomSheets--;
  }

  Future<void> handleCardServiceItemClick(MenuData virtualBranchMenuData, Deposit deposit) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (virtualBranchMenuData.id == 1) {
      _showRequestCardScreen(deposit);
    } else if (virtualBranchMenuData.id == 2) {
      _closeBottomSheets();
      await Get.to(() => CloseDepositScreen(
            deposit: deposit,
          ));
      Timer(Constants.duration500, () {
        getDepositListRequest();
      });
    } else if (virtualBranchMenuData.id == 3) {
      _showShareBottomSheet(deposit);
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.service_unavailable,
      );
    }
  }

  Future<void> _showRequestCardScreen(Deposit deposit) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    _closeBottomSheets();
    if (deposit.depositeKind == 3 || deposit.depositeKind == 4) {
      SnackBarUtil.showInfoSnackBar(
        locale.card_issue_not_allowed,
      );
    } else {
      await Get.to(() => CardPhysicalIssueStartScreen(depositNumber: deposit.depositNumber!));
      Timer(Constants.duration500, () {
        getDepositListRequest();
      });
      try {
        if (mainController.isCardMainPageControllerInit) {
          final CardMainPageController cardMainPageController = Get.find();
          cardMainPageController.getCustomerCardRequest();
        }
      } on Exception catch (_) {}
    }
  }

  Future<void> _showShareBottomSheet(Deposit deposit) async {
    _closeBottomSheets();
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
        child: ShareDepositBottomSheet(deposit: deposit),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  /// Retrieves the available deposit types from the server.
  void getDepositTypeRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DepositTypeRequestData depositTypeRequestData = DepositTypeRequestData();
    depositTypeRequestData.customerNumber = mainController.authInfoData!.customerNumber!;
    depositTypeRequestData.trackingNumber = const Uuid().v4();

    isDepositTypeLoading = true;
    update();

    DepositServices.getDepositTypesRequest(
      depositTypeRequestData: depositTypeRequestData,
    ).then((result) {
      isDepositTypeLoading = false;
      update();

      switch (result) {
        case Success(value: (final DepositTypeResponseData response, int _)):
          depositTypeResponseData = response;
          update();
          _showDepositTypeBottomSheet();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _showDepositTypeBottomSheet() async {
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
        child: const SelectDepositTypeBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void validateSelectedDepositType(DepositType selectedDepositType) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedDepositType.remainingInstances! <= 0) {
      SnackBarUtil.showInfoSnackBar(
        locale.deposit_already_created,
      );
    } else {
      _closeBottomSheets();
      if (selectedDepositType.generalType == 3) {
        _showOpenLongTermDepositScreen(
            selectedDepositType: selectedDepositType, branchCode: depositTypeResponseData!.branchCode);
      } else {
        _showOpenDepositScreen(
            selectedDepositType: selectedDepositType, branchCode: depositTypeResponseData!.branchCode);
      }
    }
  }

  Future<void> _showOpenDepositScreen({required DepositType selectedDepositType, int? branchCode}) async {
    mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'open_deposit'});
    await Get.to(() => OpenDepositScreen(
          selectedDepositType: selectedDepositType,
          branchCode: branchCode,
        ));
    Timer(Constants.duration500, () {
      getDepositListRequest();
    });
    try {
      if (mainController.isCardMainPageControllerInit) {
        final CardMainPageController cardMainPageController = Get.find();
        cardMainPageController.getCustomerCardRequest();
      }
    } on Exception catch (_) {}
  }

  Future<void> _showOpenLongTermDepositScreen({required DepositType selectedDepositType, int? branchCode}) async {
    mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'open_long_term_deposit'});
    await Get.to(() => OpenLongTermDepositScreen(
          selectedDepositType: selectedDepositType,
          branchCode: branchCode,
        ));
    Timer(Constants.duration500, () {
      getDepositListRequest();
    });
  }

  Future<void> _showAddAmountBottomSheet(Deposit deposit) async {
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
        child: AddDepositAmountBottomSheet(deposit: deposit),
      ),
    );
    openBottomSheets--;
  }

  void addDepositAmountValidate({required Deposit deposit}) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (amount < 10000) {
      SnackBarUtil.showInfoSnackBar(
        locale.invalid_amount_error,
      );
    } else {
      _increaseDepositBalanceRequest(deposit: deposit);
    }
  }

  /// Sends a request to increase the balance of a deposit.
  void _increaseDepositBalanceRequest({required Deposit deposit}) { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final increaseDepositBalanceRequestData = IncreaseDepositBalanceRequestData(
      amount: amount,
      depositNumber: deposit.depositNumber!,
    );

    isChargeDepositBalanceLoading = true;
    update();

    DepositServices.increaseDepositBalance(
      increaseDepositBalanceRequestData: increaseDepositBalanceRequestData,
    ).then((result) async {
      isChargeDepositBalanceLoading = false;
      update();

      switch (result) {
        case Success(value: (final IncreaseDepositBalanceResponseData response, int _)):
          closeBottomSheets();
          await Get.to(() => DepositChargeBalanceScreen(
                increaseDepositBalanceResponseData: response,
                chargeAmount: amount,
              ));
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
      depositAmountController.text = AppUtil.formatMoney(value);
      depositAmountController.selection =
          TextSelection.fromPosition(TextPosition(offset: depositAmountController.text.length));
    }
    if (value != '') {
      amount = int.parse(value.replaceAll(',', ''));
    } else {
      amount = 0;
    }
    update();
  }

  String getAmountDetail() {
    if (depositAmountController.text.isEmpty || depositAmountController.text.length == 1) {
      return '';
    } else {
      final int amountInToman = amount ~/ 10;
      return DigitToWord.toWord(amountInToman.toString(), StrType.numWord, isMoney: true).replaceAll('  ', ' ');
    }
  }

  void shareText(String text) {
    Share.share(text, subject: '');
  }

  void copyText(String text) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Clipboard.setData(ClipboardData(text: text));
    SnackBarUtil.showInfoSnackBar(locale.copied_to_clipboard);
  }

  void clearAmountTextField() {
    depositAmountController.clear();
    amount = 0;
    update();
  }

  void handleBannerClick(BannerItem bannerItem) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (bannerItem.isDisable == true) {
      SnackBarUtil.showSnackBar(
        title: locale.announcement,
        message: bannerItem.message!,
      );
    } else {
      if (bannerItem.type == 'url') {
        AppUtil.launchInBrowser(url: bannerItem.url!);
      }
    }
  }

  void setSelectedDepositTransactionFilter(DepositTransactionFilterType? value) {
    selectedDepositTransactionFilter = value!;
    update();
    if ((selectedDepositTransactionFilter == DepositTransactionFilterType.byTime) &&
        (dateToController.text.isEmpty || dateFromController.text.isEmpty)) {
      dateRangePicker();
    }
  }

  void _balanceVisibility(Deposit deposit, bool isHide) {
    deposit.isHideBalance = isHide;
    update();
  }

  String getClubPoint() {
    if (mainController.walletDetailData!.data!.havadary == true) {
      return mainController.walletDetailData!.data!.customerClub!.point.toString();
    } else {
      return '۰';
    }
  }
}
