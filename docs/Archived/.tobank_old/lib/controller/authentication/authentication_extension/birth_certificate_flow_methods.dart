import 'dart:async';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_io/io.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/authentication/kyc/request/upload_birth_certificate_comments_image_request_data.dart';
import '../../../model/authentication/kyc/request/upload_birth_certificate_main_image_request_data.dart';
import '../../../service/authentication/kyc_services.dart';
import '../../../ui/authentication/register/sample/birth_certificate_first_sample_screen.dart';
import '../../../ui/authentication/register/sample/birth_certificate_second_sample_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/image_handler_services/image_picker_service.dart';
import '../../../util/snack_bar_util.dart';
import '../authentication_register_controller.dart';
import 'api_handling_extension.dart';
import 'helper_tutorial_flow_methods.dart';
import 'image_utils_extension.dart';
//locale
final locale = AppLocalizations.of(Get.context!)!;
extension BirthCertificateFlowMethods on AuthenticationRegisterController {
  /// Selects an image for the first page of the birth certificate, either from the camera or gallery,
  /// and handles permissions and image processing.
  Future<void> selectBirthCertificateFirstImage(ImageSource imageSource) async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    print('🔵 Starting birth certificate first image selection with source: $imageSource');

    final config = ImageProcessConfig(
      ratioY: 4,
      ratioX: 3,
      toolbarTitle: locale.crop_picture,
      maxWidth: 1080.0,
      maxHeight: 1080.0,
      compressQuality: 110,
      lockAspectRatio: false,
      showCropGrid: false,
      maxFileSize: Constants.birthCertificateMaxSize,
      aspectRatioPresets: [CropAspectRatioPreset.original],
      beforeProcess: () {
        print('🔵 Running pre-process steps');
        stopPlayer();
      },
      onError: (String message) async {
        print('🔵 Error in image processing: $message');
        await Sentry.captureException(
          message,
          stackTrace: StackTrace.current,
        );
      },
    );

    print('🔵 Awaiting image processing');
    final processedImage = await imagePicker.selectAndProcessImage(
      source: imageSource,
      config: config,
    );

    print('🔵 Process complete, image: ${processedImage?.path}');

    if (processedImage != null) {
      print('🔵 Navigating to sample screen');
      await Get.to(() => BirthCertificateFirstSampleScreen(
        userFile: processedImage,
        returnCallback: (File? file) {
          print('🔵 Sample screen returned: ${file?.path}');
          selectedBirthCertificateFirstImage = file;
          update();
        },
      ));
    } else {
      print('🔵 No image to process');
    }
  }

  /// Validates the selected birth certificate's first image, checking its size
  /// and triggering the upload request if it meets the requirements.
  Future<void> validateBirthCertificateFirst() async {
    print('🔵 Starting birth certificate first page validation');

    if (selectedBirthCertificateFirstImage == null) {
      print('🔵 No image selected');
      SnackBarUtil.showInfoSnackBar(locale.please_select_first_page_of_birth_certificate);
      return;
    }

    final validationResult = await validateImage(
        selectedBirthCertificateFirstImage,
        Constants.birthCertificateMaxSize,
        locale.please_select_first_page_of_birth_certificate
    );

    if (validationResult != null) {
      await _uploadBirthCertificateFirstImageRequest(validationResult.base64Data!);
    }
  }

  /// Sends a request to upload the birth certificate's first image
  /// and handles the response, either navigating to the next page,
  /// handling timeouts, or displaying errors.
  Future<void> _uploadBirthCertificateFirstImageRequest(String base64Image) async {
    final uploadRequest = UploadBirthCertificateMainImageRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      birthCertificateMainImage: base64Image,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
    );

    final (success, _) = await handleUploadWithResponse(() =>
        KycServices.uploadBirthCertificateMainImage(
          uploadBirthCertificateMainImageRequestData: uploadRequest,
        )
    );

    if (success) {
      AppUtil.nextPageController(pageController, isClosed);
      stopPlayer();
    }
  }

  void nextPageBirthCertificateFirstPage() {
    if (selectedBirthCertificateFirstImage != null) {
      validateBirthCertificateFirst();
    } else {
      SnackBarUtil.showInfoSnackBar(locale.please_select_first_page_of_birth_certificate);
    }
  }

  void nextPageBirthCertificateSecondPage() {
    if (selectedBirthCertificateSecondImage != null) {
      validateBirthCertificateSecond();
    } else {
      SnackBarUtil.showSnackBar(
          title: locale.warning,
          message: locale.please_select_third_and_fourth_pages_of_birth_certificate
      );
    }
  }

  /// Selects an image for the second page of the birth certificate, either from the camera or gallery,
  /// and handles permissions and image processing.
  Future<void> selectBirthCertificateSecondImage(ImageSource imageSource) async {
    print('🔵 Starting birth certificate second image selection with source: $imageSource');

    final config = ImageProcessConfig(
      ratioY: 4,
      ratioX: 3,
      toolbarTitle: locale.crop_picture,
      maxWidth: 1080.0,
      maxHeight: 1080.0,
      compressQuality: 110,
      lockAspectRatio: false,
      showCropGrid: false,
      maxFileSize: Constants.birthCertificateMaxSize,
      aspectRatioPresets: [CropAspectRatioPreset.original],
      beforeProcess: () {
        print('🔵 Running pre-process steps');
        stopPlayer();
      },
      onError: (String message) async {
        print('🔵 Error in image processing: $message');
        await Sentry.captureException(
          message,
          stackTrace: StackTrace.current,
        );
      },
    );

    print('🔵 Awaiting image processing');
    final processedImage = await imagePicker.selectAndProcessImage(
      source: imageSource,
      config: config,
    );

    print('🔵 Process complete, image: ${processedImage?.path}');

    if (processedImage != null) {
      print('🔵 Navigating to sample screen');
      await Get.to(() => BirthCertificateSecondSampleScreen(
        userFile: processedImage,
        returnCallback: (File? file) {
          print('🔵 Sample screen returned: ${file?.path}');
          selectedBirthCertificateSecondImage = file;
          update();
        },
      ));
    } else {
      print('🔵 No image to process');
    }
  }

  /// Validates the selected birth certificate's second image, checking its size
  /// and triggering the validation request if it meets the requirements.
  Future<void> validateBirthCertificateSecond() async {
    print('🔵 Starting birth certificate second page validation');

    if (selectedBirthCertificateSecondImage == null) {
      print('🔵 No image selected');
      SnackBarUtil.showInfoSnackBar(locale.please_select_second_page_of_birth_certificate);
      return;
    }

    final validationResult = await validateImage(
        selectedBirthCertificateSecondImage,
        Constants.birthCertificateMaxSize,
        locale.please_select_second_page_of_birth_certificate
    );

    if (validationResult != null) {
      await _uploadBirthCertificateSecondImageRequest(validationResult.base64Data!);
    }
  }

  /// Sends a request to upload the birth certificate's second image
  /// and handles the response, either navigating to the next page,
  /// handling timeouts, or displaying errors.
  Future<void> _uploadBirthCertificateSecondImageRequest(String base64Image) async {
    final uploadRequest = UploadBirthCertificateCommentsImageRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      birthCertificateCommentsImage: base64Image,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
    );

    final (success, _) = await handleUploadWithResponse(() =>
        KycServices.uploadBirthCertificateCommentsImage(
          uploadBirthCertificateCommentsImageRequestData: uploadRequest,
        )
    );

    if (success) {
      AppUtil.nextPageController(pageController, isClosed);
      stopPlayer();
    }
  }

  /// Deletes the selected first birth certificate image
  void deleteBirthCertificateFirstImage() {
    if (!isLoading) {
      selectedBirthCertificateFirstImage = null;
      update();
    }
  }

  /// Deletes the selected second birth certificate image
  void deleteBirthCertificateSecondImage() {
    if (!isLoading) {
      selectedBirthCertificateSecondImage = null;
      update();
    }
  }
}