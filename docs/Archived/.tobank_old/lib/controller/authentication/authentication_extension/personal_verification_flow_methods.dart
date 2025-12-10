import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_io/io.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/authentication/kyc/request/verify_person_image_request_data.dart';
import '../../../service/authentication/kyc_services.dart';
import '../../../service/core/api_core.dart';
import '../../../ui/authentication/capture_personal_picture/capture_personal_picture_screen.dart';
import '../../../ui/authentication/capture_personal_video/camera_awesome_capture_video.dart';
import '../../../ui/authentication/capture_personal_video/capture_personal_video_screen.dart';
import '../../../ui/authentication/register/sample/take_personal_photo_sample_screen.dart';
import '../../../ui/authentication/register/sample/take_personal_video_sample_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/automate_auth/automation_controller.dart';
import '../../../util/constants.dart';
import '../../../util/enums_constants.dart';
import '../../../util/image_handler_services/image_validation_service.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../util/web_only_utils/download_txt_file_util.dart';
import '../authentication_register_controller.dart';
import 'authentication_status_flow_methods.dart';
import 'helper_tutorial_flow_methods.dart';
import 'image_utils_extension.dart';

//locale
final locale = AppLocalizations.of(Get.context!)!;
extension PersonalVerificationFlowMethods on AuthenticationRegisterController {
  /// Shows the screen for capturing a personal photo
  Future<void> showTakePersonalPhotoScreen() async {
    await stopPlayer();
    Get.to(() => CapturePersonalPictureScreen(
      returnDataFunction: (File file) async {
        print('🔴');
        print("file path : ${file.path}");
        stopPlayer();
        final CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: file.path,
          aspectRatio: const CropAspectRatio(ratioY: 4, ratioX: 3),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: locale.crop_picture,
              toolbarColor: ThemeUtil.primaryColor,
              activeControlsWidgetColor: ThemeUtil.primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              showCropGrid: false,
            ),
            IOSUiSettings(
              aspectRatioLockDimensionSwapEnabled: true,
            ),
            WebUiSettings(
              context: Get.context!,
              cropBoxResizable: true,
              viewwMode: WebViewMode.mode_2,
              modal: true,
              center: true,
              scalable: true,
              presentStyle: WebPresentStyle.page,
              rotatable: true,
              movable: true,
            ),
          ],
        );
        if (croppedFile != null) {
          final File tempUserFile = File(croppedFile.path);
          update();
          Get.to(() => TakePersonalPhotoSampleScreen(
            userFile: tempUserFile,
            returnCallback: (File? file) {
              selectedPersonalPicture = file;
              update();
            },
          ));
        }
      },
      audioTutorialFunction: () {
        playSound(helperVoiceType: HelperVoiceType.personalPhotoCamera);
      },
      visualTutorialFunction: () {
        showHelperScreen(helperType: HelperType.personalImage);
      },
      stopAudioPlayer: stopPlayer,
    ));
  }

  /// Shows the screen for capturing a personal video
  Future<void> showTakePersonalVideoScreen() async {
    await stopPlayer();
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final String? model = deviceInfo.data['model'];

    if (Platform.isAndroid && model == '23021RAAEG') {
      final File? result = await Get.to(() => const CameraAwesomeCaptureVideo());
      if (result != null) {
        Get.to(() => TakePersonalVideoSampleScreen(
          userFile: result,
          returnCallback: (File? file) {
            selectedPersonalVideo = file;
            update();
          },
        ));
      }
    } else {
      Get.to(() => CapturePersonalVideoScreen(
        returnDataFunction: (File captureFile) async {
          Get.to(() => TakePersonalVideoSampleScreen(
            userFile: captureFile,
            returnCallback: (File? file) {
              selectedPersonalVideo = file;
              update();
            },
          ));
        },
        audioTutorialFunction: () {
          playSound(helperVoiceType: HelperVoiceType.personalVideoCamera);
        },
        visualTutorialFunction: () {
          showHelperScreen(helperType: HelperType.personalVideo);
        },
        stopAudioPlayer: stopPlayer,
      ));
    }
  }

  /// Validates personal files and initiates verification if valid
  Future<void> validatePersonalPicture() async {
    print('🔵 Starting personal picture validation');
    AppUtil.hideKeyboard(Get.context!);

    final validationResult = await _validatePersonalFiles();
    if (validationResult == null || !validationResult.isValid) {
      print('🔵 File validation failed');
      if (validationResult?.errorMessage != null) {
        SnackBarUtil.showInfoSnackBar(validationResult!.errorMessage!);
      }
      return;
    }

    await _verifyPersonalImage();
  }

  /// Validates the selected personal image and video
  Future<void> _verifyPersonalImage() async {
    print('🔵 Starting personal image verification');

    if (selectedPersonalPicture == null) {
      print('🔵 No personal picture selected');
      SnackBarUtil.showInfoSnackBar(locale.please_select_face_image);
      return;
    }

    if (selectedPersonalVideo == null) {
      print('🔵 No personal video selected');
      SnackBarUtil.showInfoSnackBar(locale.please_select_face_video);
      return;
    }

    try {
      final validationResult = await ImageValidationService().validateImage(
        selectedPersonalPicture!,
        ImageValidationConfig(
          maxSizeInBytes: Constants.personalImageMaxSize,
          allowedMimeTypes: ['image/jpeg', 'image/png'],
        ),
      );

      if (!validationResult.isValid) {
        print('🔵 Image validation failed: ${validationResult.errorMessage}');
        SnackBarUtil.showInfoSnackBar(validationResult.errorMessage ?? locale.image_size_exceeded);
        return;
      }

      print('🔵 Image validation successful, proceeding with verification request');
      await _verifyPersonalImageRequest();

    } catch (e, stack) {
      print('🔵 Error in personal image verification: $e');
      await Sentry.captureException(
        e,
        stackTrace: stack,
      );
      SnackBarUtil.showInfoSnackBar(locale.error_in_image_process);
    }
  }

  /// Sends a request to verify the personal image and video
  Future<void> _verifyPersonalImageRequest() async {
    if (isLoading) return;

    String? base64Image;
    String? base64Video;

    try {
      if (kIsWeb) {
        if (selectedPersonalPicture?.path == null ||
            selectedPersonalVideo?.path == null) {
          SnackBarUtil.showSnackBar(
            title: locale.error_occurred,
            message: locale.selected_file_not_valid,
          );
          return;
        }

        print('Processing files - Image: ${selectedPersonalPicture!.path}, Video: ${selectedPersonalVideo!.path}');

        try {
          final results = await webFileService.processMultipleWebFiles([
            (
            path: selectedPersonalPicture!.path,
            type: 'image',
            ),
            (
            path: selectedPersonalVideo!.path,
            type: 'video',
            ),
          ]);

          base64Image = results[0];
          base64Video = results[1];

          if (base64Image.isEmpty || base64Video.isEmpty) {
            throw Exception(locale.file_data_not_valid);
          }
        } on TimeoutException {
          SnackBarUtil.showSnackBar(
            title: locale.error,
            message: locale.file_process_time_end,
          );
          return;
        } catch (e) {
          print('Error processing web files: $e');
          SnackBarUtil.showSnackBar(
            title: locale.error,
            message: locale.error_in_file_process(e.toString()),
          );
          return;
        }
      } else {
        try {
          base64Image = await convertFileToBase64(selectedPersonalPicture!);
          base64Video = await convertFileToBase64(selectedPersonalVideo!);
        } catch (e) {
          print('Error processing mobile files: $e');
          SnackBarUtil.showSnackBar(
            title: locale.error,
            message: locale.error_in_reading_files,
          );
          return;
        }
      }

      final String nationalIdSerial = isNationalSerialNumberUsed
          ? AppUtil.getEnglishNumbers(nationalCardSerialTextController.text)
          : AppUtil.getEnglishNumbers(nationalCardReceiptTextController.text);

      // Only on Web, trigger downloads:
      final authAuto = Get.find<AutomationController>();
      if (kIsWeb && authAuto.downloadUserBigDataToTextFile.value) {
        downloadTextFile('base64PersonalImage.txt', base64Image);
        downloadTextFile('base64PersonalVideo.txt', base64Video);
      }

      await _submitVerificationRequest(
        nationalIdSerial: nationalIdSerial,
        base64Image: base64Image,
        base64Video: base64Video,
      );

    } catch (e) {
      isLoading = false;
      update();
      print('Error in _verifyPersonalImageRequest: $e');
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: '${locale.error_in_operation} $e',
      );
    }
  }

  /// Helper method for submitting verification request
  Future<void> _submitVerificationRequest({
    required String nationalIdSerial,
    required String base64Image,
    required String base64Video,
  }) async {
    final verifyPersonImageRequestData = VerifyPersonImageRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      nationalIdSerial: nationalIdSerial.toUpperCase(),
      personImage: base64Image,
      personVideo: base64Video,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
    );

    isLoading = true;
    update();

    try {
      final result = await KycServices.verifyPersonImage(
        verifyPersonImageRequestData: verifyPersonImageRequestData,
      );

      isLoading = false;
      update();

      switch (result) {
        case Success(value: (_, 200)):
          stopPlayer();
          if (isNationalSerialNumberUsed) {
            AppUtil.gotoPageController(
              pageController: pageController,
              page: 8,
              isClosed: isClosed,
            );
          } else {
            AppUtil.nextPageController(pageController, isClosed);
          }
          update();
        case Success(value: (_, 421)):
          checkEkycStatusTimeout();
        case Success(value: _):
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
    } catch (e) {
      isLoading = false;
      update();
      rethrow;
    }
  }

  /// Deletes the selected personal photo
  void deletePersonalPhotoImage() {
    if (!isLoading) {
      selectedPersonalPicture = null;
      update();
    }
  }

  /// Deletes the selected personal video
  void deletePersonalVideo() {
    if (!isLoading) {
      selectedPersonalVideo = null;
      update();
    }
  }

  Future<ValidationResult?> _validatePersonalFiles() async {
    print('🔵 Validating personal files');

    if (selectedPersonalPicture == null || selectedPersonalVideo == null) {
      print('🔵 Missing required files');
      return ValidationResult.failure(locale.please_select_all_required_files);
    }

    bool isNationalIdValid = true;

    if (isNationalSerialNumberUsed) {
      isNationalIdValid = nationalCardSerialTextController.text.trim().isNotEmpty;
      if (!isNationalIdValid) {
        isNationalCodeValid = false;
        print('🔵 Invalid national ID serial');
        return ValidationResult.failure(locale.enter_national_card_series_number);
      }
      isNationalCodeValid = true;
    } else {
      isNationalIdValid = nationalCardReceiptTextController.text.trim().isNotEmpty;
      if (!isNationalIdValid) {
        isNationalCardReceiptValid = false;
        ///TODO -- need to delete

        print('🔵 Invalid national ID receipt');
        return ValidationResult.failure(locale.enter_national_card_receipt_number);
      }
      isNationalCardReceiptValid = true;
    }

    update();
    return isNationalIdValid ? ValidationResult.success(base64Data: '') : null;
  }
}