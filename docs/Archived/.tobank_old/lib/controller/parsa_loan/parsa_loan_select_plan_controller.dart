import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/parsa_loan/averaging_period_filter_data.dart';
import '../../model/bpms/parsa_loan/loan_detail.dart';
import '../../model/bpms/parsa_loan/request/parsa_loan_submit_plan_request_data.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_5_request_data.dart';
import '../../model/bpms/parsa_loan/response/parsa_lending_get_loan_detail_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/parsa_loan_services.dart';
import '../../ui/parsa_loan/parsa_loan_select_plan/widget/parsa_loan_filter_plan_bottom_sheet.dart';
import '../../ui/parsa_loan/parsa_loan_select_plan/widget/parsa_loan_select_month_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ParsaLoanSelectPlanController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = true;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  LoanDetail? loanDetail;

  AveragingPeriodFilterData? selectedAveragingPeriodFilterData;
  int? selectedParsaLoanPlanIndex;
  DepositAverageAmountMonth? selectedParsaLoanPlan;
  List<DepositAverageAmountMonth> parsaPlanList = [];
  List<DepositAverageAmountMonth> allParsaPlanList = [];

  List<DepositAverageAmountMonth> planList2Month = [];
  List<DepositAverageAmountMonth> planList3Month = [];
  List<DepositAverageAmountMonth> planList4Month = [];
  List<DepositAverageAmountMonth> planList5Month = [];
  List<DepositAverageAmountMonth> planList6Month = [];
  List<DepositAverageAmountMonth> planList7Month = [];
  List<DepositAverageAmountMonth> planList8Month = [];
  List<DepositAverageAmountMonth> planList9Month = [];
  List<DepositAverageAmountMonth> planList10Month = [];
  List<DepositAverageAmountMonth> planList11Month = [];
  List<DepositAverageAmountMonth> planList12Month = [];

  int? tempSelectedWageCostFilterData;
  int? tempSelectedRepaymentDurationFilterData;
  int? selectedWageCostFilterData;
  int? selectedRepaymentDurationFilterData;

  int? selectedCreditCardAmountData;
  int? tempSelectedCreditCardAmountData;

  int openBottomSheets = 0;

  final String trackingNumber;

  TextEditingController monthController = TextEditingController();

  List<AveragingPeriodFilterData> averagingPeriodFilterDataList = [];

  ParsaLoanSelectPlanController({required this.trackingNumber});

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
          _handleResponse(response);
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

  void _handleResponse(ParsaLendingGetLoanDetailResponseData response) {
    loanDetail = response.data!.loanDetail!;
    planList2Month = loanDetail!.extra!.depositAverageAmount2Months ?? [];
    planList3Month = loanDetail!.extra!.depositAverageAmount3Months ?? [];
    planList4Month = loanDetail!.extra!.depositAverageAmount4Months ?? [];
    planList5Month = loanDetail!.extra!.depositAverageAmount5Months ?? [];
    planList6Month = loanDetail!.extra!.depositAverageAmount6Months ?? [];
    planList7Month = loanDetail!.extra!.depositAverageAmount7Months ?? [];
    planList8Month = loanDetail!.extra!.depositAverageAmount8Months ?? [];
    planList9Month = loanDetail!.extra!.depositAverageAmount9Months ?? [];
    planList10Month = loanDetail!.extra!.depositAverageAmount10Months ?? [];
    planList11Month = loanDetail!.extra!.depositAverageAmount11Months ?? [];
    planList12Month = loanDetail!.extra!.depositAverageAmount12Months ?? [];
    averagingPeriodFilterDataList = [];
    if (planList2Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 2));
    }
    if (planList3Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 3));
    }
    if (planList4Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 4));
    }
    if (planList5Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 5));
    }
    if (planList6Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 6));
    }
    if (planList7Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 7));
    }
    if (planList8Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 8));
    }
    if (planList9Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 9));
    }
    if (planList10Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 10));
    }
    if (planList11Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 11));
    }
    if (planList12Month.isNotEmpty) {
      averagingPeriodFilterDataList.add(const AveragingPeriodFilterData(title: '', durationInMonths: 12));
    }
    update();
  }

  void setAveragingPeriodFilterData(AveragingPeriodFilterData averagingPeriodFilterData) {
    selectedAveragingPeriodFilterData = averagingPeriodFilterData;
    selectedParsaLoanPlanIndex = null;
    selectedParsaLoanPlan = null;
    monthController.text = averagingPeriodFilterData.durationInMonths.toString();
    _setParsaPlanList();
  }

  void _setParsaPlanList() {
    if (selectedAveragingPeriodFilterData!.durationInMonths == 2) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount2Months ?? [];
    } else if (selectedAveragingPeriodFilterData!.durationInMonths == 3) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount3Months ?? [];
    } else if (selectedAveragingPeriodFilterData!.durationInMonths == 4) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount4Months ?? [];
    } else if (selectedAveragingPeriodFilterData!.durationInMonths == 5) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount5Months ?? [];
    } else if (selectedAveragingPeriodFilterData!.durationInMonths == 6) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount6Months ?? [];
    } else if (selectedAveragingPeriodFilterData!.durationInMonths == 7) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount7Months ?? [];
    } else if (selectedAveragingPeriodFilterData!.durationInMonths == 8) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount8Months ?? [];
    } else if (selectedAveragingPeriodFilterData!.durationInMonths == 9) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount9Months ?? [];
    } else if (selectedAveragingPeriodFilterData!.durationInMonths == 10) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount10Months ?? [];
    } else if (selectedAveragingPeriodFilterData!.durationInMonths == 11) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount11Months ?? [];
    } else if (selectedAveragingPeriodFilterData!.durationInMonths == 12) {
      allParsaPlanList = loanDetail!.extra!.depositAverageAmount12Months ?? [];
    }
    _filterPlans();
  }

  void setSelectedParsaLoanPlan(DepositAverageAmountMonth selectedPlan, int selectedIndex) {
    selectedParsaLoanPlanIndex = selectedIndex;
    selectedParsaLoanPlan = selectedPlan;
    update();
  }

  Future<void> showFilterPlanBottomSheet() async {
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
        child: const ParsaLoanFilterPlanBottomSheet(),
      ),
    );
    tempSelectedWageCostFilterData = selectedWageCostFilterData;
    tempSelectedRepaymentDurationFilterData = selectedRepaymentDurationFilterData;
    update();
    openBottomSheets--;
  }

  void setTempSelectedWageCostFilterData(dynamic value) {
    tempSelectedWageCostFilterData = value.round();
    update();
  }

  void setTempSelectedRepaymentDurationFilterData(dynamic value) {
    tempSelectedRepaymentDurationFilterData = value.round();
    update();
  }

  void setSelectedWageRepaymentFilterData() {
    selectedWageCostFilterData = tempSelectedWageCostFilterData;
    selectedRepaymentDurationFilterData = tempSelectedRepaymentDurationFilterData;
    update();
    _filterPlans();
  }

  void _filterPlans() {
    parsaPlanList = allParsaPlanList;
    if (selectedWageCostFilterData != null) {
      parsaPlanList =
          parsaPlanList.where((item) => (item.rateInfo!.percentNumber! * 100 == selectedWageCostFilterData)).toList();
    }
    if (selectedRepaymentDurationFilterData != null) {
      parsaPlanList =
          parsaPlanList.where((item) => (item.monthInfo!.monthNumber == selectedRepaymentDurationFilterData)).toList();
    }
    update();
    _closeBottomSheets();
  }

  void removePlanFilters() {
    selectedWageCostFilterData = tempSelectedWageCostFilterData = null;
    selectedRepaymentDurationFilterData = tempSelectedRepaymentDurationFilterData = null;
    parsaPlanList = allParsaPlanList;
    update();
    _closeBottomSheets();
  }

  void validateSelectPlanPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedParsaLoanPlanIndex != null) {
      _submitParsaLoanPriceRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_parsa_loan_plan,
      );
    }
  }

  Future<void> _submitParsaLoanPriceRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final parsaLoanSubmitPlanRequestData = ParsaLoanSubmitPlanRequestData(
      maxPrice: selectedParsaLoanPlan!.maxPrice!,
      month: selectedParsaLoanPlan!.monthInfo!.monthNumber,
      rate: selectedParsaLoanPlan!.rateInfo!.percentNumber!,
    );

    ParsaLoanServices.submitParsaLoanPlanRequest(
      parsaLoanSubmitPlanRequestData: parsaLoanSubmitPlanRequestData,
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

    final taskCompleteState5RequestData = TaskCompleteState5RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'LoanRequestedInfo',
      taskData: [
        {
          'name': 'loanAmount',
          'value': selectedParsaLoanPlan!.maxPrice!,
        },
        {
          'name': 'averageMonth',
          'value': selectedAveragingPeriodFilterData!.durationInMonths!,
        },
        {
          'name': 'repaymentMonth',
          'value': selectedParsaLoanPlan!.monthInfo!.monthNumber!,
        },
        {
          'name': 'loanInterest',
          'value': selectedParsaLoanPlan!.rateInfo!.percentNumber! * 100,
        },
        {
          'name': 'givenLoan',
          'value': loanDetail!.extra!.totalAmountLoanReceived,
        }
      ],
    );

    ParsaLoanServices.parsaLendingState5CompleteTaskRequest(
      taskCompleteState5RequestData: taskCompleteState5RequestData,
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

  Future<void> openSelectMonthBottomSheet() async {
    openBottomSheets++;
    update();
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 7 / 8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const ParsaLoanSelectMonthBottomSheet(),
      ),
    );
    openBottomSheets--;
  }
}
