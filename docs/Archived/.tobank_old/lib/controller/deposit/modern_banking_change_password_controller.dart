import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/modern_banking/request/modern_banking_change_password_request.dart';
import '../../service/core/api_core.dart';
import '../../service/modern_banking_services.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ModernBankingChangePasswordController extends GetxController {
  bool showPassword = false;
  MainController mainController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;

  TextEditingController usernameController = TextEditingController();

  bool isUsernameValid = true;

  @override
  void onInit() {
    usernameController = TextEditingController(text: mainController.authInfoData!.customerNumber);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> validateFirstPage({required int subsystem}) async {
    bool isValid = true;
    if (usernameController.text.trim().isNotEmpty) {
      isUsernameValid = true;
    } else {
      isUsernameValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _changeInternetPasswordRequest(subsystem);
    }
  }

  void toggleShowPassword(bool isChecked) {
    showPassword = !showPassword;
    update();
  }

  /// Sends an API request to change the internet banking password for the customer.
  void _changeInternetPasswordRequest(int subsystem) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ModernBankingChangePasswordRequest modernBankingChangePasswordRequest = ModernBankingChangePasswordRequest();
    modernBankingChangePasswordRequest.trackingNumber = const Uuid().v4();
    modernBankingChangePasswordRequest.customerNumber = mainController.authInfoData!.customerNumber;
    modernBankingChangePasswordRequest.subsystem = subsystem;
    modernBankingChangePasswordRequest.authenticationType = 1;
    modernBankingChangePasswordRequest.username = usernameController.text.trim();

    isLoading = true;
    update();

    ModernBankingServices.modernBankingPasswordChange(
      modernBankingChangePasswordRequest: modernBankingChangePasswordRequest,
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
}
