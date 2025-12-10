import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/shaparak_hub/request/tsm/shaparak_hub_app_reactivation_request.dart';
import '../../model/shaparak_hub/request/tsm/shaparak_hub_card_enrollment_request.dart';
import '../../model/shaparak_hub/request/tsm/shaparak_hub_get_card_info_request.dart';
import '../../model/shaparak_hub/request/tsm/shaparak_hub_get_key_request.dart';
import '../../model/shaparak_hub/response/tsm/shaparak_hub_app_reactivation_response.dart';
import '../../model/shaparak_hub/response/tsm/shaparak_hub_card_enrollment_response.dart';
import '../../model/shaparak_hub/response/tsm/shaparak_hub_get_card_info_response.dart';
import '../../service/core/api_core.dart';
import '../../service/shaparak_hub_services.dart';
import '../../ui/source_card_selector/source_card_selector_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class ShaparakHubSubmitPichakController extends GetxController {
  MainController mainController = Get.find();
  bool isLoading = false;
  String? _transactionId;
  StreamSubscription? _sub;
  bool? hasPublicKey;
  bool? isReactivation;
  List<CustomerCard>? sourceCustomerCardList = [];
  bool hasError = false;
  String? _keyId;

  TextEditingController cardNumberController = TextEditingController();

  bool isCardNumberValid = true;

  CustomerCard? customerCard;

  ShaparakHubSubmitPichakController({
    this.hasPublicKey,
    this.isReactivation,
    this.sourceCustomerCardList,
  });

  @override
  Future<void> onInit() async {
    await initPlatformStateForStringUniLinks();
    super.onInit();
  }

  // Sends a Shaparak app reactivation request and handles the response,
  // launching the reactivation URL in the browser on success.
  void _shaparakAppReactivationRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    const uuid = Uuid();
    final ShaparakHubAppReactivationRequest requestData = ShaparakHubAppReactivationRequest();
    requestData.appUrlPattern = 'gpay://com.gardeshpay.app?keyId={}';
    requestData.trackingNumber = uuid.v4();
    isLoading = true;
    update();
    ShaparakHubServices.appReactivationRequest(
      requestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ShaparakHubAppReactivationResponse response, int _)):
          if (response.data!.status == 1) {
            mainController.analyticsService
                .logEvent(name: 'submit_tsm', parameters: {'type': 'reactivation', 'section': 'pichak'});
            _transactionId = response.data!.transactionId;
            final String url = response.data!.reactivationAddress!;
            mainController.getToPayment = true;
            mainController.update();
            AppUtil.launchInBrowser(url: url);
            await _storeDeviceUUID(response.deviceUUID!);
          } else {
            var message = response.message;
            if (message == null || message == '') {
              message = locale.card_registration_error;
            }
            SnackBarUtil.showInfoSnackBar(
              locale.card_registration_error,
            );
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  @override
  Future<void> onClose() async {
    if (_sub != null) {
      await _sub!.cancel();
    }
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Sends a Shaparak card submission request and handles the response,
  /// launching the registration URL in the browser on success.
  void _shaparakCardSubmitRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    const uuid = Uuid();
    final ShaparakHubCardEnrollmentRequest cardEnrollmentRequestData = ShaparakHubCardEnrollmentRequest();
    cardEnrollmentRequestData.appUrlPattern = 'gpay://com.gardeshpay.app?keyId={}';
    cardEnrollmentRequestData.trackingNumber = uuid.v4();
    isLoading = true;
    update();
    ShaparakHubServices.cardEnrollmentRequest(
      cardEnrollmentRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ShaparakHubCardEnrollmentResponse response, int _)):
          if (response.data!.status == 1) {
            mainController.analyticsService.logEvent(
                name: 'submit_tsm', parameters: {'type': 'enrollment_${hasPublicKey.toString()}', 'section': 'pichak'});
            _transactionId = response.data!.transactionId;
            final String url = response.data!.registrationAddress!;
            mainController.getToPayment = true;
            mainController.update();
            AppUtil.launchInBrowser(url: url);
          } else {
            var message = response.message;
            if (message == null || message == '') {
              message = locale.card_registration_error;
            }
            SnackBarUtil.showInfoSnackBar(
              locale.card_registration_error,
            );
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves the Shaparak Hub public key and handles the response,
  /// either navigating back or proceeding with card information retrieval.
  void _getKey() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ShaparakHubGetKeyRequest keyRequestData = ShaparakHubGetKeyRequest();
    keyRequestData.transactionId = _transactionId;
    keyRequestData.keyId = _keyId;
    isLoading = true;
    update();
    ShaparakHubServices.getKey(keyRequestData).then((response) async {
      isLoading = false;
      update();
      if (response.statusCode == 200 && response.status == 1) {
        if (response.keyData != null) {
          await AppUtil.saveShaparakHubPublicKey(response.keyData);
          if (isReactivation!) {
            Get.back();
            Timer(Constants.duration300, () {
              SnackBarUtil.showSuccessSnackBar(locale.card_registration_success);
            });
          } else {
            _getCardInfoRequest(true);
          }
        } else {
          hasError = true;
          update();
          SnackBarUtil.showInfoSnackBar(
            locale.card_registration_failed
          );
        }
      } else if (response.statusCode == 400) {
        hasError = true;
        update();
        SnackBarUtil.showSnackBar(
          title: locale.show_error(response.statusCode??400),
          message: response.errorResponseData.message ?? '',
        );
      } else {
        hasError = true;
        update();
        SnackBarUtil.showExceptionErrorSnackBar(response.statusCode);
      }
    });
  }

  /// Retrieves Shaparak Hub card information and handles the response,
  /// navigating back and displaying a success message on success.
  void _getCardInfoRequest(bool deviceUUID) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ShaparakHubGetCardInfoRequest cardInfoRequestData = ShaparakHubGetCardInfoRequest();
    cardInfoRequestData.transactionId = _transactionId;
    cardInfoRequestData.sourceCard = customerCard!.cardNumber;
    //TODO check for current card number and return masked of it.
    // if did not match, do NOT request to get card info and show error message
    // that 'you select one card that not entered in shaparak hub
    ShaparakHubServices.getCardInfo(
      cardInfoRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ShaparakHubGetCardInfoResponse response, int _)):
          if (response.data?.cardId != null) {
            if (response.deviceUUID != null) {
              await _storeDeviceUUID(response.deviceUUID!);
            } else if (response.data!.deviceUUID != null) {
              await _storeDeviceUUID(response.data!.deviceUUID);
            }
            Get.back();
            Timer(Constants.duration300, () {
              SnackBarUtil.showSuccessSnackBar(locale.card_registration_success);
            });
          } else {
            hasError = true;
            update();
            SnackBarUtil.showInfoSnackBar(
              locale.card_registration_failed
            );
          }
        case Failure(exception: final ApiException apiException):
          hasError = true;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Handles the returned link from the Shaparak Hub, either retrieving card information
  /// or initiating key retrieval.
  void _handleReturnedLink(Uri link) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    mainController.analyticsService.logEvent(name: 'handle_tsm', parameters: {
      'has_key': hasPublicKey.toString(),
      'is_reactivation': isReactivation.toString(),
      'section': 'pichak'
    });
    if (hasPublicKey!) {
      _getCardInfoRequest(false);
    } else {
      final uri = link;
      final Map<String, String> params = uri.queryParameters;
      _keyId = params['keyId'];
      AppUtil.printResponse(link.toString());
      if (_keyId != null && _keyId != 'null') {
        _getKey();
      } else {
        SnackBarUtil.showInfoSnackBar(
          locale.submit_failed_card
        );
      }
    }
  }

  /// An implementation using a [String] link
  Future<void> initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    final appLinks = AppLinks();
    _sub = appLinks.uriLinkStream.listen((Uri? link) {
      if(link != null){
        _handleReturnedLink(link);
      }
    }, onError: (Object err) {
      AppUtil.printResponse('error:$err');
    });
  }

  /// Submits the Shaparak Hub request, either retrieving the key, initiating reactivation, or submitting card information.
  void submit() {
    hasError = false;
    update();
    if (_keyId != null && _keyId != 'null') {
      _getKey();
    } else {
      if (isReactivation!) {
        _shaparakAppReactivationRequest();
      } else {
        if (customerCard != null) {
          _shaparakCardSubmitRequest();
        } else {
          isCardNumberValid = false;
          update();
        }
      }
    }
  }

  void showSelectCardScreen() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    Get.to(() => SourceCardSelectorScreen(
          title: locale.select_card_,
          description: locale.registered_cards,
          checkIsTransfer: false,
          isPichak: false,
          returnDataFunction: (customerCard, bankInfo) {
            this.customerCard = customerCard;
            cardNumberController.text = AppUtil.splitCardNumber(customerCard.cardNumber!, '-');
            isCardNumberValid = true;
            update();
          },
        ));
  }

  /// Stores the device UUID in the authentication information and secure storage.
  Future<void> _storeDeviceUUID(String? deviceUUID) async {
    if (deviceUUID != null) {
      mainController.authInfoData!.deviceUUID = deviceUUID;
      mainController.update();
      await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
    }
  }
}
