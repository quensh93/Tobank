import 'dart:async';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../model/shaparak_hub/request/tsm/shaparak_hub_app_reactivation_request.dart';
import '../../model/shaparak_hub/request/tsm/shaparak_hub_card_enrollment_request.dart';
import '../../model/shaparak_hub/request/tsm/shaparak_hub_get_card_info_request.dart';
import '../../model/shaparak_hub/request/tsm/shaparak_hub_get_key_request.dart';
import '../../model/shaparak_hub/response/tsm/shaparak_hub_app_reactivation_response.dart';
import '../../model/shaparak_hub/response/tsm/shaparak_hub_card_enrollment_response.dart';
import '../../model/shaparak_hub/response/tsm/shaparak_hub_get_card_info_response.dart';
import '../../service/core/api_core.dart';
import '../../service/shaparak_hub_services.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class ShaparakHubSubmitController extends GetxController {
  MainController mainController = Get.find();
  bool isLoading = false;
  String? _transactionId;
  StreamSubscription? _sub;
  bool? hasPublicKey;
  bool? isReactivation;
  bool hasError = false;
  String? _keyId;
  String? cardNumber;

  ShaparakHubSubmitController({
    this.cardNumber,
    this.hasPublicKey,
    this.isReactivation,
  });

  @override
  Future<void> onInit() async {
    await initPlatformStateForStringUniLinks();
    super.onInit();
  }

  /// Sends a request to reactivate the Shaparak Hub app and handles the response.
  void _shaparakAppReactivationRequest() {
//locale
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
                .logEvent(name: 'submit_tsm', parameters: {'type': 'reactivation', 'section': 'card_to_card'});
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

  /// Sends a request to submit a card to Shaparak Hub and handles the response.
  void _shaparakCardSubmitRequest() {
//locale
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
                name: 'submit_tsm',
                parameters: {'type': 'enrollment_${hasPublicKey.toString()}', 'section': 'card_to_card'});
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

  /// Sends a request to get a key from Shaparak Hub and handles the response.
  void _getKey() {
//locale
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
            locale.card_registration_failed,
          );
        }
      } else if (response.statusCode == 400) {
        hasError = true;
        update();
        SnackBarUtil.showSnackBar(
          title: locale.show_error(response.statusCode.toString as int),
          message: response.errorResponseData.message ?? '',
        );
      } else {
        hasError = true;
        update();
        SnackBarUtil.showExceptionErrorSnackBar(response.statusCode);
      }
    });
  }

  /// Sends a request to get card information from Shaparak Hub and handles the response.
  void _getCardInfoRequest(bool deviceUUID) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ShaparakHubGetCardInfoRequest cardInfoRequestData = ShaparakHubGetCardInfoRequest();
    cardInfoRequestData.transactionId = _transactionId;
    cardInfoRequestData.sourceCard = cardNumber;
    //TODO check for current card number and return masked of it.
    // if did not match, do NOT request to get card info and show error message
    // that 'you select one card that not entered in shaparak hub
    isLoading = true;
    update();
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
            SnackBarUtil.showSnackBar(title: '', message: locale.card_registration_failed);
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

  void _handleReturnedLink(Uri link) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    mainController.analyticsService.logEvent(name: 'handle_tsm', parameters: {
      'has_key': hasPublicKey.toString(),
      'is_reactivation': isReactivation.toString(),
      'section': 'card_to_card'
    });
    if (hasPublicKey!) {
      _getCardInfoRequest(false);
    } else {
      final Map<String, String> params = link.queryParameters;
      _keyId = params['keyId'];
      if (_keyId != null && _keyId != 'null') {
        _getKey();
      } else {
        SnackBarUtil.showInfoSnackBar(
          locale.card_registration_failed,
        );
      }
    }
  }

  /// An implementation using a [String] link
  Future<void> initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    final appLinks = AppLinks();
    _sub = appLinks.uriLinkStream.listen((Uri? link) {
      if (link != null) {
        _handleReturnedLink(link);
      }
    }, onError: (Object err) {
      AppUtil.printResponse('error:$err');
    });
  }

  void submit() {
    hasError = false;
    update();
    if (_keyId != null && _keyId != 'null') {
      _getKey();
    } else {
      if (isReactivation!) {
        _shaparakAppReactivationRequest();
      } else {
        _shaparakCardSubmitRequest();
      }
    }
  }

  Future<void> _storeDeviceUUID(String? deviceUUID) async {
    if (deviceUUID != null) {
      mainController.authInfoData!.deviceUUID = deviceUUID;
      mainController.update();
      await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
    }
  }
}
