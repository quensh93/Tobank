import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:universal_io/io.dart';
import 'package:uuid/uuid.dart';
import 'package:zoom_id/zoom_id.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/authentication/kyc/request/get_otp_request_data.dart';
import '../../../service/authentication/kyc_services.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/enums_constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/storage_util.dart';
import '../../service/core/api_core.dart';
import '../../util/image_handler_services/image_picker_service.dart';
import '../../util/web_only_utils/web_file_processing_service.dart';
import '../main/main_controller.dart';
import 'authentication_extension/authentication_status_flow_methods.dart';
import 'authentication_extension/helper_tutorial_flow_methods.dart';
import 'authentication_extension/otp_verification_flow_methods.dart';
class AuthenticationRegisterController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  TextEditingController mobileTextEditingController = TextEditingController();
  bool isLoading = false;
  bool isRequestOtpLoading = false;
  bool isPostInquiryLoading = false;
  TextEditingController otpTextController = TextEditingController();
  int otpLength = 6;
  int counter = 0;
  bool isNationalSerialNumberUsed = false;
  File? selectedNationalCardFrontImage;
  File? selectedNationalCardBackImage;
  TextEditingController nationalCardSerialTextController =
  TextEditingController();
  TextEditingController nationalCardReceiptTextController =
  TextEditingController();
  File? selectedPersonalVideo;
  final handSignatureController = HandSignatureControl();
  TextEditingController englishNameEditingController = TextEditingController();
  TextEditingController englishFamilyTextEditingController =
  TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController postalCodeEditingController = TextEditingController();
  TextEditingController homePhoneNumberTextEditingController =
  TextEditingController();
  File? selectedPersonalPicture;
  String? errorTitle = '';
  bool hasError = false;
  bool isOtpValid = true;
  bool isNationalCodeValid = true;
  bool isNationalCardReceiptValid = true;
  File? selectedBirthCertificateFirstImage;
  File? selectedBirthCertificateSecondImage;
  bool isPostInquired = false;
  bool isEnglishFirstNameValidate = true;
  bool isEnglishLastNameValidate = true;
  bool isEmailValidate = true;
  bool isAddressValidate = true;
  bool isPostalCodeValidate = true;
  bool isHomePhoneNumberValidate = true;
  bool isCallingCode = false;
  late FlutterSoundPlayer assetsAudioPlayer;
  bool isPlayingAudio = false;
  bool audioPlayerIsInitialized = false;
  Timer? timer;
  int latestCurrentPage = 0;
  final imagePicker = ImagePickerService();
  final webFileService = WebFileProcessingService();

  /// Initializes the controller, setting up the mobile text editing controller anddetermining the initial page based on EKYC device ID.
  @override
  Future<void> onInit() async {
    mobileTextEditingController =
        TextEditingController(text: mainController.authInfoData!.mobile!);

    if (mainController.authInfoData!.ekycDeviceId != null) {
      getEkycStatusRequest();
    } else {
      pageController = PageController(initialPage: 1);
    }
    super.onInit();
  }

  Future<void> onBackPressed(bool didPop) async {
    if (didPop) {
      return;
    }
    showCloseDialog();
  }

  void requestNewOtpRequest() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final GetOtpRequestData getOtpRequestData = GetOtpRequestData(
      trackingNumber: const Uuid().v4(),
      cellphoneNumber: mobileTextEditingController.text,
      nationalCode: mainController.authInfoData!.nationalCode!,
      birthDate: mainController.authInfoData!.birthdayDate!,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
    );

    otpTextController.clear();
    isRequestOtpLoading = true;
    update();

    KycServices.getOtp(
      getOtpRequestData: getOtpRequestData,
    ).then((result) {
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
        // Will not happend
          break;
        case Failure(exception: final ApiException apiException):
          switch (apiException.type) {
            case ApiExceptionType.connectionTimeout:
              checkEkycStatusTimeout();
            default:
              SnackBarUtil.showSnackBar(
                title: locale.show_error(apiException.displayCode),
                message: apiException.displayMessage,
              );
          }
      }
    });
  }

  /// Logs out from Zoom ID and updates the EKYC provider to Yekta.
  void zoomIdLogout() {
    if (Platform.isIOS) {
      ZoomId.logOutIos(mainController.authInfoData!.mobile!);
    } else {
      if (AppUtil.isProduction()) {
        ZoomId.logOutAndroid(
          license: mainController.authInfoData!.zoomIdLicenseAndroid ??
              Constants.zoomIdLicense,
          nationalId: mainController.authInfoData!.nationalCode!,
          phone: mainController.authInfoData!.mobile!,
        );
      }
    }

    mainController.appEKycProvider = EKycProvider.yekta;
    mainController.update();
  }

  @override
  void onClose() {
    AppUtil.printResponse('disposeGetSMS');
    if (audioPlayerIsInitialized) {
      assetsAudioPlayer.closePlayer();
    }

    super.onClose();
  }

  Future<void> storeEkycDeviceId(String ekycDeviceId) async {
    mainController.authInfoData!.ekycDeviceId = ekycDeviceId;
    mainController.update();
    await StorageUtil.setAuthInfoDataSecureStorage(
        mainController.authInfoData!);
  }

  Future<void> endEkyc() async {
    Get.back<bool>(result: true);
    mainController.authInfoData!.ekycDeviceId = null;
    mainController.update();
    await StorageUtil.setAuthInfoDataSecureStorage(
        mainController.authInfoData!);
  }
}




















