import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/close_deposit/request/complete_close_long_term_deposit_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/close_deposit_type_item_data.dart';
import '../../../model/deposit/request/deposit_balance_request_data.dart';
import '../../../model/deposit/response/deposit_balance_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/deposit_services.dart';
import '../../../util/app_util.dart';
import '../../../util/dialog_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CloseLongTermDepositController extends GetxController {
  bool isRuleChecked = false;

  Task task;
  List<TaskDataFormField> taskData;

  String? depositNumber;
  int? depositPart;

  MainController mainController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;

  CloseDepositTypeItemData? selectedCloseDepositTypeItemData;

  bool isShow = false;

  TextEditingController amountController = TextEditingController();

  int amount = 0;

  String? errorTitle = '';

  bool hasError = false;

  DepositBalanceResponseData? depositBalanceResponseData;

  CloseLongTermDepositController({
    required this.task,
    required this.taskData,
  }) {
    for (final formField in taskData) {
      if (formField.id == 'depositPart') {
        depositPart = int.parse(formField.value!.subValue!.toString());
      } else if (formField.id == 'sourceDeposit') {
        depositNumber = formField.value!.subValue!.toString();
      }
    }
  }

  @override
  void onInit() {
    getDepositBalanceRequest();
    super.onInit();
  }

  void validateSelectorPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedCloseDepositTypeItemData != null) {
      if (selectedCloseDepositTypeItemData!.id == 2) {
        if (amount != 0) {
          if (amount > getBalance()) {
            SnackBarUtil.showInfoSnackBar(
              locale.amount_exceeds_balance,
            );
          } else {
            if (amount.toDouble() % depositPart!.toDouble() == 0.0) {
              _showConfirmDialog();
            } else {
              SnackBarUtil.showInfoSnackBar(
                locale.requested_amount_multiple(depositPart.toString()),
              );
            }
          }
        } else {
          SnackBarUtil.showInfoSnackBar(
            locale.please_select_requested_amount,
          );
        }
      } else {
        _showConfirmDialog();
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_deposit_closure_type,
      );
    }
  }

  void _showConfirmDialog() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showConfirmCloseDeposit(
      buildContext: Get.context!,
      positiveFunction: () {
        Get.back();
        _closeLongTermDepositRequest();
      },
      negativeFunction: () {
        Get.back();
      },
      depositNumber: depositNumber ?? '',
      title: locale.deposit_closure_confirmation_title,
      confirmMessage: locale.close_deposit,
      cancelMessage: locale.cancel,
    );
  }

  /// Closes a long-term deposit and handles the response.
  void _closeLongTermDepositRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteCloseLongTermDepositTaskData(
        depositClosingType: selectedCloseDepositTypeItemData!.value,
        depositPartAmount: selectedCloseDepositTypeItemData!.id == 2 ? amount.toString() : null,
      ),
    );

    BPMSServices.completeTask(
      completeTaskRequest: completeTaskRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setSelectedCloseDepositType(CloseDepositTypeItemData closeDepositTypeItemData) {
    selectedCloseDepositTypeItemData = closeDepositTypeItemData;
    update();
  }

  void toggleShowListAmount() {
    isShow = !isShow;
    update();
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

  bool showAmountLayout() {
    if (selectedCloseDepositTypeItemData != null && selectedCloseDepositTypeItemData!.id == 2) {
      return true;
    } else {
      return false;
    }
  }

  /// Retrieves the deposit balance and handles the response.
  void getDepositBalanceRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DepositBalanceRequestData depositBalanceRequestData = DepositBalanceRequestData();
    depositBalanceRequestData.trackingNumber = const Uuid().v4();
    depositBalanceRequestData.depositNumber = depositNumber;
    depositBalanceRequestData.customerNumber = mainController.authInfoData!.customerNumber!;

    hasError = false;
    isLoading = true;
    update();

    DepositServices.getDepositBalanceRequest(
      depositBalanceRequestData: depositBalanceRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DepositBalanceResponseData response, int _)):
          depositBalanceResponseData = response;
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

  int getBalance() {
    int amount = 0;
    if (depositBalanceResponseData != null &&
        depositBalanceResponseData!.data != null &&
        depositBalanceResponseData!.data!.balance != null) {
      amount = depositBalanceResponseData!.data!.balance!;
    }
    return amount;
  }

  void setSelectedAmount(int selectedAmount) {
    amount = selectedAmount;
    isShow = false;
    update();
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
