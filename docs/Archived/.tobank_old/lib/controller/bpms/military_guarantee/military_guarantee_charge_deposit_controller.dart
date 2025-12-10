import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/military_guarantee/request/complete_charge_deposit_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/deposit/request/deposit_balance_request_data.dart';
import '../../../model/deposit/response/deposit_balance_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/deposit_services.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class MilitaryGuaranteeChargeDepositController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MilitaryGuaranteeChargeDepositController({required this.task, required this.taskData}) {
    _getDataFromTaskData();
  }

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  bool hasError = false;
  String? errorTitle = '';

  double? feeAmount;

  String? cashDeposit;
  double? cashAmount;

  String? collateralDeposit;
  double? collateralAmount;

  String? calculateFeeDescription;

  int? cashDepositBalance;
  int? collateralDepositBalance;

  int get cashTotalAmount => (feeAmount! + cashAmount!).ceil();

  int get collateralTotalAmount => collateralAmount!.ceil();

  void _getDataFromTaskData() {
    for (final formField in taskData) {
      if (formField.id == 'feeAmount') {
        if (formField.value?.subValue != null) {
          feeAmount = formField.value?.subValue;
        }
      } else if (formField.id == 'cashDeposit') {
        if (formField.value?.subValue != null) {
          cashDeposit = formField.value?.subValue;
        }
      } else if (formField.id == 'cashAmount') {
        if (formField.value?.subValue != null) {
          cashAmount = formField.value?.subValue;
        }
      } else if (formField.id == 'collateralDeposit') {
        if (formField.value?.subValue != null) {
          collateralDeposit = formField.value?.subValue;
        }
      } else if (formField.id == 'collateralAmount') {
        if (formField.value?.subValue != null) {
          collateralAmount = formField.value?.subValue;
        }
      } else if (formField.id == 'calculateFeeDescription') {
        if (formField.value?.subValue != null) {
          calculateFeeDescription = formField.value?.subValue;
        }
      }
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();

    getCashDepositBalanceRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves the cash deposit balance and proceeds to the next step.
  void getCashDepositBalanceRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DepositBalanceRequestData depositBalanceRequestData = DepositBalanceRequestData();
    depositBalanceRequestData.trackingNumber = const Uuid().v4();
    depositBalanceRequestData.depositNumber = cashDeposit;
    depositBalanceRequestData.customerNumber = mainController.authInfoData!.customerNumber!;

    isLoading = true;
    update();

    DepositServices.getDepositBalanceRequest(
      depositBalanceRequestData: depositBalanceRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DepositBalanceResponseData response, int _)):
          cashDepositBalance = response.data!.withdrawableBalance!;
          update();
          AppUtil.nextPageController(pageController, isClosed);
          Future.delayed(Constants.duration200, () {
            getCollateralDepositBalanceRequest();
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  // TODO: remove duplicate deposit balance
  /// Retrieves the collateral deposit balance and proceeds to the next step.
  void getCollateralDepositBalanceRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DepositBalanceRequestData depositBalanceRequestData = DepositBalanceRequestData();
    depositBalanceRequestData.trackingNumber = const Uuid().v4();
    depositBalanceRequestData.depositNumber = collateralDeposit;
    depositBalanceRequestData.customerNumber = mainController.authInfoData!.customerNumber!;

    isLoading = true;
    update();

    DepositServices.getDepositBalanceRequest(
      depositBalanceRequestData: depositBalanceRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DepositBalanceResponseData response, int _)):
          collateralDepositBalance = response.data!.withdrawableBalance!;
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

  void validateCheckBalance() {
    _completeChargeDepositTaskRequest();
  }

  /// Completes the charge deposit task by sending a request to the backend.
  void _completeChargeDepositTaskRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteChargeDepositTaskData(), // Empty dictionary
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
}
