import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/parsa_loan/loan_detail.dart';
import '../../model/bpms/parsa_loan/request/choose_branch_request_data.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_4_request_data.dart';
import '../../model/bpms/parsa_loan/response/branch_list_response_data.dart';
import '../../model/bpms/parsa_loan/response/parsa_lending_get_loan_detail_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/parsa_loan_services.dart';
import '../../ui/parsa_loan/parsa_loan_branch_info/widget/parsa_loan_select_branch_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ParsaLoanBranchInfoController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = true;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  LoanDetail? loanDetail;

  bool isBranchFixed = false;

  TextEditingController branchNameController = TextEditingController();
  TextEditingController searchBranchController = TextEditingController();
  List<BranchData> allBankBranchListData = [];
  List<BranchData> bankBranchListData = [];
  BranchData? selectedBankBranch;

  int openBottomSheets = 0;

  final String trackingNumber;

  ParsaLoanBranchInfoController({required this.trackingNumber});

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
          _getBranchListRequest();
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

  Future<void> _getBranchListRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    ParsaLoanServices.getBranchListRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final BranchListResponseData response, int _)):
          bankBranchListData = response.data ?? [];
          allBankBranchListData = response.data ?? [];

          if (response.branchSelectedCode != null) {
            isBranchFixed = true;
            setSelectedBankBranch(
                bankBranchListData.firstWhere((branch) => branch.code == response.branchSelectedCode!));
          } else {
            if (loanDetail!.deposit!.startsWith('110')) {
              isBranchFixed = true;
              setSelectedBankBranch(bankBranchListData.firstWhere((branch) => branch.code == 110));
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
    });
  }

  Future<void> openSelectBranchBottomSheet() async {
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
        child: const ParsaLoanSelectBranchBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void searchBankBranch() {
    if (allBankBranchListData.isNotEmpty) {
      bankBranchListData = allBankBranchListData
          .where((item) => (item
              .toJson()
              .toString()
              .toLowerCase()
              .contains(AppUtil.getEnglishNumbers(searchBranchController.text.toLowerCase()))))
          .toList();
      update();
    }
  }

  void setSelectedBankBranch(BranchData branchData) {
    selectedBankBranch = branchData;
    branchNameController.text = '${selectedBankBranch!.faTitle} - ${selectedBankBranch!.code}';
    update();
    _closeBottomSheets();
  }

//locale
  final locale = AppLocalizations.of(Get.context!)!;
  void validateSelectBranchPage() {
    if (selectedBankBranch != null) {
      _chooseBranchRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_branch_agent,
      );
    }
  }

  Future<void> _chooseBranchRequest() async {
    hasError = false;
    isLoading = true;
    update();

    final ChooseBranchRequestData chooseBranchRequestData = ChooseBranchRequestData(
      branchCode: selectedBankBranch!.code,
    );

    ParsaLoanServices.chooseBranchRequest(
      chooseBranchRequestData: chooseBranchRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          _taskComplete();
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

    final taskCompleteState4RequestData = TaskCompleteState4RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'LoanBranchInfo',
      taskData: [
        {
          'name': 'loanBranchCode',
          'value': selectedBankBranch!.code!,
        },
        {
          'name': 'loanBranchName',
          'value': selectedBankBranch!.faTitle!,
        }
      ],
    );

    ParsaLoanServices.parsaLendingState4CompleteTaskRequest(
      taskCompleteState4RequestData: taskCompleteState4RequestData,
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
