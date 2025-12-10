import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/other/response/other_item_data.dart';
import '../../service/core/api_core.dart';
import '../../service/other_services.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class RuleController extends GetxController {
  MainController mainController = Get.find();
  OtherItemData? otherItemData;
  bool isFirst;
  bool isLoading = false;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  RuleController({required this.isFirst});

  @override
  void onInit() {
    initGet();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Check for status of internet connection
  /// if internet is connect run the [_getRules] function
  /// if not showing message with [SnackBarUtil.showSnackBar] function
  Future initGet() async {
    if (isFirst) {
      _getFirstRules();
    } else {
      _getRules();
    }
  }

  /// Retrieves the rules and handles the response.
  Future<void> _getRules() async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    OtherServices.getRulesRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
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

  /// Retrieves the first set of rules and handles the response.
  void _getFirstRules() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    OtherServices.getFirstRulesRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
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
