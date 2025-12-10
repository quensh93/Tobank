import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sentry/sentry.dart';
import 'package:universal_io/io.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../ui/authentication/capture_personal_picture/capture_pwa_national_card_picture_screen.dart';
import '../dialog_util.dart';
import '../file_util.dart';
import '../permission_handler.dart';
import '../theme/theme_util.dart';

@immutable
class ImageProcessConfig {
  final double ratioY;
  final double ratioX;
  final String toolbarTitle;
  final double? maxWidth;
  final double? maxHeight;
  final int imageQuality;
  final int compressQuality;
  final bool lockAspectRatio;
  final bool showCropGrid;
  final double maxFileSize;
  final List<CropAspectRatioPreset>? aspectRatioPresets;
  final VoidCallback? beforeProcess;  // Changed to VoidCallback
  final void Function(String message)? onError;

  const ImageProcessConfig({
    required this.ratioY,
    required this.ratioX,
    this.toolbarTitle = 'برش عکس',
    this.maxWidth = 1080.0,
    this.maxHeight = 1080.0,
    this.imageQuality = 100,
    this.compressQuality = 110,
    this.lockAspectRatio = false,
    this.showCropGrid = false,
    this.maxFileSize = 2 * 1024 * 1024, // 2MB default
    this.aspectRatioPresets,
    this.beforeProcess,
    this.onError,
  });

  ImageProcessConfig copyWith({
    double? ratioY,
    double? ratioX,
    String? toolbarTitle,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    int? compressQuality,
    bool? lockAspectRatio,
    bool? showCropGrid,
    double? maxFileSize,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    VoidCallback? beforeProcess,
    void Function(String message)? onError,
  }) {
    return ImageProcessConfig(
      ratioY: ratioY ?? this.ratioY,
      ratioX: ratioX ?? this.ratioX,
      toolbarTitle: toolbarTitle ?? this.toolbarTitle,
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      imageQuality: imageQuality ?? this.imageQuality,
      compressQuality: compressQuality ?? this.compressQuality,
      lockAspectRatio: lockAspectRatio ?? this.lockAspectRatio,
      showCropGrid: showCropGrid ?? this.showCropGrid,
      maxFileSize: maxFileSize ?? this.maxFileSize,
      aspectRatioPresets: aspectRatioPresets ?? this.aspectRatioPresets,
      beforeProcess: beforeProcess ?? this.beforeProcess,
      onError: onError ?? this.onError,
    );
  }
}

class ImagePickerService {
  static final ImagePickerService _instance = ImagePickerService._internal();
  factory ImagePickerService() => _instance;
  ImagePickerService._internal();

  final _picker = ImagePicker();

  Future<File?> selectAndProcessImage({
    required ImageSource source,
    required ImageProcessConfig config,
  }) async {
    try {
      print('🔵 Starting image selection process with source: $source');

      if (config.beforeProcess != null) {
        print('🔵 Executing beforeProcess callback');
        config.beforeProcess!();
      }

      if (source == ImageSource.camera && !await _checkCameraPermission()) {
        print('🔵 Camera permission not granted');
        return null;
      }

      if (kIsWeb && source == ImageSource.camera) {
        print('🔵 Web camera flow initiated');
        final Completer<File?> completer = Completer<File?>();

        Get.to(() => CapturePwaNationalCardPictureScreen(
          returnDataFunction: (File file) async {
            print('🔵 Web camera captured file: ${file.path}');
            try {
              final processedFile = await _processWebCameraImage(file, config);
              completer.complete(processedFile);
            } catch (e) {
              print('🔵 Error processing web camera image: $e');
              completer.complete(null);
            }
          },
          stopAudioPlayer: () {
            print('🔵 Stopping audio player');
            config.beforeProcess?.call();
          },
        ));

        return completer.future;
      }

      final XFile? selectedImage = await _picker.pickImage(
        source: source,
        maxWidth: config.maxWidth,
        maxHeight: config.maxHeight,
        imageQuality: config.imageQuality,
      );

      if (selectedImage == null) {
        print('🔵 No image selected');
        return null;
      }

      print('🔵 Processing selected image: ${selectedImage.path}');
      return _processSelectedImage(selectedImage.path, config);
    } catch (e, stack) {
      print('🔵 Error in selectAndProcessImage: $e');
      await Sentry.captureException(e, stackTrace: stack);
      config.onError?.call(e.toString());
      return null;
    }
  }

  Future<File?> _processWebCameraImage(File file, ImageProcessConfig config) async {
    print('🔵 Processing web camera image: ${file.path}');
    config.beforeProcess?.call();

    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,

      aspectRatio: CropAspectRatio(
        ratioY: config.ratioY,
        ratioX: config.ratioX,
      ),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: config.toolbarTitle,
          toolbarColor: ThemeUtil.primaryColor,
          activeControlsWidgetColor: ThemeUtil.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: config.lockAspectRatio,
          showCropGrid: config.showCropGrid,
          aspectRatioPresets: config.aspectRatioPresets ?? [
            CropAspectRatioPreset.original,
          ],
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
      print('🔵 Image cropped successfully: ${croppedFile.path}');
      return File(croppedFile.path);
    }

    print('🔵 Cropping cancelled or failed');
    return null;
  }

  Future<File?> _processSelectedImage(String imagePath, ImageProcessConfig config) async {
    try {
      print('🔵 Starting image processing. Path: $imagePath');

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: CropAspectRatio(
          ratioY: config.ratioY,
          ratioX: config.ratioX,
        ),
        compressQuality: config.compressQuality,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: config.toolbarTitle,
            toolbarColor: ThemeUtil.primaryColor,
            activeControlsWidgetColor: ThemeUtil.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: config.lockAspectRatio,
            showCropGrid: config.showCropGrid,
            aspectRatioPresets: config.aspectRatioPresets ?? [
              CropAspectRatioPreset.original,
            ],
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

      if (croppedFile == null) {
        print('🔵 Cropping cancelled or failed');
        return null;
      }

      print('🔵 Image cropped successfully: ${croppedFile.path}');
      return kIsWeb ? File(croppedFile.path) : await _processNativeImage(croppedFile.path, config);
    } catch (e) {
      print('🔵 Error in _processSelectedImage: $e');
      config.onError?.call(e.toString());
      return null;
    }
  }

  Future<bool> _checkCameraPermission() async {
    try {
      final isGranted = await PermissionHandler.camera.isGranted;
      if (!isGranted) {
        _showCameraPermissionDialog();
      }
      return isGranted;
    } catch (e) {
      print('🔵 Error checking camera permission: $e');
      return false;
    }
  }

  void _showCameraPermissionDialog() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
      buildContext: Get.context!,
      message: locale.access_to_camera,
      description: locale.for_scanning_need_access_to_camera,
      positiveMessage: locale.confirmation,
      negativeMessage: locale.cancel,
      positiveFunction: () async {
        Get.back();
        final isGranted = await PermissionHandler.camera.handlePermission();
        if (Platform.isIOS && !isGranted) {
          AppSettings.openAppSettings();
        }
      },
      negativeFunction: () {
        Get.back();
      },
    );
  }

  Future<File?> _processNativeImage(String imagePath, ImageProcessConfig config) async {
    try {
      print('🔵 Processing native image: $imagePath');
      File? tempUserFile;

      if (config.compressQuality < 100) {
        final result = await FlutterImageCompress.compressAndGetFile(
          imagePath,
          FileUtil().generateImageUuidJpgPath(),
          quality: config.compressQuality,
        );
        if (result != null) {
          tempUserFile = File(result.path);
          print('🔵 Image compressed: ${tempUserFile.path}');
        }
      } else {
        tempUserFile = File(imagePath);
        print('🔵 Using original image: ${tempUserFile.path}');
      }

      return tempUserFile;
    } catch (e) {
      print('🔵 Error processing native image: $e');
      config.onError?.call(e.toString());
      return null;
    }
  }
}