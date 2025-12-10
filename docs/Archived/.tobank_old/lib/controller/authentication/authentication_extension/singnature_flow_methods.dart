import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_io/io.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/authentication/kyc/request/register_signature_image_request_data.dart';
import '../../../service/authentication/kyc_services.dart';
import '../../../service/core/api_core.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/storage_util.dart';
import '../authentication_register_controller.dart';
import 'authentication_status_flow_methods.dart';
import 'helper_tutorial_flow_methods.dart';
import 'otp_verification_flow_methods.dart';

extension SignatureFlowMethods on AuthenticationRegisterController {
  /// Clears the current signature from the signature pad
  void clearSignature() {
    if (!isLoading) {
      handSignatureController.clear();
      update();
    }
  }

  /// Main entry point for signature submission flow
  Future<void> submitSignature() async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    print('🔵 Starting signature submission');

    final signatureData = await handSignatureController.toImage();
    if (signatureData == null) {
      print('🔵 No signature data available');
      SnackBarUtil.showInfoSnackBar(locale.please_draw_your_signature);
      return;
    }

    final sizeInBytes = signatureData.lengthInBytes;
    print('🔵 Signature size: $sizeInBytes bytes');

    if (sizeInBytes < Constants.signatureMinSize) {
      print('🔵 Signature too small');
      await _logSignatureSize(sizeInBytes);
      SnackBarUtil.showInfoSnackBar(locale.please_draw_signature_carefully);
      return;
    }

    String? base64Image;
    try {
      base64Image = await _processSignatureData(signatureData);
      if (base64Image == null || base64Image.isEmpty) {
        throw Exception('Signature processing failed');
      }
    } catch (e) {
      print('🔵 Error processing signature: $e');
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: locale.error_signature_process,
      );
      return;
    }

    await _uploadSignature(base64Image);
  }

  /// Processes signature data into base64 format
  Future<String?> _processSignatureData(ByteData signatureData) async {
    print('🔵 Processing signature data');

    try {
      if (kIsWeb) {
        final bytes = signatureData.buffer.asUint8List(
          signatureData.offsetInBytes,
          signatureData.lengthInBytes,
        );
        return base64Encode(bytes);
      }

      // Mobile platform processing
      final tempDir = await getTemporaryDirectory();
      final fileName = 'signature_${DateTime.now().millisecondsSinceEpoch}.png';
      final filePath = '${tempDir.path}/$fileName';

      final bytes = signatureData.buffer.asUint8List(
        signatureData.offsetInBytes,
        signatureData.lengthInBytes,
      );

      final File signatureFile = await File(filePath).writeAsBytes(bytes);
      final imageBytes = await signatureFile.readAsBytes();
      return base64Encode(imageBytes);
    } catch (e, stack) {
      print('🔵 Error in signature processing: $e');
      await Sentry.captureException(e, stackTrace: stack);
      return null;
    }
  }

  /// Uploads the signature to the server
  Future<void> _uploadSignature(String base64Image) async {
    print('🔵 Starting signature upload');

    if (isLoading) {
      print('🔵 Already processing, skipping upload');
      return;
    }

    final request = RegisterSignatureImageRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      personSignatureImage: base64Image,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
    );

    isLoading = true;
    update();

    try {
      final result = await KycServices.registerSignatureImage(
        registerSignatureImageRequestData: request,
      );

      switch (result) {
        case Success(value: (_, 200)):
          print('🔵 Signature upload successful');
          await StorageUtil.setBase64UserSignatureImage(base64Image);
          AppUtil.nextPageController(pageController, isClosed);
          stopPlayer();
        case Success(value: (_, 421)):
          checkEkycStatusTimeout();
        case Failure(exception: final ApiException apiException):
          handleApiError(apiException);  // Using this to explicitly reference the extension method
        default:
        // Should not happen
          break;
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Helper method to log signature size metrics
  Future<void> _logSignatureSize(int sizeInBytes) async {
    final sizeInKB = sizeInBytes / 1024;
    await Sentry.captureMessage(
      'authMediaSize',
      params: [{'SignatureImage KB': sizeInKB}],
    );
  }
}