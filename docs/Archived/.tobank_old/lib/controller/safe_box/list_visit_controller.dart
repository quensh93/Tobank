import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/safe_box/response/user_safe_box_list_response_data.dart';
import '../../model/safe_box/response/user_visit_list_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/safe_box_services.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ListVisitController extends GetxController {
  ListVisitController({required this.safeBoxData});

  final SafeBoxData safeBoxData;
  MainController mainController = Get.find();
  String? errorTitle = '';

  bool hasError = false;

  bool isLoading = false;

  PageController pageController = PageController();

  UserVisitListResponseData? userVisitListResponseData;

  @override
  void onInit() {
    getListOfVisitRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves the list of visits for a safe box and handles the response.
  void getListOfVisitRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    SafeBoxServices.getListOfVisitRequest(userFundId: safeBoxData.id!).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final UserVisitListResponseData response, int _)):
          userVisitListResponseData = response;
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
}
