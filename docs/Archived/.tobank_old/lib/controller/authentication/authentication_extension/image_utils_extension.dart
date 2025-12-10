import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_io/io.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../util/image_handler_services/image_picker_service.dart';
import '../../../util/image_handler_services/image_validation_service.dart';
import '../../../util/snack_bar_util.dart';
import '../authentication_register_controller.dart';

extension ImageUtilsExtension on AuthenticationRegisterController {
  /// Converts a File to base64 string format
  Future<String> convertFileToBase64(File file) async {
    print('📸 Converting file to base64');
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  /// Returns an ImageValidationConfig with specified settings
  ImageValidationConfig _getValidationConfig(double maxSize) {
    print('📸 Creating validation config with maxSize: $maxSize');
    return ImageValidationConfig(
      maxSizeInBytes: maxSize,
      allowedMimeTypes: ['image/jpeg', 'image/png'],
    );
  }

  /// Returns an ImageProcessConfig with specified settings
  ImageProcessConfig getImageProcessConfig({
    required double ratioY,
    required double ratioX,
    required String title,
    required double maxFileSize,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    VoidCallback? beforeProcess,
    void Function(String message)? onError,
  }) {
    print('📸 Creating image process config');
    return ImageProcessConfig(
      ratioY: ratioY,
      ratioX: ratioX,
      toolbarTitle: title,
      maxWidth: 1080.0,
      maxHeight: 1080.0,
      compressQuality: 110,
      lockAspectRatio: false,
      showCropGrid: false,
      maxFileSize: maxFileSize,
      aspectRatioPresets: aspectRatioPresets ?? [CropAspectRatioPreset.original],
      beforeProcess: beforeProcess,
      onError: onError,
    );
  }

  /// Validates an image file against size and type constraints
  Future<ValidationResult?> validateImage(
      File? image,
      double maxSize,
      String errorMessage
      ) async {
    print('📸 Starting image validation');

    if (image == null) {
      print('📸 No image selected');
      SnackBarUtil.showInfoSnackBar(errorMessage);
      return null;
    }

    try {
      final result = await ImageValidationService().validateImage(
        image,
        _getValidationConfig(maxSize),
      );

      if (!result.isValid) {
        print('📸 Validation failed: ${result.errorMessage}');
        SnackBarUtil.showInfoSnackBar(result.errorMessage!);
        return null;
      }

      return result;
    } catch (e, stack) {
      print('📸 Error during validation: $e');
      await Sentry.captureException(e, stackTrace: stack);
      return null;
    }
  }

  /// Validates personal files including picture and video
  Future<ValidationResult?> _validatePersonalFiles() async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    print('📸 Validating personal files');

    if (selectedPersonalPicture == null || selectedPersonalVideo == null) {
      print('📸 Missing required files');
      return ValidationResult.failure(locale.please_select_all_required_files);
    }

    bool isNationalIdValid = true;

    if (isNationalSerialNumberUsed) {
      isNationalIdValid = nationalCardSerialTextController.text.trim().isNotEmpty;
      if (!isNationalIdValid) {
        isNationalCodeValid = false;
        print('📸 Invalid national ID serial');
        return ValidationResult.failure(locale.enter_national_card_series_number);
      }
      isNationalCodeValid = true;
    } else {
      isNationalIdValid = nationalCardReceiptTextController.text.trim().isNotEmpty;
      if (!isNationalIdValid) {
        isNationalCardReceiptValid = false;
        print('📸 Invalid national ID receipt');
        return ValidationResult.failure(locale.enter_national_card_receipt_number);
      }
      isNationalCardReceiptValid = true;
    }

    update();
    return isNationalIdValid ? ValidationResult.success(base64Data: '') : null;
  }
}