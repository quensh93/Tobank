import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/card/request/change_card_pin_request_data.dart';
import '../../model/card/request/change_custom_card_pin_request_data.dart';
import '../../model/card/response/change_card_pin_response_data.dart';
import '../../model/card/response/change_custom_card_pin_response_data.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/common/encryption_key_pair.dart';
import '../../model/register/request/get_public_key_request_data.dart';
import '../../model/register/request/upload_customer_public_key_request_data.dart';
import '../../model/register/response/get_public_key_response_data.dart';
import '../../model/register/response/upload_customer_public_key_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/card_services.dart';
import '../../service/core/api_core.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class CardChangePasswordController extends GetxController {
  CardChangePasswordController({required this.customerCard});

  TextEditingController currentPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController reNewPinController = TextEditingController();

  bool isCurrentPinValid = true;
  bool isNewPinValid = true;
  bool isReNewPinValid = true;

  FocusNode currentPinFocusNode = FocusNode();
  FocusNode newPinFocusNode = FocusNode();
  FocusNode reNewPinFocusNode = FocusNode();

  CustomerCard customerCard;
  MainController mainController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;
  ChangeCardPinResponse? changeCardPinResponse;
  bool showPassword = false;

  String? errorTitle = '';

  bool hasError = false;

  @override
  void onInit() {
    getDibalitePublicKeyRequest();
    super.onInit();
  }

  /// Sends a request to get the Dibalite public key and handles the response.
  void getDibalitePublicKeyRequest() {
    final GetPublicKeyRequestData getPublicKeyRequestData = GetPublicKeyRequestData(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber,
    );

    hasError = false;
    isLoading = true;
    update();

    AuthorizationServices.getDibalitePublicKeyRequest(
      getPublicKeyRequestData: getPublicKeyRequestData,
    ).then((result) async {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final GetPublicKeyResponseData response, int _)):
          _handlePublicKey(response);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
      }
    });
  }

  /// Handles the public key response by comparing it with the device's public key
  /// and either proceeding to the next page or uploading the device's key.
  Future<void> _handlePublicKey(GetPublicKeyResponseData response) async {
    final String? customerKeyPairString = await StorageUtil.getEncryptionKeyPair();
    final EncryptionKeyPair deviceDibaliteKeypair = EncryptionKeyPair.fromJson(jsonDecode(customerKeyPairString!));

    String serverPublicKey = response.data!.customerPublicKey!;
    String devicePublicKey = deviceDibaliteKeypair.publicKey;

    serverPublicKey = serverPublicKey
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .replaceAll('\n', '')
        .trim();

    devicePublicKey = devicePublicKey
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .replaceAll('\n', '')
        .trim();

    if (devicePublicKey == serverPublicKey) {
      AppUtil.nextPageController(pageController, isClosed);
    } else {
      _uploadKeyRequest();
    }
  }

  /// Uploads the device's public key to the server.
  Future<void> _uploadKeyRequest() async {
    hasError = false;
    isLoading = true;
    update();

    final EncryptionKeyPair keyPair = await AppUtil.generateRSAKeyPair();
    await StorageUtil.setEncryptionKeyPair(jsonEncode(keyPair));

    String publicKey = keyPair.publicKey;
    publicKey = publicKey
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .replaceAll('\n', '')
        .trim();

    final UploadCustomerPublicKeyRequest uploadCustomerPublicKeyRequest = UploadCustomerPublicKeyRequest(
        customerNumber: mainController.authInfoData!.customerNumber!,
        trackingNumber: const Uuid().v4(),
        customerPublicKey: publicKey);

    AuthorizationServices.uploadCustomerPublicKey(
      uploadCustomerPublicKeyRequest: uploadCustomerPublicKeyRequest,
    ).then((result) async {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final UploadCustomerPublicKeyResponse _, int _)):
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
      }
    });
  }

  void validateFirstPage({required int pinType}) {
    _changePinRequest(pinType);
  }

  void toggleShowPassword(bool isChecked) {
    showPassword = !showPassword;
    update();
  }

  /// Sends a request to change the cardPIN and handles the response.
  void _changePinRequest(int pinType) { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ChangeCardPinRequest changeCardPinRequest = ChangeCardPinRequest(
      pinType: pinType,
      pan: customerCard.cardNumber!,
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
    );
    isLoading = true;
    update();
    CardServices.changeCardPin(
      changeCardPinRequest: changeCardPinRequest,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ChangeCardPinResponse response, int _)):
          changeCardPinResponse = response;
          if (changeCardPinResponse!.data!.pin1 != null && changeCardPinResponse!.data!.pin1!.isNotEmpty) {
            changeCardPinResponse!.data!.pin1 = await AppUtil.decryptRSAData(changeCardPinResponse!.data!.pin1!);
          }
          if (changeCardPinResponse!.data!.pin2 != null && changeCardPinResponse!.data!.pin2!.isNotEmpty) {
            changeCardPinResponse!.data!.pin2 = await AppUtil.decryptRSAData(changeCardPinResponse!.data!.pin2!);
          }
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Validates the inputs for changing the password and proceeds with the request if valid.
  void validateChangePassword({required int pinType}) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool isValid = true;
    if (pinType == 0) {
      if (currentPinController.text.length == 4) {
        isCurrentPinValid = true;
      } else {
        isCurrentPinValid = false;
        isValid = false;
      }
      if (newPinController.text.length == 4) {
        isNewPinValid = true;
      } else {
        isNewPinValid = false;
        isValid = false;
      }
      if (reNewPinController.text.length == 4) {
        isReNewPinValid = true;
      } else {
        isReNewPinValid = false;
        isValid = false;
      }
    } else {
      if (currentPinController.text.length >= 5 && currentPinController.text.length <= 12) {
        isCurrentPinValid = true;
      } else {
        isCurrentPinValid = false;
        isValid = false;
      }
      if (newPinController.text.length >= 5 && newPinController.text.length <= 12) {
        isNewPinValid = true;
      } else {
        isNewPinValid = false;
        isValid = false;
      }
      if (reNewPinController.text.length >= 5 && reNewPinController.text.length <= 12) {
        isReNewPinValid = true;
      } else {
        isReNewPinValid = false;
        isValid = false;
      }
    }
    update();
    if (newPinController.text != reNewPinController.text) {
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: locale.new_password_not_match,
      );
      return;
    }
    if (isValid) {
      _changeCustomCardPinRequest(pinType);
    }
  }

  /// Sends a request to change the custom card PIN and handles the response.
  void _changeCustomCardPinRequest(int pinType) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ChangeCustomCardPinRequestData changeCustomCardPinRequestData = ChangeCustomCardPinRequestData();
    changeCustomCardPinRequestData.trackingNumber = const Uuid().v4();
    changeCustomCardPinRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    changeCustomCardPinRequestData.pan = customerCard.cardNumber;
    changeCustomCardPinRequestData.oldPin =
        AppUtil.encryptDataWithRSA(data: currentPinController.text.trim(), rsaPublicKey: Constants.rsaPublicKey);
    changeCustomCardPinRequestData.newPin =
        AppUtil.encryptDataWithRSA(data: newPinController.text.trim(), rsaPublicKey: Constants.rsaPublicKey);
    changeCustomCardPinRequestData.pinType = pinType;

    isLoading = true;
    update();

    CardServices.changeCardPinArbitrary(
      changeCustomCardPinRequestData: changeCustomCardPinRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ChangeCustomCardPinResponseData _, int _)):
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void copyClipboard(String value) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Clipboard.setData(ClipboardData(text: value));
    SnackBarUtil.showInfoSnackBar(locale.password_copied);
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
