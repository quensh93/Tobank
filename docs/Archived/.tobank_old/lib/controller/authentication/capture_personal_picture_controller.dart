// capture_personal_picture_controller.dart
import 'dart:async';
import 'package:universal_io/io.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CapturePersonalPictureController extends GetxController {
  CapturePersonalPictureController({required this.returnDataFunction});

  CameraController? cameraController;
  Future<void>? initializeControllerFuture;
  final Function(File file) returnDataFunction;
  FlashMode flashMode = FlashMode.off;
  List<CameraDescription> cameras = [];
  CameraDescription? currentCamera;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await initCamera();
    } catch (e) {
      print('Camera initialization error in onInit: $e');
      showCameraError('Failed to initialize camera');
    }
  }

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw CameraException('No cameras', 'No cameras available on device');
      }

      // First try to get back camera for national ID card capture
      CameraDescription? selectedCamera;

      try {
        selectedCamera = cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.back,
        );
      } catch (_) {
        try {
          selectedCamera = cameras.firstWhere(
                (camera) => camera.lensDirection == CameraLensDirection.external,
          );
        } catch (_) {
          selectedCamera = cameras.first;
          print('Using fallback camera: ${selectedCamera.name}');
        }
      }

      if (selectedCamera == null) {
        throw CameraException('Camera Selection', 'Failed to select a camera');
      }

      currentCamera = selectedCamera;
      await _initCameraController(selectedCamera);

    } on CameraException catch (e) {
      print('CameraException: ${e.code} - ${e.description}');
      showCameraError('Camera error: ${e.description}');
      rethrow;
    } catch (e) {
      print('General camera error: $e');
      showCameraError('Failed to setup camera');
      rethrow;
    }
  }

  Future<void> _initCameraController(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController!.dispose();
    }

    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );

    initializeControllerFuture = cameraController?.initialize();
    await initializeControllerFuture;

    update();
  }

  Future<void> switchCamera() async {
    try {
      if (cameras.length < 2) {
        showCameraError('No alternative camera available');
        return;
      }

      // Find the index of current camera
      int currentIndex = cameras.indexOf(currentCamera!);

      // Switch to next camera in the list
      int nextIndex = (currentIndex + 1) % cameras.length;
      currentCamera = cameras[nextIndex];

      // Re-initialize with the new camera
      await _initCameraController(currentCamera!);

      print('Switched to camera: ${currentCamera!.name}');

    } catch (e) {
      print('Error switching camera: $e');
      showCameraError('Failed to switch camera');
    }
  }

  @override
  void onClose() {
    try {
      final controller = cameraController;
      if (controller != null && controller.value.isInitialized) {
        controller.dispose();
      }
    } catch (e) {
      print('Error disposing camera: $e');
    } finally {
      super.onClose();
      Get.closeAllSnackbars();
    }
  }

  Future<void> takePicture() async {
    try {
      final controller = cameraController;
      if (controller?.value.isInitialized ?? false) {
        final file = await controller?.takePicture();
        if (file != null) {
          Get.back();
          returnDataFunction(File(file.path));
        }
      }
    } catch (e) {
      print('Error taking picture: $e');
      showCameraError('Failed to take picture');
    }
  }

  Future<void> toggleFlash() async {
    try {
      final controller = cameraController;
      if (controller?.value.isInitialized ?? false) {
        final newMode = controller!.value.flashMode == FlashMode.off
            ? FlashMode.torch
            : FlashMode.off;

        await controller.setFlashMode(newMode);
        flashMode = newMode;
        update();
      }
    } catch (e) {
      print('Error toggling flash: $e');
      showCameraError('Failed to toggle flash');
    }
  }

  void showCameraError(String message) {
    Get.snackbar(
      'Camera Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}