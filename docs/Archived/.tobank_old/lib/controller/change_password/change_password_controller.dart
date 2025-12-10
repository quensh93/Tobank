import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';

class ChangePasswordController extends GetxController {
  bool isCorrectCurrentPassword = true;
  bool isCorrectNewPassword = true;
  bool isCorrectReNewPassword = true;
  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode reNewPasswordFocusNode = FocusNode();
  bool isLoading = false;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController renewPasswordController = TextEditingController();
  bool get hasLetters =>
      RegExp(r'[a-z]').hasMatch(newPasswordController.text) &&
          RegExp(r'[A-Z]').hasMatch(newPasswordController.text);
  bool get hasDigits => RegExp(r'\d').hasMatch(newPasswordController.text);
  bool get hasMinLength => newPasswordController.text.length >= 8;
  final alphanumeric = RegExp(r'^[a-zA-Z0-9 !"#$%&()*+,-./:;<=>?@[\]^_`{|}~]+$');

  Future<void> validate() async {
    final current = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final reNewPass = renewPasswordController.text.trim();

    isCorrectCurrentPassword = current.isNotEmpty;
    isCorrectNewPassword = newPass.isNotEmpty;

    if (newPass == reNewPass && reNewPass.isNotEmpty) {
      isCorrectReNewPassword = true;
    } else {
      isCorrectReNewPassword = false;
    }


    final meetsComplexity =
        hasLetters && hasDigits && hasMinLength && alphanumeric.hasMatch(newPass);

    isCorrectNewPassword = isCorrectNewPassword && meetsComplexity;

    update();

    if (isCorrectCurrentPassword && isCorrectNewPassword && isCorrectReNewPassword) {
      _changePassword();
    } else if (!meetsComplexity) {
      final locale = AppLocalizations.of(Get.context!)!;
      SnackBarUtil.showInfoSnackBar(
        ///
        locale.incorrect_password_,
      );
    }
  }


  Future<void> _changePassword() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String? password = await StorageUtil.getPassword();
    if (AppUtil.encryptDataWithAES(data: currentPasswordController.text.trim()) == password) {
      await StorageUtil.setPassword(AppUtil.encryptDataWithAES(data: newPasswordController.text.trim()));
      Get.back();
      SnackBarUtil.showSuccessSnackBar(locale.password_updated_successfully);
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.incorrect_password_,
      );
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   Get.closeAllSnackbars();
  // }
}
