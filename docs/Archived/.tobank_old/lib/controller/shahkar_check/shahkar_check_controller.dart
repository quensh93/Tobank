import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/profile/request/check_user_request_data.dart';
import '../../model/profile/response/profile_data.dart' as profile_model;
import '../../model/profile/response/profile_data.dart';
import '../../service/core/api_core.dart';
import '../../service/profile_services.dart';
import '../../ui/common/date_selector_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/date_converter_util.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class ShahkarCheckController extends GetxController {
  MainController mainController = Get.find();
  String dateJalaliString = '';
  String? dateGregorian;
  TextEditingController nationalCodeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isNationalCodeValid = true;
  bool isFirstNameValid = true;
  bool isLoading = false;
  profile_model.ProfileData? profileData;
  PageController pageController = PageController();

  String initDateString = '';

  String errorTitle = '';
  bool hasError = false;

  bool isDateValid = true;

  @override
  void onInit() {
    super.onInit();
    getProfileDataRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
    initDateString = AppUtil.twentyYearsBeforeNow();
  }

  /// Get data of [profile_model.ProfileData] from server request
  Future<void> getProfileDataRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    ProfileServices.getProfileRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ProfileData response, int _)):
          profileData = response;
          hasError = false;
          update();
          _setFormValues();
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

  void deleteDate() {
    dateGregorian = null;
    dateJalaliString = '';
    dateController.text = '';
    update();
  }

  /// Hide keyboard & show date picker dialog modal
  void showSelectDateDialog() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
        elevation: 0,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
        constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
        builder: (context) {
          return DateSelectorBottomSheet(
            initDateString: initDateString,
            title: locale.select_birthdate,
            onDateSelected: (selectedDate) {
              dateJalaliString = selectedDate;
            },
            callback: () {
              dateController.text = dateJalaliString;
              initDateString = dateJalaliString;
              dateGregorian = DateConverterUtil.getDateGregorian(jalaliDate: dateJalaliString.replaceAll('-', '/'));
              update();
              Get.back();
            },
          );
        });
  }

  /// Set values of [ProfileData] in TextField widgets
  void _setFormValues() {
    String dateJalali = '';
    if (profileData!.data!.birthDate != null && profileData!.data!.birthDate != '') {
      try {
        dateJalali = DateConverterUtil.getDateJalali(gregorianDate: profileData!.data!.birthDate);
        dateGregorian = profileData!.data!.birthDate;
      } on Exception catch (error) {
        error.printError();
      }
    }
    nationalCodeController.text = profileData!.data!.nationalId ?? '';
    if (dateJalali.isNotEmpty) {
      dateController.text = dateJalali;
      if (dateJalali.isNotEmpty) {
        initDateString = dateJalali;
      }
    }
    dateJalaliString = dateJalali;
  }

  /// Validate values of form before request
  void validate() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (nationalCodeController.text.length == Constants.nationalCodeLength &&
        AppUtil.validateNationalCode(nationalCodeController.text)) {
      isNationalCodeValid = true;
    } else {
      isNationalCodeValid = false;
      isValid = false;
    }
    if (dateController.text.isNotEmpty) {
      isDateValid = true;
    } else {
      isDateValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _checkUserRequest();
    }
  }

  /// Verifies user identity by checking birth date and national code against server data.
  void _checkUserRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CheckUserRequestData checkUserRequestData = CheckUserRequestData();
    checkUserRequestData.birthDate = dateController.text.replaceAll('/', '-');
    checkUserRequestData.nationalCode = nationalCodeController.text;

    isLoading = true;
    update();

    ProfileServices.checkUserIdentityRequest(
      checkUserRequestData: checkUserRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          mainController.authInfoData!.birthdayDate = dateController.text;
          mainController.authInfoData!.nationalCode = nationalCodeController.text;
          mainController.update();
          await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
          Get.back();
          Timer(Constants.duration200, () {
            SnackBarUtil.showSuccessSnackBar(locale.info_verification_success);
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }
}
