import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/military_guarantee/military_guarantee_deposit_type_data.dart';
import '../../../model/bpms/military_guarantee/request/complete_collateral_type_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/deposit/request/customer_deposits_request_data.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/deposit_services.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class MilitaryGuaranteeCollateralTypeController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MilitaryGuaranteeCollateralTypeController({required this.task, required this.taskData}) {
    _getDataFromTaskData();
  }

  MainController mainController = Get.find();
  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  bool isLoading = false;

  List<Deposit> depositList = [];

  List<Deposit> cashDepositList = [];

  Deposit? selectedCashDeposit;

  MilitaryGuaranteeDepositTypeData? selectedCollateralDepositType;

  List<Deposit> collateralDepositList = [];

  Deposit? selectedCollateralDeposit;

  int? feeAmount;
  int? lgAmount;
  double? collateralAmount;

  void _getDataFromTaskData() {
    for (final formField in taskData) {
      if (formField.id == 'feeAmount') {
        if (formField.value?.subValue != null) {
          feeAmount = (formField.value!.subValue! as double).toInt();
        }
      } else if (formField.id == 'lGAmount') {
        if (formField.value?.subValue != null) {
          lgAmount = (formField.value!.subValue! as double).toInt();
        }
      }
    }

    update();
  }

  @override
  void onInit() {
    getDepositListRequest();
    super.onInit();
  }

  /// Retrieves the list of customer deposits,
  /// filters out long-term deposits, and proceeds to the next step.
  void getDepositListRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final CustomerDepositsRequest customerDepositsRequest = CustomerDepositsRequest(
      customerNumber: mainController.authInfoData!.customerNumber ?? '',
      trackingNumber: const Uuid().v4(),
    );

    DepositServices.getCustomerDeposits(
      customerDepositsRequest: customerDepositsRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerDepositsResponse response, int _)):
          depositList = response.data!.deposits!;
          // Remove long term deposits
          final tempList = depositList.where((element) => element.depositeKind! != 3).toList();
          cashDepositList.addAll(tempList);
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

  void setSelectedCashDeposit(Deposit deposit) {
    selectedCashDeposit = deposit;
    update();
  }

  void validateCashDepositPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool isValid = true;

    if (selectedCashDeposit != null) {
    } else {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_deposit,
      );
    }

    if (isValid) {
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void setSelectedCollateralDepositType(MilitaryGuaranteeDepositTypeData depositType) {
    selectedCollateralDepositType = depositType;
    update();
  }

  void validateCollateralDepositType() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool isValid = true;

    if (selectedCollateralDepositType != null) {
    } else {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(
        locale.select_collateral_deposit_type,
      );
    }
    update();
    if (isValid) {
      collateralDepositList = [];
      if (selectedCollateralDepositType!.id == 1) {
        final tempList = depositList.where((element) => element.depositeKind! != 3).toList();
        collateralDepositList.addAll(tempList);
      } else {
        final tempList = depositList.where((element) => element.depositeKind! == 3).toList();
        collateralDepositList.addAll(tempList);
      }
      update();
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void setSelectedCollateralDeposit(Deposit deposit) {
    selectedCollateralDeposit = deposit;
    update();
  }

  void validateCollateralDepositPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool isValid = true;

    if (selectedCollateralDeposit != null) {
    } else {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_deposit,
      );
    }

    if (isValid) {
      if (selectedCollateralDepositType!.id == 1) {
        // 80%
        collateralAmount = lgAmount!.toDouble() * 80 / 100;
      } else {
        // 88%
        collateralAmount = lgAmount!.toDouble() * 88 / 100;
      }
      _completeCollateralTypeTaskRequest();
    }
  }

  /// Completes the collateral type task by sending a request to the backend.
  void _completeCollateralTypeTaskRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteCollateralTypeTaskData(
        cashDeposit: selectedCashDeposit!.depositNumber!,
        collateralDeposit: selectedCollateralDeposit!.depositNumber!,
        collateralAmount: collateralAmount!.toString(),
      ),
    );

    isLoading = true;
    update();
    BPMSServices.completeTask(
      completeTaskRequest: completeTaskRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          Get.back(closeOverlays: true);
          Future.delayed(Constants.duration200, () {
            SnackBarUtil.showSuccessSnackBar(locale.register_successfully);
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Handles the back press action,
  /// either navigating to the previous page or closing the current screen.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 || pageController.page == 1) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }
}
