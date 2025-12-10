import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/add_deposit/request/delete_deposit_request.dart';
import '../../model/add_deposit/request/update_deposit_request.dart';
import '../../model/add_deposit/response/deposit_list_data_response.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_notebook_services.dart';
import '../../ui/destination_notebook/deposit_notebook/widget/update_deposit_notebook_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class DepositNotebookController extends GetxController {
  MainController mainController = Get.find();
  DepositDataModel? notebookDepositData;
  OperationType currentOperationType = OperationType.insert;
  List<DepositDataModel> notebookDepositDataList = [];
  List<DepositDataModel> notebookIbanDataList = [];
  bool isLoading = false;
  TextEditingController depositNumberController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  bool depositNumberValid = true;
  bool isTitleValid = true;
  String errorTitle = '';
  bool hasError = false;

  DepositDataModel? selectedDepositDataModel;

  bool isDeleteLoading = false;

  @override
  void onInit() {
    getDepositNotebookRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void setDepositData(DepositDataModel? depositDataModel) {
    if (depositDataModel != null && currentOperationType == OperationType.update) {
      if (depositDataModel.type == DestinationType.iban) {
        depositNumberController.text = depositDataModel.iban!;
      } else {
        depositNumberController.text = depositDataModel.accountNumber!;
      }
      titleController.text = depositDataModel.title!;
    } else {
      depositNumberController.text = '';
      titleController.text = '';
    }
  }

  /// Retrieves the deposit notebook data from the server.
  void getDepositNotebookRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    notebookDepositDataList = [];
    notebookIbanDataList = [];

    hasError = false;
    isLoading = true;
    update();
    DepositNotebookServices.getDepositList().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final DepositListDataResponse response, int _)):
            for (final DepositDataModel element in response.data!) {
              if (element.iban != null && element.iban != '') {
                element.type = DestinationType.iban;
                notebookIbanDataList.add(element);
              } else {
                element.type = DestinationType.deposit;
                notebookDepositDataList.add(element);
              }
            }
            update();
          case Failure(exception: final ApiException apiException):
            hasError = true;
            errorTitle = apiException.displayMessage;
            update();
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  void showEditDepositPage(DepositDataModel? depositDataModel) {
    notebookDepositData = depositDataModel;
    currentOperationType = OperationType.update;
    setDepositData(depositDataModel);
    update();
    _showUpdateDepositNotebookBottomSheet();
  }

  void _showUpdateDepositNotebookBottomSheet() {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
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
        child: const UpdateDepositNotebookBottomSheet(),
      ),
    );
  }

  void deleteDeposit(DepositDataModel depositDataModel) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDeleteDialog(
      buildContext: Get.context!,
      title: locale.confirm_deletion(depositDataModel.type == DestinationType.iban ? locale.shaba : locale.deposit),
      confirmMessage: locale.confirmation,
      cancelMessage: locale.return_,
      positiveFunction: () {
        Get.back(closeOverlays: true);
        _deleteUserDepositRequest(depositDataModel);
      },
      negativeFunction: () => Get.back(closeOverlays: true),
    );
  }

  /// Sends a request to delete a user deposit from the notebook.
  void _deleteUserDepositRequest(DepositDataModel depositDataModel) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    selectedDepositDataModel = depositDataModel;
    isDeleteLoading = true;
    update();
    DepositNotebookServices.deleteDeposit(
      deleteDepositRequest: DeleteDepositRequest(id: depositDataModel.id),
    ).then((result) {
      isDeleteLoading = false;
      selectedDepositDataModel = null;
      update();

      switch (result) {
        case Success(value: _):
          SnackBarUtil.showSuccessSnackBar(
              locale.deleted_successfully_message(depositDataModel.type == DestinationType.iban ?locale.shaba : locale.deposit));
          getDepositNotebookRequest();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Sends a request to update a deposit in the notebook.
  void _updateDepositRequest(DepositDataModel depositDataModel) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    DepositNotebookServices.updateDeposit(
      updateDepositRequest: UpdateDepositRequest(
        iban: depositDataModel.iban,
        id: depositDataModel.id,
        title: depositDataModel.title,
        accountNumber: depositDataModel.accountNumber,
      ),
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          Get.back();
          SnackBarUtil.showSuccessSnackBar(
              locale.edited_successfully_message(notebookDepositData!.type == DestinationType.iban ? locale.shaba : locale.deposit));
          getDepositNotebookRequest();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void validate() {
    bool isValid = true;
    if (titleController.text.isEmpty) {
      isTitleValid = false;
      isValid = false;
    } else {
      isTitleValid = true;
    }
    update();
    if (isValid) {
      updateAction();
    }
  }

  void updateAction() {
    AppUtil.hideKeyboard(Get.context!);
    final DepositDataModel dataModel = DepositDataModel(
      iban: notebookDepositData!.iban,
      accountNumber: notebookDepositData!.accountNumber,
      title: titleController.text,
      id: notebookDepositData!.id,
      createdAt: notebookDepositData!.createdAt,
    );
    _updateDepositRequest(dataModel);
  }
}
