import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sms_autofill/sms_autofill.dart';

import '../../model/automatic_dynamic_pin/automatic_dynamic_pin_stored_data_model.dart';
import '../../model/automatic_dynamic_pin/request/automatic_dynamic_pin_pre_register_request_data.dart';
import '../../model/automatic_dynamic_pin/request/automatic_dynamic_pin_register_request_data.dart';
import '../../model/common/encryption_key_pair.dart';
import '../../service/automatic_dynamic_pin_services.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class AutomaticDynamicPinActiveController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;

  bool isMobileValid = true;
  TextEditingController phoneNumberController = TextEditingController();
  bool isOTPValid = true;
  TextEditingController otpController = TextEditingController();

  int counter = 120;
  DateTime time = DateTime(2021);
  Timer? timer;

  @override
  void onInit() {
    phoneNumberController = TextEditingController(text: mainController.authInfoData!.mobile);
    super.onInit();
  }

  /// Listens for incoming SMS messages containing an OTP and automatically fills the OTP field in the UI.
  Future<void> _getSms() async {
    bool isCallingCode = false;
    AppUtil.printResponse('getSms');
    await SmsAutoFill().listenForCode();
    SmsAutoFill().code.listen((event) {
      AppUtil.printResponse(event);
      event.trim();
      final List<String> sms = [];
      for (int i = 0; i < event.length; i++) {
        final String t = event.substring(i, i + 1);
        sms.add(t);
      }
      String code = '';
      for (int i = 0; i < sms.length; i++) {
        if (i == sms.length - 1) {
          code = code + sms[i];
        } else {
          code = code + sms[i];
        }
      }
      AppUtil.printResponse(code.trim());
      code.trim();
      otpController.text = code;
      if (!isCallingCode) {
        isCallingCode = true;
      }
    });
  }

  @override
  void onClose() {
    AppUtil.printResponse('disposeGetSMS');
    try {
      SmsAutoFill().unregisterListener();
    } on Exception catch (e) {
      AppUtil.printResponse(e.toString());
    }
    super.onClose();
  }

  /// Formats the remaining time as a string in the format "mm:ss".
  String getTimerString() {
    final timer = intl.DateFormat('mm:ss').format(time.add(Duration(seconds: counter)));
    return timer;
  }

  /// Starts a timer that decrements a counter every second.
  void _startTimer() {
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

  /// Sends a pre-registration request for automatic dynamic PIN generation and handles the response.
  void preRegisterRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final requestData = AutomaticDynamicPinPreRegisterRequest(mobile: mainController.authInfoData!.mobile!);

    isLoading = true;
    update();

    AutomaticDynamicPinServices.preRegisterRequest(automaticDynamicPinPreRegisterRequest: requestData)
        .then((response) async {
      isLoading = false;
      update();
      if (response.statusCode == 200) {
        _getSms();
        counter = 120;
        _startTimer();
        AppUtil.nextPageController(pageController, isClosed);
      } else if (response.statusCode == 400) {
        SnackBarUtil.showSnackBar(
          title: locale.show_error(response.statusCode??400),
          message: response.errorResponseData.message ?? '',
        );
      } else {
        SnackBarUtil.showExceptionErrorSnackBar(response.statusCode);
      }
    });
  }

  void validateSecondPage() {
    AppUtil.hideKeyboard(Get.context!);
    if (otpController.text.length == 6) {
      isOTPValid = true;
      _registerRequest();
    } else {
      isOTPValid = false;
    }
    update();
  }

  /// Sends a registration request for automatic dynamic PIN generation and
  /// handles the response, storing the generated key pair if successful.
  Future<void> _registerRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final EncryptionKeyPair keyPair = await AppUtil.generateRSAKeyPair();

    String publicKey = keyPair.publicKey;
    publicKey = publicKey
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .replaceAll('\n', '')
        .trim();

    final requestData = AutomaticDynamicPinRegisterRequest(
        keyData: publicKey, mobile: mainController.authInfoData!.mobile!, otp: otpController.text);

    isLoading = true;
    update();

    AutomaticDynamicPinServices.registerRequest(automaticDynamicPinRegisterRequest: requestData).then((response) async {
      isLoading = false;
      update();
      if (response.statusCode == 200) {
        final storedData = AutomaticDynamicPinStoredData(
            publicKey: keyPair.publicKey, privateKey: keyPair.privateKey, keyId: response.data!.keyId!);
        await StorageUtil.setAutomaticDynamicPinStored(jsonEncode(storedData.toJson()));
        update();
        Get.back();
        Timer(Constants.duration300, () {
          SnackBarUtil.showSuccessSnackBar(locale.dynamic_password_active_successfully);
        });
      } else if (response.statusCode == 400) {
        SnackBarUtil.showSnackBar(
          title: locale.show_error(response.statusCode.toString() as int),
          message: response.errorResponseData.message ?? '',
        );
      } else {
        SnackBarUtil.showExceptionErrorSnackBar(response.statusCode);
      }
    });
  }
}
