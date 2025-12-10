import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_io/io.dart';
import 'package:uuid/uuid.dart';
import '../../../model/authentication/kyc/request/upload_national_id_back_image_request_data.dart';
import '../../../model/authentication/kyc/request/upload_national_id_front_image_request_data.dart';
import '../../../service/authentication/kyc_services.dart';
import '../../../ui/authentication/register/sample/national_card_back_sample_screen.dart';
import '../../../ui/authentication/register/sample/national_card_front_sample_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/automate_auth/automation_controller.dart';
import '../../../util/constants.dart';
import '../../../util/image_handler_services/image_picker_service.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/web_only_utils/download_txt_file_util.dart';
import '../authentication_register_controller.dart';
import 'api_handling_extension.dart';
import 'helper_tutorial_flow_methods.dart';
import 'image_utils_extension.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';


//locale
final locale = AppLocalizations.of(Get.context!)!;

extension NationalCardFlowMethods on AuthenticationRegisterController {
  /// Initiates the flow for capturing the front side of the national card.
  void goFrontNationalCardReceiptFlow() {
    AppUtil.hideKeyboard(Get.context!);
    isNationalSerialNumberUsed = false;
    update();
    AppUtil.gotoPageController(
      pageController: pageController,
      page: 5,
      isClosed: isClosed,
    );
    stopPlayer();
  }

  /// Selects an image for the front of the national card, either from the camera or gallery,
  /// and handles permissions and image processing.
  Future<void> selectNationalCardFrontImage(ImageSource imageSource) async {
    print('🔴 Starting national card front image selection with source: $imageSource');

    final config = ImageProcessConfig(
      ratioY: imageSource == ImageSource.camera ? 6 : 3,
      ratioX: imageSource == ImageSource.camera ? 9 : 5,
      toolbarTitle: locale.crop_picture,
      maxWidth: 1080.0,
      maxHeight: 1080.0,
      compressQuality: 110,
      lockAspectRatio: false,
      showCropGrid: false,


      maxFileSize: Constants.nationalCardMaxSize,
      aspectRatioPresets: [CropAspectRatioPreset.original],
      beforeProcess: () {
        print('🔴 Executing stopPlayer before process');
        stopPlayer();
      },
      onError: (message) async {
        print('🔴 Error occurred: $message');
        await Sentry.captureException(
          message,
          stackTrace: StackTrace.current,
        );
      },
    );

    print('🔴 Awaiting image processing');
    final processedImage = await imagePicker.selectAndProcessImage(
      source: imageSource,
      config: config,
    );

    print('🔴 Process complete, image: ${processedImage?.path}');

    if (processedImage != null) {
      print('🔴 Navigating to sample screen');
      await Get.to(() => NationalCardFrontSampleScreen(
        userFile: processedImage,
        returnCallback: (File? file) {
          print('🔴 Sample screen returned: ${file?.path}');
          selectedNationalCardFrontImage = file;
          update();
        },
      ));
    } else {
      print('🔴 No image to process');
    }
  }

  /// Validates the selected national card front image, checking its size
  /// and triggering the validation request if it meets the requirements.
  Future<void> validateNationalCardFront() async {
    if (selectedNationalCardFrontImage == null) {
      SnackBarUtil.showInfoSnackBar(locale.please_select_national_card_front);
      return;
    }

    final validationResult = await validateImage(
        selectedNationalCardFrontImage,
        Constants.nationalCardMaxSize,
        locale.please_select_national_card_front
    );

    if (validationResult != null) {
      await _validateNationalCardFrontRequest(validationResult.base64Data!);
    }
  }

  /// Sends a request to validate the national card front image and handles
  /// the response, either navigating to the next page,
  /// handling timeouts, or displaying errors.
  Future<void> _validateNationalCardFrontRequest(String base64Image) async {
    final uploadRequest = UploadNationalIdFrontImageRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      nationalIdFrontImage: base64Image,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
    );

    final authAuto = Get.find<AutomationController>();
    if (kIsWeb && authAuto.downloadUserBigDataToTextFile.value) {
      downloadTextFile('base64ImageFrontNationalCard.txt', base64Image);
    }

    final (success, _) = await handleUploadWithResponse(() =>
        KycServices.uploadNationalCodeFront(
          uploadNationalIdFrontImageRequestData: uploadRequest,
        ));

    if (success) {
      AppUtil.nextPageController(pageController, isClosed);
      stopPlayer();
    }
  }

  void nextPageNationalCardFront() {
    if (selectedNationalCardFrontImage != null) {
      validateNationalCardFront();
    } else {
      SnackBarUtil.showInfoSnackBar(locale.please_select_national_card_front);
    }
  }

  void nextPageNationalCardBack() {
    if (selectedNationalCardBackImage != null) {
      validateNationalCardBack();
    } else {
      SnackBarUtil.showInfoSnackBar(locale.please_select_national_card_back);
    }
  }

  /// Selects an image for the back of the national card, either from the camera or gallery,
  /// and handles permissions and image processing.
  Future<void> selectNationalCardBackImage(ImageSource imageSource) async {
    print('🔵 Starting national card back image selection with source: $imageSource');

    final config = getImageProcessConfig(
      ratioY: imageSource == ImageSource.camera ? 6 : 3,
      ratioX: imageSource == ImageSource.camera ? 9 : 5,
      title: locale.crop_picture,
      maxFileSize: Constants.nationalCardMaxSize,
      aspectRatioPresets: [CropAspectRatioPreset.original],
    );

    print('🔵 Awaiting image processing');
    final processedImage = await imagePicker.selectAndProcessImage(
      source: imageSource,
      config: config,
    );

    print('🔵 Process complete, image: ${processedImage?.path}');

    if (processedImage != null) {
      print('🔵 Navigating to sample screen');
      await Get.to(() => NationalCardBackSampleScreen(
        userFile: processedImage,
        returnCallback: (File? file) {
          print('🔵 Sample screen returned: ${file?.path}');
          selectedNationalCardBackImage = file;
          update();
        },
      ));
    } else {
      print('🔵 No image to process');
    }
  }

  /// Validates the selected national card back image, checking its size
  /// and triggering the validation request if it meets the requirements.
  Future<void> validateNationalCardBack() async {
    print('🔵 Starting national card back validation');

    if (selectedNationalCardBackImage == null) {
      print('🔵 No image selected');
      SnackBarUtil.showInfoSnackBar(locale.please_select_national_card_back);
      return;
    }

    final validationResult = await validateImage(
        selectedNationalCardBackImage,
        Constants.nationalCardMaxSize,
        locale.please_select_national_card_back
    );

    if (validationResult != null) {
      await _validateNationalCardBackRequest(validationResult.base64Data!);
    }
  }

  /// Sends a request to validate the national card back image and handles
  /// the response, either navigating to the next page, handling timeouts, or displaying errors.
  Future<void> _validateNationalCardBackRequest([String? validatedBase64Image]) async {
    print('🔵 Starting national card back upload request');

    if (isLoading) {
      print('🔵 Already processing, skipping request');
      return;
    }

    String base64Image = validatedBase64Image ?? '';

    if (validatedBase64Image == null) {
      print('🔵 No pre-validated image, converting to base64');
      final validationResult = await validateImage(
          selectedNationalCardBackImage,
          Constants.nationalCardMaxSize,
          locale.please_select_national_card_back
      );

      if (validationResult == null) return;
      base64Image = validationResult.base64Data!;
    }


    final authAuto = Get.find<AutomationController>();
    if (kIsWeb && authAuto.downloadUserBigDataToTextFile.value) {
      downloadTextFile('base64ImageBackNationalCard.txt', base64Image);
    }

    print('🔵 Preparing upload request');
    final uploadRequest = UploadNationalIdBackImageRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      nationalIdBackImage: base64Image,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
    );

    final (success, response) = await handleUploadWithResponse(() =>
        KycServices.uploadNationalCodeBack(
          uploadNationalIdBackImageRequestData: uploadRequest,
        )
    );

    if (success && response != null) {
      print('🔵 Upload successful, updating UI');
      isNationalSerialNumberUsed = true;
      nationalCardSerialTextController.text = response.data!.nationalIdSerial ?? '';
      AppUtil.nextPageController(pageController, isClosed);
      stopPlayer();
      update();
    }
  }

  void deleteNationalCardFrontImage() {
    if (!isLoading) {
      selectedNationalCardFrontImage = null;
      update();
    }
  }

  void deleteNationalCardBackImage() {
    if (!isLoading) {
      selectedNationalCardBackImage = null;
      update();
    }
  }
}