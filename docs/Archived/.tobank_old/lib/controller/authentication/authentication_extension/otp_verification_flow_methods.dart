import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sms_autofill/sms_autofill.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/authentication/kyc/request/get_otp_request_data.dart';
import '../../../model/authentication/kyc/request/validate_otp_request_data.dart';
import '../../../service/authentication/kyc_services.dart';
import '../../../service/core/api_core.dart';
import '../../../util/app_util.dart';
import '../../../util/snack_bar_util.dart';
import '../authentication_extension/authentication_status_flow_methods.dart';
import '../authentication_register_controller.dart';


extension OtpVerificationFlowMethods on AuthenticationRegisterController {
  /// Entry point for mobile number validation
  Future<bool> validateMobileNumber() async {
    print('🔵 Starting mobile number validation');
    AppUtil.hideKeyboard(Get.context!);
    return await _getOtpRequest();
  }

  /// Handles the initial OTP request flow
  Future<bool> _getOtpRequest() async {
    print('🔵 Initiating OTP request');

    try {
      final String ekycDeviceId = const Uuid().v4();
      final request = GetOtpRequestData(
        trackingNumber: const Uuid().v4(),
        cellphoneNumber: mobileTextEditingController.text,
        nationalCode: mainController.authInfoData!.nationalCode!,
        birthDate: mainController.authInfoData!.birthdayDate!,
        deviceId: ekycDeviceId,
      );

      isLoading = true;
      update();

      final result = await KycServices.getOtp(getOtpRequestData: request);

      isLoading = false;
      update();

      switch (result) {
        case Success(value: (_, 200)):
          await _handleSuccessfulOtpRequest(ekycDeviceId);
          return true; // Return true for success with 200
        case Success(value: (_, 421)):
          checkEkycStatusTimeout();
          return true; // Return true for success with 421 (handling as success)
        case Success(value: _):
        // Will not happen
          return false; //Should not happen, but return false to avoid unhandled cases
        case Failure(exception: final ApiException apiException):
          handleApiError(apiException);
          return false; // Return false on API error
      }
    } catch (e) {
      print('🔴 Error during OTP request: $e');
      return false; // Return false in case of any exception
    }
  }


  /// Handles successful OTP request
  Future<void> _handleSuccessfulOtpRequest(String ekycDeviceId) async {
    AppUtil.nextPageController(pageController, isClosed);
    isCallingCode = false;
    _getSms();
    counter = 120;
    startTimer();
    await storeEkycDeviceId(ekycDeviceId);
    update();
  }

  /// Handles OTP verification
  Future<bool> verifyOtp() async {
    print('🔵 Starting OTP verification');
    AppUtil.hideKeyboard(Get.context!);

    if (otpTextController.text.length == otpLength) {
      isOtpValid = true;
      return await _validateOtpRequest();
    } else {
      isOtpValid = false;
      update();
      return false;
    }
  }

  /// Validates the entered OTP with the server
  Future<bool> _validateOtpRequest() async {
    print('🔵 Validating OTP with server');

    final request = ValidateOtpRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      otp: otpTextController.text,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
    );

    isLoading = true;
    update();

    try {
      final result = await KycServices.validateOtp(validateOtpRequestData: request);

      isLoading = false;
      update();

      switch (result) {
        case Success(value: (_, 200)):
          AppUtil.nextPageController(pageController, isClosed);
          update();
          return true; // Return true for success
        case Success(value: (_, 421)):
          checkEkycStatusTimeout();
          return true; // Consider this a success as well, or handle differently
        case Success(value: _):
        // Will not happen, but included for completeness
          return false; // Or throw an error if this is truly unexpected
        case Failure(exception: final ApiException apiException):
          handleApiError(apiException);
          return false; // Return false for failure
      }
    } catch (error) {
      isLoading = false;
      update();
      print('🔴 Error validating OTP: $error');
      // Handle the error appropriately (e.g., show a message to the user)
      return false; // Return false for failure due to exception
    }
  }


  /// Requests a new OTP code
  void requestNewOtpRequest() {
    print('🔵 Requesting new OTP');

    final request = GetOtpRequestData(
      trackingNumber: const Uuid().v4(),
      cellphoneNumber: mobileTextEditingController.text,
      nationalCode: mainController.authInfoData!.nationalCode!,
      birthDate: mainController.authInfoData!.birthdayDate!,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
    );

    otpTextController.clear();
    isRequestOtpLoading = true;
    update();

    KycServices.getOtp(getOtpRequestData: request).then((result) {
      isRequestOtpLoading = false;
      isCallingCode = false;
      update();

      switch (result) {
        case Success(value: (_, 200)):
          counter = 120;
          startTimer();
          update();
        case Success(value: (_, 421)):
          checkEkycStatusTimeout();
        case Success(value: _):
        // Will not happen
          break;
        case Failure(exception: final ApiException apiException):
          handleApiError(apiException);
      }
    });
  }

  /// Starts the OTP countdown timer
  void startTimer() {
    print('🔵 Starting OTP timer');

    if (timer != null) {
      timer!.cancel();
    }

    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (counter < 1) {
        timer.cancel();
      } else {
        counter = counter - 1;
      }
      update();
    });
  }

  /// Gets formatted time for display
  String getCurrentTime() {
    final DateTime time = DateTime(2021);
    return intl.DateFormat('mm:ss').format(
        time.add(Duration(seconds: counter))
    );
  }

  /// Listens for incoming SMS messages containing OTP
  Future<void> _getSms() async {
    print('🔵 Starting SMS listener');

    await SmsAutoFill().listenForCode();
    SmsAutoFill().code.listen((event) {
      print('🔵 SMS received, processing code');

      final code = event.trim();
      if (!isCallingCode) {
        otpTextController.text = code;
        verifyOtp();
        isCallingCode = true;
      }
    });
  }

  /// Handles API errors uniformly
  void handleApiError(ApiException apiException) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    switch (apiException.type) {
      case ApiExceptionType.connectionTimeout:
        checkEkycStatusTimeout();
        break;
      default:
        SnackBarUtil.showSnackBar(
          title: locale.show_error(apiException.displayCode),
          message: apiException.displayMessage,
        );
    }
  }

  /// Checks if the OTP confirmation button should be enabled
  bool isConfirmOtpButtonEnabled() {
    return otpTextController.text.length == otpLength && counter != 0;
  }

  /// Unregisters SMS listener on close
  void disposeSmsListener() {
    print('🔵 Disposing SMS listener');
    try {
      SmsAutoFill().unregisterListener();
    } on Exception catch (e) {
      print('🔵 Error disposing SMS listener: $e');
    }
  }
}