import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/parsa_loan/averaging_period_filter_data.dart';
import '../../model/bpms/parsa_loan/parsa_lending_config.dart';
import '../../model/bpms/parsa_loan/request/task/parsa_lending_start_process_request_data.dart';
import '../../model/bpms/parsa_loan/response/branch_list_response_data.dart';
import '../../model/bpms/parsa_loan/response/parsa_lending_get_loan_detail_response_data.dart';
import '../../model/bpms/parsa_loan/response/parsa_loan_check_sana_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/parsa_lending_start_process_response_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/micro_lending/response/micro_lending_submit_contract_response.dart';
import '../../model/other/response/other_item_data.dart';
import '../../service/core/api_core.dart';
import '../../service/parsa_loan_services.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../facility/facility_controller.dart';
import '../main/main_controller.dart';

class ParsaLoanController extends GetxController {
  ScrollController scrollbarController = ScrollController();
  MainController mainController = Get.find();
  FacilityController facilityController = Get.find();

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

  ParsaLendingConfig? config;

  ParsaLendingGetLoanDetailResponseData? parsaLendingGetLoanDetailResponseData;

  OtherItemData? otherItemData;
  OtherItemData? creditOtherItemData;

  bool isRuleChecked = false;
  bool isInquiryRuleChecked = false;
  bool isCustomerCommittalChecked = false;

  bool isLoading = false;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  Deposit? selectedDeposit;
  List<Deposit> depositList = [];

  TextEditingController branchNameController = TextEditingController();
  TextEditingController searchBranchController = TextEditingController();
  List<BranchData> allBankBranchListData = [];
  List<BranchData> bankBranchListData = [];
  BranchData? selectedBankBranch;

  AveragingPeriodFilterData? selectedAveragingPeriodFilterData;
  int? selectedParsaLoanPlanIndex;

  int? tempSelectedWageCostFilterData;
  int? tempSelectedRepaymentDurationFilterData;
  int? selectedWageCostFilterData;
  int? selectedRepaymentDurationFilterData;

  int openBottomSheets = 0;

  int? installment;
  int? repayment;
  int? profit;

  int? maxPrice = 500000000;
  int? minPrice = 10000000;

  int? selectedCreditCardAmountData;
  int? tempSelectedCreditCardAmountData;
  double amountStep = 10000000;

  int selectBarValue = 0;

  String? signedDocumentBase64;
  MicroLendingSubmitContractResponse? submitContractResponse;

  String? creditGrade;

  ParsaLoanCheckSanaResponseData? parsaLoanCheckSanaResponseData;

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
    return 'https://tobank.ir/app/tobank-parsa-loan-conditions/';
  }

  void validateFirstPage() {
    _startProcess();
  }

  Future<void> _startProcess() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final parsaLendingStartProcessRequestData = ParsaLendingStartProcessRequestData(
      processId: 1,
      extraData: {
        'nationalCode': mainController.authInfoData!.nationalCode!,
      },
    );

    ParsaLoanServices.parsaLendingStartProcessRequest(
      parsaLendingStartProcessRequestData: parsaLendingStartProcessRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ParsaLendingStartProcessResponseData response, int _)):
          final trackingNumber = response.data!.trackingNumber!;
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
