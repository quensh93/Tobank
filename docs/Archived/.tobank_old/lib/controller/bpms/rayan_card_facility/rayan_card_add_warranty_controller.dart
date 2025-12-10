import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/rayan_card_facility/request/complete_customer_collateral_info_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../../model/promissory/collateral_promissory/collateral_promissory_request_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../ui/promissory/collateral_promissory/select_collateral_promissory_bottom_sheet.dart';
import '../../../ui/promissory/promissory_preview/promissory_preview_screen.dart';
import '../../../util/constants.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class RayanCardAddWarrantyController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  bool isUploading = false;

  CollateralPromissoryRequestData? collateralPromissoryRequestData;
  CollateralPromissoryPublishResultData? collateralPromissoryPublishResultData;

  int? dueDateInt;

  RayanCardAddWarrantyController({required this.task, required this.taskData}) {
    _getDataFromTaskData();
  }

  void _getDataFromTaskData() {
    int? amount;
    String? dueDate;
    String? description;
    String? recipientNN;
    String? recipientCellPhone;

    for (final formField in taskData) {
      if (formField.id == 'promissoryAmount') {
        amount = (formField.value!.subValue as double).toInt();
      } else if (formField.id == 'promissoryDueDate') {
        if (formField.value!.subValue != null) {
          final timestamp = (formField.value!.subValue as int);
          dueDate = DateConverterUtil.getDibaliteDateFromMilisecondsTimestamp(timestamp);
          dueDateInt = timestamp;
        } else {
          dueDate = null;
          dueDateInt = null;
        }
      } else if (formField.id == 'promissoryDescription') {
        description = formField.value!.subValue?.toString();
      } else if (formField.id == 'beneficiaryNationalCode') {
        recipientNN = formField.value!.subValue.toString();
      } else if (formField.id == 'beneficiaryPhoneNumber') {
        recipientCellPhone = formField.value!.subValue.toString();
      }
    }

    collateralPromissoryRequestData = CollateralPromissoryRequestData(
      amount: amount!,
      dueDate: dueDate,
      description: description,
      recipientNN: recipientNN!,
      recipientCellPhone: recipientCellPhone!,
      transferable: true,
    );

    update();
  }

  void showSelectCollateralPromissoryBottomSheet() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isClosed) {
      return;
    }

    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Get.isDarkMode ? Get.context!.theme.colorScheme.surface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SelectCollateralPromissoryBottomSheet(
          collateralPromissoryRequestData: collateralPromissoryRequestData!,
          returnDataFunction: (CollateralPromissoryPublishResultData? resultData) {
            collateralPromissoryPublishResultData = resultData;
            update();
            Future.delayed(Constants.duration300, () {
              SnackBarUtil.showInfoSnackBar(locale.continue_process_register_promissory);
            });
          },
        ),
      ),
    );
  }

  void showPreviewScreen() {
    Get.to(() => PromissoryPreviewScreen(
          pdfData: base64Decode(collateralPromissoryPublishResultData!.promissoryPdfBase64!),
          promissoryId: collateralPromissoryPublishResultData!.promissoryId!,
        ));
  }

  void validateCollateralPromissory() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (collateralPromissoryPublishResultData != null) {
      _completeCustomerCollateralInfoRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_promissory_note
      );
    }
  }

  /// Completes the customer collateral information request by sending a complete task request to the server.
  void _completeCustomerCollateralInfoRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteCustomerCollateralInfoTaskData(
        customerNationalCode: mainController.authInfoData!.nationalCode!,
        promissoryAmount: collateralPromissoryRequestData!.amount,
        promissoryId: collateralPromissoryPublishResultData!.promissoryId!,
        promissoryDueDate: dueDateInt,
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

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
