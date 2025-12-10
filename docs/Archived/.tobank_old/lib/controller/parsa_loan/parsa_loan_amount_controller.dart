import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/parsa_loan/loan_detail.dart';
import '../../model/bpms/parsa_loan/request/parsa_loan_submit_price_request_data.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_11_request_data.dart';
import '../../model/bpms/parsa_loan/response/parsa_lending_get_loan_detail_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/parsa_loan_services.dart';
import '../../ui/parsa_loan/parsa_loan_amount/widget/parsa_loan_select_amount_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ParsaLoanAmountController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = true;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  LoanDetail? loanDetail;

  int? installment;
  int? repayment;
  int? profit;
  ApproveLoan? approveLoan;

  int maxPrice = 500000000;
  int minPrice = 10000000;

  int? selectedCreditCardAmountData;
  int? tempSelectedCreditCardAmountData;
  double amountStep = 1000000;

  int selectBarValue = 0;

  int openBottomSheets = 0;

  final String trackingNumber;

  ParsaLoanAmountController({required this.trackingNumber});

  List<int> get selectingAmountList {
    final int minAmount = minPrice;
    final int maxAmount = maxPrice;
    final List<int> amountList = [];
    for (int i = minAmount; i < maxAmount; i += amountStep.round()) {
      amountList.add(i);
    }
    amountList.add(maxAmount);

    return amountList;
  }

  int roundToNearestFiveMillion(int num) {
    const int divisor = 5000000;
    return ((num + divisor / 2) ~/ divisor) * divisor;
  }

  @override
  void onInit() {
    getLoanDetailRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> getLoanDetailRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    ParsaLoanServices.getLoanDetailRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ParsaLendingGetLoanDetailResponseData response, int _)):
          loanDetail = response.data!.loanDetail!;
          update();
          _initiateAmountPageValues();
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

  void _initiateAmountPageValues() {
    selectedCreditCardAmountData = loanDetail!.extra!.maxPrice!;
    repayment = loanDetail!.extra!.maxPrice! + 300000;
    maxPrice = loanDetail!.extra!.maxPrice!;
    approveLoan = loanDetail!.extra!.approveLoan![0];
    calculateRepaymentAmount(requestedAmount: selectedCreditCardAmountData);
    update();
  }

  int getWarrantyAmount() {
    return roundToNearestHundred((1.3 * repayment!).round());
  }

  /// Rounding up to the nearest rounded number of 100,000 Tomans.
  int roundToNearestHundred(int number) {
    const int multiple = 1000000;
    return ((number + multiple - 1) ~/ multiple) * multiple;
    // return (number / 1000000).round() * 1000000;
  }

  void setSelectedAmountData(dynamic value) {
    selectedCreditCardAmountData = value.round();
    calculateRepaymentAmount(requestedAmount: selectedCreditCardAmountData);
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
    if (selectedCreditCardAmountData! < (maxPrice - amountStep)) {
      setSelectedAmountData(selectedCreditCardAmountData! + amountStep.round());
    } else {
      setSelectedAmountData(maxPrice);
    }
  }

  void stepDownAmount() {
    if (selectedCreditCardAmountData! > (minPrice + amountStep)) {
      setSelectedAmountData(selectedCreditCardAmountData! - amountStep.round());
    } else {
      setSelectedAmountData(minPrice);
    }
  }

  void setSelectedBar(int selectedBar) {
    selectBarValue = selectedBar;
    update();
  }

  void calculateRepaymentAmount({int? requestedAmount}) {
    repayment = calculateRepaymentFormula(requestedAmount!);
    installment = calculateInstallment(requestedAmount);
    update();
  }

  int calculateRepaymentFormula(int requestedAmount) {
    final int years = (approveLoan!.paybackPeriod! / 12).round();
    double sum = 0;
    for (int i = 0; i <= years - 1; i++) {
      sum += ((years - i) / years) * requestedAmount * approveLoan!.rate!;
    }
    return sum.round() + requestedAmount;
  }

  int calculateInstallment(int requestedAmount) {
    final int years = (approveLoan!.paybackPeriod! / 12).round();
    final int numberOfPayment = approveLoan!.paybackPeriod! - years;
    return (requestedAmount / numberOfPayment).round();
  }

  Future<void> showSelectAmountBottomSheet() async {
    if (isClosed) {
      return;
    }
    tempSelectedCreditCardAmountData = selectedCreditCardAmountData;
    openBottomSheets++;
    update();

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
        child: const ParsaLoanSelectAmountBottomSheet(),
      ),
    );
    openBottomSheets--;
    update();
  }

  void validateAmountPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (getWarrantyAmount() >= 20000000) {
      if (selectedCreditCardAmountData != null) {
        _submitParsaLoanPriceRequest();
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.amount_below_minimum_for_promissory_note ,
      );
    }
  }

  Future<void> _submitParsaLoanPriceRequest() async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final parsaLoanSubmitPriceRequestData = ParsaLoanSubmitPriceRequestData(
      price: selectedCreditCardAmountData,
    );

    ParsaLoanServices.submitParsaLoanPriceRequest(
      parsaLoanSubmitPriceRequestData: parsaLoanSubmitPriceRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          _taskComplete();
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

  Future<void> _taskComplete() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final taskCompleteState11RequestData = TaskCompleteState11RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'LoanRequestedAmount',
      taskData: [
        {
          'name': 'loanRequestedAmount',
          'value': selectedCreditCardAmountData.toString(),
        },
        {
          'name': 'loanRequestedAssuranceAmount',
          'value': getWarrantyAmount().toString(),
        }
      ],
    );

    ParsaLoanServices.parsaLendingState11CompleteTaskRequest(
      taskCompleteState11RequestData: taskCompleteState11RequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TaskCompleteResponseData response, int _)):
          AppUtil.handleParsaTask(taskList: response.data!.taskList, trackingNumber: trackingNumber);
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

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
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
}
