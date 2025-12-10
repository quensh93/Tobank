import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/safe_box/response/user_safe_box_list_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/safe_box_services.dart';
import '../../ui/safe_box/add_safe_box/add_safe_box_screen.dart';
import '../../ui/safe_box/list_visit/list_visit_screen.dart';
import '../../ui/safe_box/request_visit_safe_box/request_visit_safe_box_screen.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class SafeBoxController extends GetxController {
  PageController pageController = PageController();
  MainController mainController = Get.find();
  String? errorTitle = '';

  bool hasError = false;

  var isLoading = false;

  List<SafeBoxData> safeBoxDataList = [];

  @override
  void onInit() {
    getSafeBoxListRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> showAddSafeBoxScreen() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool isWaiting = false;
    for (final item in safeBoxDataList) {
      if (item.status == 'waiting') {
        isWaiting = true;
      }
    }
    if (isWaiting) {
      SnackBarUtil.showInfoSnackBar(
        locale.pending_request_warning,
      );
    } else {
      await Get.to(() => const AddSafeBoxScreen());
      AppUtil.previousPageController(pageController, isClosed);
      getSafeBoxListRequest();
    }
  }

  /// Retrieves the list of user's safe boxes and handles the response.
  void getSafeBoxListRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    SafeBoxServices.getUserSafeBoxListRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final UserSafeBoxListResponseData response, int _)):
          safeBoxDataList = response.data ?? [];
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

  void showVisitListScreen(SafeBoxData safeBoxData) {
    Get.to(() => ListVisitScreen(safeBoxData: safeBoxData));
  }

  void showRequestVisitScreen(SafeBoxData safeBoxData) {
    Get.to(() => RequestVisitSafeBoxScreen(safeBoxData: safeBoxData));
  }
}
