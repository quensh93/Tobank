import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:secure_plugin/secure_response_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/sign_document_data.dart';
import '../../model/deposit/request/customer_deposits_request_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/micro_lending/loan_detail.dart';
import '../../model/micro_lending/micro_lending_config.dart';
import '../../model/micro_lending/request/micro_lending_deposit_submit_request_data.dart';
import '../../model/micro_lending/request/micro_lending_fee_payment_request_data.dart';
import '../../model/micro_lending/request/micro_lending_price_submit_request_data.dart';
import '../../model/micro_lending/request/micro_lending_submit_contract_request_data.dart';
import '../../model/micro_lending/request/micro_loan_inquiry_cbs_request_data.dart';
import '../../model/micro_lending/response/micro_lending_check_deposit_response.dart';
import '../../model/micro_lending/response/micro_lending_check_sana_response.dart';
import '../../model/micro_lending/response/micro_lending_fee_internet_pay_data.dart';
import '../../model/micro_lending/response/micro_lending_get_current_step_response.dart';
import '../../model/micro_lending/response/micro_lending_get_deposits_response.dart';
import '../../model/micro_lending/response/micro_lending_get_loan_detail_response.dart';
import '../../model/micro_lending/response/micro_lending_submit_contract_response.dart';
import '../../model/micro_lending/response/micro_lending_submit_price_response.dart';
import '../../model/micro_lending/response/micro_loan_check_samat_cbs_response_data.dart';
import '../../model/other/response/other_item_data.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../model/wallet/response/wallet_balance_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../service/micro_lending_loan_services.dart';
import '../../service/other_services.dart';
import '../../service/transaction_services.dart';
import '../../service/wallet_services.dart';
import '../../ui/common/contract/contract_preview_screen.dart';
import '../../ui/common/key_value_widget.dart';
import '../../ui/common/select_deposit_payment_bottom_sheet.dart';
import '../../ui/micro_lending_loan/widget/micro_lending_confirmation_bottom_sheet.dart';
import '../../ui/micro_lending_loan/widget/micro_lending_credit_grade_inquiry_bottom_sheet.dart';
import '../../ui/micro_lending_loan/widget/micro_lending_loan_average_amount_bottom_sheet.dart';
import '../../ui/micro_lending_loan/widget/micro_lending_loan_credit_grade_inquiry_select_payment_bottom_sheet.dart';
import '../../ui/micro_lending_loan/widget/micro_lending_loan_select_amount_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/file_util.dart';
import '../../util/snack_bar_util.dart';
import '../../widget/svg/svg_icon.dart';
import '../facility/facility_controller.dart';
import '../main/main_controller.dart';

class MicroLendingLoanController extends GetxController {
  ScrollController scrollbarController = ScrollController();
  MainController mainController = Get.find();
  FacilityController facilityController = Get.find();

  bool isInBrowser = false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings webViewSettings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
    useShouldOverrideUrlLoading: false,
    cacheMode: CacheMode.LOAD_NO_CACHE,
    transparentBackground: true,
    supportZoom: false,
  );
  int progress = 0;

  MicroLendingConfig? config;
  LoanDetail? loanDetail;

  OtherItemData? otherItemData;
  OtherItemData? creditOtherItemData;

  bool isRuleChecked = false;
  bool isInquiryRuleChecked = false;

  bool isLoading = false;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  Deposit? selectedDeposit;
  List<Deposit> depositList = [];

  bool isCreditCardAmountValid = true;

  MicroLendingFeeInternetPayData? microLendingFeeInternetPayData;
  TransactionData? transactionData;

  int openBottomSheets = 0;

  int? installment;
  int? repayment;

  PaymentType currentPaymentType = PaymentType.wallet;

  var walletAmount = 0;

  Deposit? selectedPaymentDeposit;

  MicroLendingDurationOption? repaymentDuration;

  int? selectedCreditCardAmountData;
  int? tempSelectedCreditCardAmountData;
  double amountStep = 5000000;

  String? signedDocumentBase64;
  MicroLendingSubmitContractResponse? submitContractResponse;

  String? cbsRiskScore;

  String? orderId;

  String descriptionString = '';

  int cbsCounter = 30;

  Timer? timer;

  List<MicroLendingDurationOption> get repaymentDurationOptions {
    final List<MicroLendingDurationOption> options = [];
    options.addAll(loanDetail!.extra!.options!.where((element) => element.isActive!));
    return options;
  }

  List<int> get selectingAmountList {
    final int minAmount = loanDetail!.extra!.minPrice!;
    final int maxAmount = loanDetail!.extra!.maxPrice!;
    final int stepAmount = maxAmount - minAmount;
    final List<int> amountList = [];
    // min // min
    amountList.add(minAmount);

    // min + ((max - min) / 4) // 25%
    final step25 = minAmount + stepAmount / 4;
    amountList.add(roundToNearestFiveMillion(step25.round()));

    // min + ((max - min) / 2) // 50%
    final step50 = minAmount + stepAmount / 2;
    amountList.add(roundToNearestFiveMillion(step50.round()));

    // min + ((max - min) * 3 / 4) // 75%
    final step75 = minAmount + stepAmount * 3 / 4;
    amountList.add(roundToNearestFiveMillion(step75.round()));

    // max // max
    amountList.add(maxAmount);

    return amountList;
  }

  int roundToNearestFiveMillion(int num) {
    const int divisor = 5000000;
    return ((num + divisor / 2) ~/ divisor) * divisor;
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentStepRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void setProgress(int progress) {
    this.progress = progress;
    update();
  }

  String getConditionUrl() {
    return 'https://tobank.ir/app/tobank-micro-lending-loan-conditions';
  }

  /// Retrieves the current step in a micro-lending loan process.
  /// In case of an error, it displays an error message
  /// to the user using a SnackBar.
  Future<void> getCurrentStepRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    MicroLendingLoanServices.getCurrentStepRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final MicroLendingGetCurrentStepResponse response, int _)):
          config = response.data!.config;
          update();

          // to reset step comment _handleStep and uncomment _checkLoanAccessRequest
          _handleStep(step: response.data!.step);
        // _checkLoanAccessRequest();

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

  /// Handles navigation based on the current step in the loan process.
  ///
  /// This function determines the appropriate action to take based on the
  /// provided `step` value. it retrieves loan details and
  /// navigates to a corresponding page. If the step is null or unknown,
  /// it assumes that the user does not have an active loan.
  ///
  /// @param step The current step in the loan process.
  void _handleStep({required String? step}) {
    switch (step) {
      case 'CHECK_INQUIRY':
      case 'CHECK_CBS':
        getLoanDetailRequest(page: 8);
        break;
      case 'SUBMIT_PRICE':
        getLoanDetailRequest(page: 10);
        break;
      case 'SUBMIT_CONTRACT':
        getLoanDetailRequest(page: 11);
        break;
      case null:
      default:
        // User does not have active loan
        _checkLoanAccessRequest();
        break;
    }
  }

  /// Retrieves details for a micro-lending loan.
  ///
  /// This function fetches loan details from the server and updates the UI.
  /// If an error occurs, it displays an error message to the user.
  ///
  /// @param page The page to navigate to after successful retrieval of loan details.
  void getLoanDetailRequest({required int page}) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    MicroLendingLoanServices.getLoanDetailRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final MicroLendingGetLoanDetailResponse response, int _)):
          loanDetail = response.data!.loanDetail;
          config = response.data!.config;
          selectedCreditCardAmountData = loanDetail!.extra!.maxPrice!;
          update();
          AppUtil.gotoPageController(pageController: pageController, page: page, isClosed: isClosed);
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

  void validateFirstPage() {
    AppUtil.nextPageController(pageController, isClosed);
  }

  /// Checks the user's access to micro-lending loans.
  ///
  /// This function verifies if the user has permission to access
  /// micro-lending loans. If access is granted, it proceeds to retrieve
  /// loan rules. If access is denied or an error occurs, it displays an
  /// appropriate message to the user, either through a dialog or a SnackBar.
  Future<void> _checkLoanAccessRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    MicroLendingLoanServices.checkAccessRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          _getMicroLendingLoanRulesRequest();
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showAttentionDialogMessage(
              buildContext: Get.context!,
              description: apiException.displayMessage,
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
                Get.back();
              },
            );
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  Future<void> _getMicroLendingLoanRulesRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    OtherServices.getMicroLendingLoanRuleRequest().then((result) {
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
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setChecked(bool ruleChecked) {
    isRuleChecked = ruleChecked;
    update();
  }

  void validateRules() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isRuleChecked) {
      _getDepositsRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_read_and_accept_terms,
      );
    }
  }

  /// Retrieves a list of deposits for micro-lending.
  ///
  /// If an error occurs, it displays an
  /// appropriate message to the user, using a dialog for bad requests and a
  /// SnackBar for other errors
  void _getDepositsRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    MicroLendingLoanServices.getDepositsRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final MicroLendingGetDepositsResponse response, int _)):
          depositList.clear();
          depositList.addAll(response.data!.depositList!);
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showAttentionDialogMessage(
              buildContext: Get.context!,
              description: apiException.displayMessage,
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
                Get.back();
              },
            );
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  void setSelectedDeposit(Deposit deposit) {
    selectedDeposit = deposit;
    update();
  }

  void validateSelectDepositPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedDeposit != null) {
      _checkDepositRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_deposit,
      );
    }
  }

  /// Verifies a selected deposit for a micro-lending loan.
  ///
  /// If verification fails or an error occurs, it presents an appropriate message to the user
  /// dialog for bad requests, SnackBar for other errors.
  void _checkDepositRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final microLendingSubmitDepositRequest = MicroLendingSubmitDepositRequest(
      depositNumber: selectedDeposit!.depositNumber!,
    );

    MicroLendingLoanServices.checkDepositRequest(
      microLendingSubmitDepositRequest: microLendingSubmitDepositRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final MicroLendingCheckDepositResponse response, int _)):
          loanDetail = response.data!.loanDetail!;
          update();
          _showAverageAmountBottomSheet();
        case Failure(exception: final ApiException apiException):
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showAttentionDialogMessage(
              buildContext: Get.context!,
              description: apiException.displayMessage,
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
              },
            );
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  /// Performs a Sana check for a micro-lending loan.
  ///
  /// This function initiates a Sana check and updates the UI accordingly.
  /// If the check is successful, it retrieves loan details, navigates to
  /// the next page, and then fetches loan credit rules after a short delay.
  /// If the check fails or an error occurs, it displays an appropriate
  /// message to the user (dialog for bad requests, SnackBar for other errors).
  void checkSana() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    MicroLendingLoanServices.checkSanaRequest().then((result) {
      hasError = false;
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final MicroLendingCheckSanaResponse response, int _)):
          loanDetail = response.data!.loanDetail;
          update();
          AppUtil.nextPageController(pageController, isClosed);
          Future.delayed(Constants.duration200, () {
            getMicroLendingLoanCreditRulesRequest();
          });
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showAttentionDialogMessage(
              buildContext: Get.context!,
              description: apiException.displayMessage,
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
              },
            );
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  Future<void> getMicroLendingLoanCreditRulesRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    OtherServices.getMicroLendingLoanCreditRuleRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          creditOtherItemData = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode) ,
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _showAverageAmountBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const MicroLendingLoanAverageAmountBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void verifyAverageAmount() {
    _closeBottomSheets();
    AppUtil.nextPageController(pageController, isClosed);
    Future.delayed(Constants.duration200, () {
      checkSana();
    });
  }

  void setInquiryChecked(bool ruleChecked) {
    isInquiryRuleChecked = ruleChecked;
    update();
  }

  void validateInquiryRules() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isInquiryRuleChecked) {
      _showCreditGradeInquiryBottomSheet();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.read_and_accept_terms_conditions,
      );
    }
  }

  Future<void> _showCreditGradeInquiryBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const MicroLendingCreditGradeInquiryBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void confirmCreditGradeInquiryPayment() {
    _getWalletDetail();
  }

  Future<void> _getWalletDetail() async {
    final connectivityResult = await AppUtil.isNetworkConnect();
    if (connectivityResult) {
      _getWalletDetailRequest();
    } else {
      hasError = true;
      update();
      SnackBarUtil.showNoInternetSnackBar();
    }
  }

  /// Retrieves wallet details and displays payment options.
  ///
  /// This function fetches the user's wallet balance.
  /// If successful, it extracts the amount, determines valid payment types,
  /// and shows a bottom sheet for selecting a payment method for a credit
  /// grade inquiry. If an error occurs, it displays an error message to the user.
  Future<void> _getWalletDetailRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    WalletServices.getWalletBalance().then(
      (result) {
        hasError = true;
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final WalletBalanceResponseData response, int _)):
            walletAmount = response.data!.amount!;
            update();
            setValidPaymentType();
            _showCreditGradeInquirySelectPaymentBottomSheet();
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  void setValidPaymentType() {
    if (walletAmount < config!.price!) {
      setCurrentPaymentType(PaymentType.gateway);
    } else {
      setCurrentPaymentType(PaymentType.wallet);
    }
  }

  Future<void> _showCreditGradeInquirySelectPaymentBottomSheet() async {
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
        child: const MicroLendingLoanCreditGradeInquirySelectPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void setCurrentPaymentType(PaymentType paymentType) {
    currentPaymentType = paymentType;
    update();
  }

  void validatePaymentPage() {
    AppUtil.hideKeyboard(Get.context!);
    switch (currentPaymentType) {
      case PaymentType.wallet:
        if (walletAmount >= config!.price!) {
          _confirmPayment();
        } else {
          Timer(Constants.duration100, () {
            SnackBarUtil.showNotEnoughWalletMoneySnackBar();
          });
        }
      case PaymentType.gateway:
        _confirmPayment();
      case PaymentType.deposit:
        _getPaymentDepositsRequest();
    }
  }

  void _getPaymentDepositsRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final customerDepositsRequest = CustomerDepositsRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      trackingNumber: const Uuid().v4(),
    );

    DepositServices.getCustomerDeposits(customerDepositsRequest: customerDepositsRequest).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerDepositsResponse response, int _)):
          final filteredDeposits = response.data!.deposits!.where((deposit) => deposit.depositeKind != 3).toList();
          _showSelectDepositBottomSheet(depositList: filteredDeposits);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _showSelectDepositBottomSheet({required List<Deposit> depositList}) async {
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
        child: SelectDepositPaymentBottomSheet(
          depositList: depositList,
          selectDeposit: (Deposit deposit) {
            selectedPaymentDeposit = deposit;
            update();
            _confirmPayment();
          },
        ),
      ),
    );
    openBottomSheets--;
  }

  void _confirmPayment() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.confirm_credit_rating_fee_payment,
        description: '',
        positiveMessage: locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _paymentMethod();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  Future<void> _paymentMethod() async {
    switch (currentPaymentType) {
      case PaymentType.gateway:
        _creditGradeInternetPayment();
      case PaymentType.wallet:
      case PaymentType.deposit:
        _creditGradePayment();
    }
  }

  /// Processes a credit grade payment using the user's wallet or deposit.
  ///
  /// If an error occurs, it displays an error message to the user.
  void _creditGradePayment() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final microLendingFeePaymentRequest = MicroLendingFeePaymentRequest(
      transactionType: currentPaymentType,
      depositNumber: currentPaymentType == PaymentType.deposit ? selectedPaymentDeposit!.depositNumber! : null,
    );

    isLoading = true;
    update();
    MicroLendingLoanServices.feePaymentRequest(
      microLendingFeePaymentRequest: microLendingFeePaymentRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionData = response.data!;
          if (transactionData!.isSuccess == false) {
            SnackBarUtil.showSnackBar(
              title: locale.payment_error,
              message: transactionData?.message ?? locale.try_again2,
            );
          } else {
            _closeBottomSheets();
            AppUtil.gotoPageController(
              pageController: pageController,
              page: 8,
              isClosed: isClosed,
            );
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Processes a credit grade payment using internet.
  ///
  /// If an error occurs, it displays an error message to the user.
  void _creditGradeInternetPayment() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final microLendingFeePaymentRequest = MicroLendingFeePaymentRequest(
      transactionType: currentPaymentType,
      depositNumber: null,
    );

    isLoading = true;
    update();
    MicroLendingLoanServices.internetFeePaymentRequest(
      microLendingFeePaymentRequest: microLendingFeePaymentRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final MicroLendingFeeInternetPayData response, int _)):
          microLendingFeeInternetPayData = response;
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

  Future<void> validateInternetPayment() async {
    _requestTransactionDetailById();
  }

  /// Retrieves and verifies transaction details for a credit grade payment.
  void _requestTransactionDetailById() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: microLendingFeeInternetPayData!.data!.transactionId!,
    ).then(
      (result) async {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            transactionData = response.data;
            update();
            if (transactionData!.isSuccess == false) {
              _showCreditGradeInquirySelectPaymentBottomSheet();
              AppUtil.changePageController(
                pageController: pageController,
                page: 6,
                isClosed: isClosed,
              );
              SnackBarUtil.showSnackBar(
                title: locale.payment_error,
                message: transactionData?.message ?? locale.try_again2,
              );
            } else {
              AppUtil.changePageController(
                pageController: pageController,
                page: 8,
                isClosed: isClosed,
              );
            }
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  void checkSamatCbs() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    hasError = false;
    update();
    MicroLendingLoanServices.checkMicroLoanSamatCbs().then((result) {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final MicroLoanCheckSamatCbsResponseData response, int _)):
          loanDetail = response.data!.loanDetail!;
          update();
          setSelectedAmountData(response.data!.loanDetail!.extra!.maxPrice!);
          _handleCheckSamatCbsResponse(response);
          break;
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void inquiryCbs() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    final MicroLoanInquiryCbsRequestData microLoanInquiryCbsRequestData = MicroLoanInquiryCbsRequestData();
    microLoanInquiryCbsRequestData.orderId = orderId;
    MicroLendingLoanServices.inquiryMicroLoanCbs(microLoanInquiryCbsRequestData: microLoanInquiryCbsRequestData)
        .then((result) {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final MicroLoanCheckSamatCbsResponseData response, int _)):
          loanDetail = response.data!.loanDetail!;
          _handleInquiryCbsResponse(response);
          break;
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

  void setSelectedAmountData(dynamic value) {
    selectedCreditCardAmountData = value.round();
    calculateRepaymentAmount(selectedCreditCardAmountData, repaymentDuration?.monthNumber);
    update();
  }

  void setTempSelectedAmountData(dynamic value) {
    tempSelectedCreditCardAmountData = value.round();
    update();
  }

  void confirmSelectAmountBottomSheet() {
    setSelectedAmountData(tempSelectedCreditCardAmountData);
    _closeBottomSheets();
  }

  void stepUpAmount() {
    if (selectedCreditCardAmountData! < loanDetail!.extra!.maxPrice!) {
      setSelectedAmountData(selectedCreditCardAmountData! + amountStep.round());
    }
  }

  void stepDownAmount() {
    if (selectedCreditCardAmountData! > loanDetail!.extra!.minPrice!) {
      setSelectedAmountData(selectedCreditCardAmountData! - amountStep.round());
    }
  }

  void setRepaymentDuration(MicroLendingDurationOption value) {
    repaymentDuration = value;
    calculateRepaymentAmount(selectedCreditCardAmountData, repaymentDuration?.monthNumber);
    update();
  }

  void calculateRepaymentAmount(int? requestedAmount, int? repaymentMonths) {
    if (requestedAmount == null || repaymentMonths == null) {
      repayment = null;
      installment = null;
    } else {
      repayment = calculateRepaymentFormula(requestedAmount, repaymentMonths);
      installment = (repayment! / repaymentMonths).round();
      update();
    }
  }

  int calculateRepaymentFormula(int requestedAmount, int repaymentMonths) {
    final rate = 1 + (config!.loanRate! / 1200);
    final repayment = repaymentMonths *
        ((requestedAmount * pow(rate, repaymentMonths) * (config!.loanRate! / 1200)) / (pow(rate, repaymentMonths) - 1))
            .round();
    return repayment;
  }

  Future<void> showSelectAmountBottomSheet() async {
    if (isClosed) {
      return;
    }
    tempSelectedCreditCardAmountData = selectedCreditCardAmountData;
    update();
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
        child: const MicroLendingLoanSelectAmountBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void validateAmountPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (repaymentDuration != null) {
      submitAmountAndDurationRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_loan_repayment_period,
      );
    }
  }

  /// Submits the selected loan amount and repayment duration.
  ///
  /// If an error occurs, it displays an error message to the user.
  void submitAmountAndDurationRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final microLendingSubmitPriceAndDurationRequest = MicroLendingSubmitPriceAndDurationRequest(
      price: selectedCreditCardAmountData!,
      months: repaymentDuration!.monthNumber!,
    );

    MicroLendingLoanServices.submitPriceAndDurationRequest(
      microLendingSubmitPriceAndDurationRequest: microLendingSubmitPriceAndDurationRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final MicroLendingSubmitPriceAndDurationResponse response, int _)):
          loanDetail = response.data!.loanDetail!;
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

  Future<void> sharePdf() async {
    await FileUtil().shareContractPDF(
      bytes: base64Decode(loanDetail!.unsignedContract!).toList(),
      name: 'Micro lending loan',
    );
  }

  void showPreviewScreen() {
    Get.to(() => ContractPreviewScreen(
          pdfData: base64Decode(loanDetail!.unsignedContract!),
          templateName: 'Micro lending loan',
        ));
  }

  void showMultiSignedContractPreviewScreen() {
    Get.to(() => ContractPreviewScreen(
          pdfData: base64Decode(loanDetail!.multiSignedContract!),
          templateName: 'Micro lending loan',
        ));
  }

  Future<void> shareMultiSignedContractPdf() async {
    await FileUtil().shareContractPDF(
      bytes: base64Decode(loanDetail!.multiSignedContract!).toList(),
      name: 'Micro lending loan',
    );
  }

  void showConfirmationBottomSheet() {
    calculateRepaymentAmount(loanDetail?.requestedPrice, loanDetail?.months);
    _showConfirmationBottomSheet();
  }

  void _showConfirmationBottomSheet() {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? Get.context!.theme.colorScheme.surface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const MicroLendingConfirmationBottomSheet(),
      ),
    );
  }

  /// Electronically signs a loan document and submits the signed contract.
  ///
  /// If signing is successful, it submits the signed contract to the server.
  /// If signing fails, it displays an error message and logs the error using Sentry.
  Future<void> signDocument() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final SignDocumentData signDocumentData = SignDocumentData(
      documentBase64: loanDetail!.unsignedContract!,
      reason: 'Micro lending loan Request',
      signLocations: config!.signLocation!,
    );

    final SecureResponseData signResponse = await AppUtil.signPdf(signDocumentData: signDocumentData);

    if (signResponse.isSuccess != null && signResponse.isSuccess!) {
      signedDocumentBase64 = signResponse.data;
      update();
      _submitMicroLendingContractRequest();
    } else {
      isLoading = false;
      update();

      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: signResponse.message ?? locale.error_in_signature,
      );

      await Sentry.captureMessage('sign pdf error',
          params: [
            {'status code': signResponse.statusCode},
            {'message': signResponse.message},
          ],
          level: SentryLevel.warning);
    }
  }

  /// Submits a signed micro-lending contract to the server.
  void _submitMicroLendingContractRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final MicroLendingSubmitContractRequest microLendingSubmitContractRequest =
        MicroLendingSubmitContractRequest(signedContract: signedDocumentBase64!);

    isLoading = true;
    update();

    MicroLendingLoanServices.submitSignedContractRequest(
      microLendingSubmitContractRequest: microLendingSubmitContractRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final MicroLendingSubmitContractResponse response, int _)):
          submitContractResponse = response;
          loanDetail = response.data!.loanDetail!;
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

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 6) {
        AppUtil.gotoPageController(pageController: pageController, page: 3, isClosed: isClosed);
      } else {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      }
    }
  }

  void _handleCheckSamatCbsResponse(MicroLoanCheckSamatCbsResponseData response) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (response.data!.cbsStatusCode == null) {
      cbsRiskScore = response.data!.loanDetail!.extra!.cbsRiskScore;
      DialogUtil.showAttentionDialogMessage(
        buildContext: Get.context!,
        description:
            locale.turbo_loan_eligibility,
        keyValue: KeyValueWidget(keyString: locale.credit_rating, valueString: cbsRiskScore),
        positiveMessage: locale.continue_label,
        icon: SvgIcons.transactionSuccess,
        positiveFunction: () {
          Get.back();
          AppUtil.gotoPageController(pageController: pageController, page: 10, isClosed: isClosed);
        },
      );
    } else {
      if (response.data!.cbsStatusCode == 102) {
        descriptionString = locale.status_recive_report_message;
      } else {
        descriptionString = locale.default_status_message;
      }
      orderId = response.data!.orderId;
      _startTimer();
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void _handleInquiryCbsResponse(MicroLoanCheckSamatCbsResponseData response) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (response.data!.cbsStatusCode == null) {
      cbsRiskScore = response.data!.loanDetail!.extra!.cbsRiskScore;
      DialogUtil.showAttentionDialogMessage(
        buildContext: Get.context!,
        description:
            locale.turbo_loan_eligibility,
        keyValue: KeyValueWidget(keyString: locale.credit_rating, valueString: cbsRiskScore),
        positiveMessage: locale.continue_label,
        icon: SvgIcons.transactionSuccess,
        positiveFunction: () {
          Get.back();
          AppUtil.nextPageController(pageController, isClosed);
        },
      );
    } else {
      DialogUtil.showAttentionDialogMessage(
        buildContext: Get.context!,
        description: locale.credit_report_retry_time,
        positiveMessage: locale.understood_button,
        positiveFunction: () {
          Get.back();
          Get.back();
        },
      );
    }
  }

  String getTimer() {
    final DateTime time = DateTime(2024);
    final timer = intl.DateFormat('mm:ss').format(time.add(Duration(seconds: cbsCounter)));
    return timer;
  }

  void _startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (cbsCounter < 1) {
        inquiryCbs();
        timer.cancel();
      } else {
        cbsCounter = cbsCounter - 1;
      }
      update();
    });
  }
}
