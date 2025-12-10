import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/request/process_detail_request_data.dart';
import '../../model/bpms/response/process_detail_response_data.dart';
import '../../service/bpms_services.dart';
import '../../service/core/api_exception.dart';
import '../../service/core/api_result_model.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ProcessDetailController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  bool isLoading = true;
  bool hasError = false;
  String errorTitle = '';
  final String processInstanceId;

  ProcessDetailResponse? processDetailResponse;

  ProcessDetailController({required this.processInstanceId});

  @override
  void onInit() {
    getProcessDetailRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Call the function to retrieve process details.
  void getProcessDetailRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final ProcessDetailRequest processDetailRequest = ProcessDetailRequest(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      processInstanceId: processInstanceId,
    );

    BPMSServices.getProcessDetail(
      processDetailRequest: processDetailRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ProcessDetailResponse response, int _)):
          processDetailResponse = response;
          AppUtil.nextPageController(pageController, isClosed);
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
    });
  }

  String getRequestStatusText() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final applicantAccepted = processDetailResponse!.data?.process?.variables?.applicantAccepted ?? true;
    if (applicantAccepted) {
      switch (processDetailResponse!.data!.process!.state!) {
        case 'ACTIVE':
          return locale.active;
        case 'SUSPENDED':
          return locale.suspended;
        case 'COMPLETED':
          return locale.completed_or_terminated;
        case 'EXTERNALLY_TERMINATED':
          return locale.completed_or_terminated;
        case 'INTERNALLY_TERMINATED':
          return locale.completed_or_terminated;
        default:
          return locale.unknown;
      }
    } else {
      return locale.rejected;
    }
  }

  String creditCardAmount() {
    if (processDetailResponse != null) {
      return processDetailResponse!.data!.process!.variables!.requestAmount!;
    } else {
      return '0';
    }
  }

  String customerAddress() {
    if (processDetailResponse!.data!.process!.variables!.customerAddress!.localityName != null &&
        processDetailResponse!.data!.process!.variables!.customerAddress!.lastStreet != null &&
        processDetailResponse!.data!.process!.variables!.customerAddress!.secondLastStreet != null &&
        processDetailResponse!.data!.process!.variables!.customerAddress!.plaque != null &&
        processDetailResponse!.data!.process!.variables!.customerAddress!.unit != null) {
      return '${processDetailResponse!.data!.process!.variables!.customerAddress!.localityName}، ${processDetailResponse!.data!.process!.variables!.customerAddress!.lastStreet}، ${processDetailResponse!.data!.process!.variables!.customerAddress!.secondLastStreet}،  پلاک ${processDetailResponse!.data!.process!.variables!.customerAddress!.plaque}، واحد ${processDetailResponse!.data!.process!.variables!.customerAddress!.unit}';
    } else {
      return '';
    }
  }

  String postParcelStatus() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (processDetailResponse!.data!.process!.variables!.postParcelStatus == 'delivered') {
      return locale.parcel_status_delivered;
    } else if (processDetailResponse!.data!.process!.variables!.postParcelStatus == 'rejected') {
      return locale.parcel_status_rejected;
    } else {
      return locale.parcel_status_no_response;
    }
  }
}
