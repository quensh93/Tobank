import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/promissory/response/promissory_request_history_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/promissory_services.dart';
import '../../ui/promissory/continue_request_promissory/continue_request_promissory_screen.dart';
import '../../ui/promissory/promissory_cancel_request/promissory_cancel_request_screen.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class PromissoryRequestsHistoryController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  String? errorTitle = '';

  bool hasError = false;

  bool isLoading = false;

  PromissoryRequestHistoryResponseData? promissoryHistoryResponseData;
  List<PromissoryRequest> promissoryRequests = [];

  @override
  void onInit() {
    super.onInit();
    getPromissoryHistoryRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves the promissory note request history.
  void getPromissoryHistoryRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    PromissoryServices.getPromissoryRequestsHistory().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryRequestHistoryResponseData response, int _)):
          promissoryHistoryResponseData = response;
          hasError = false;
          update();
          _handleOpenRequestsResponse(response);

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

  void _handleOpenRequestsResponse(PromissoryRequestHistoryResponseData response) {
    promissoryRequests.clear();
    promissoryRequests.addAll(response.data!.publishRequests!);
    promissoryRequests.addAll(response.data!.endorsementRequests!);
    promissoryRequests.addAll(response.data!.guaranteeRequests!);
    promissoryRequests.addAll(response.data!.settlementRequests!);
    promissoryRequests.addAll(response.data!.settlementGradualRequests!);
    update();
  }

  Future<void> cancelRequest(PromissoryRequest promissoryRequest) async {
    // TODO: Dialog
    await Get.to(() => PromissoryCancelRequestScreen(promissoryRequest: promissoryRequest));
    AppUtil.previousPageController(pageController, isClosed);
    getPromissoryHistoryRequest();
  }

  Future<void> showContinueRequestScreen(PromissoryRequest promissoryRequest) async {
    await Get.to(() => ContinueRequestPromissoryScreen(promissoryRequest: promissoryRequest));
    AppUtil.previousPageController(pageController, isClosed);
    getPromissoryHistoryRequest();
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
